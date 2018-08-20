//
//  BaseTabBarController.m
//  APlus
//
//  Created by sujp on 2017/9/6.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "BaseTabBarController.h"
#import "BaseTabBarItemModel.h"
#import "HomePageVC.h"
#import "NewsVC.h"
#import "WorkVC.h"
#import "MineVC.h"
#import "CheckVersonUtils.h"
#import "PermissionApi.h"
#import "PersonalInfoEntity.h"

#define BasicBtnTag                 1000
#define BasicItemImageTag           2000
#define BasicItemTitleTag           3000

#define ForceUpdateAlertTag         5000    // 强制版本更新提示框
#define NormalUpdateAlertTag        6000    // 正常版本更新提示框


#define ComTabBarNormalLabelBlack   [UIColor colorWithRed:51.0 / 255.0 green:51.0 / 255.0 blue:51.0 / 255.0 alpha:1.0f]

static BaseTabBarController *customTabBar = nil;

@interface BaseTabBarController ()<ResponseDelegate,UIAlertViewDelegate>
{
    
    /// barItemArr
    NSMutableArray *_barItemArr;
    
    /// barVC
    NSMutableArray *_barVCArr;
    
    /// cusBarView
    UIView *_cusBarView;
    
    /// 当前选择的index
    NSInteger _currentSelectItemTag;
    
    /// 选中tabBar的color
    UIColor *_barSelectColor;

    RequestManager *_manager;

    BOOL _hasRequest;
    
}

@end

@implementation BaseTabBarController

///共享tabbar单例
+ (BaseTabBarController *)shareTabBarController
{
    @synchronized (self)
    {
        
        if (customTabBar == nil)
        {
            customTabBar = [[self alloc] init];

            // 移除系统控制器
            [customTabBar.tabBar removeFromSuperview];

            // 添加自己子控制器
            [customTabBar addChildVC];
        }
    }
    
    return customTabBar;
}

- (void)addChildVC {
    HomePageVC *homePageVC = [[HomePageVC alloc] initWithNibName:@"HomePageVC" bundle:nil];
    NewsVC *newsVC = [[NewsVC alloc] initWithNibName:@"NewsVC" bundle:nil];
    WorkVC *workVC = [[WorkVC alloc] initWithNibName:@"WorkVC" bundle:nil];
    MineVC *mineVC = [[MineVC alloc] initWithNibName:@"MineVC" bundle:nil];
    BaseViewController *centerVC = [[BaseViewController alloc] init];

    CustomPanNavigationController *homePageNav = [self customControllerWithRootVC:homePageVC];
    CustomPanNavigationController *newsNav = [self customControllerWithRootVC:newsVC];
    CustomPanNavigationController *workNav = [self customControllerWithRootVC:workVC];
    CustomPanNavigationController *mineNav = [self customControllerWithRootVC:mineVC];
    CustomPanNavigationController *centerNav = [self customControllerWithRootVC:centerVC];

    NSArray *barTitleArr = @[@"首页",@"消息",@"拍照",@"工作",@"我的"];
    NSMutableArray *barItemArr = [NSMutableArray new];
    for (int i = 0; i < barTitleArr.count; i++)
    {
        NSString *titleStr = barTitleArr[i];
        BaseTabBarItemModel *tabBarModel = [BaseTabBarItemModel initWithBarItemName:titleStr
                                                                  andBarSelectColor:MainRedColor
                                                                andBarNormalImgName:titleStr
                                                                andBarSelectImgName:[NSString stringWithFormat:@"%@-ele",titleStr]];
        [barItemArr addObject:tabBarModel];
    }

    BaseTabBarController *tabBarController = [BaseTabBarController shareTabBarController];
    [tabBarController loadTabBarWithItem:barItemArr
                                andBarVC:@[homePageNav,newsNav,centerNav,workNav,mineNav]
                      andSelectItemColor:MainRedColor];

    [barItemArr removeAllObjects];
    barItemArr = nil;
}

- (id)customControllerWithRootVC:(UIViewController *)root
{
    CustomPanNavigationController *customNav = [[CustomPanNavigationController alloc] initWithRootViewController:root];
    [customNav.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBar_bg"] forBarMetrics:UIBarMetricsDefault];
    return customNav;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    // 监听是否有未读消息
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(checkUnreadMessage)
                                                 name:UnreadNotification
                                               object:nil];

    // 监听是否登录成功
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didReceiveLoginSuccessNotification:)
                                                 name:LoginSuccessNotification
                                               object:nil];

    _manager = [RequestManager defaultManager:self];
    [_manager setInterceptorForSuc:[[DataConvertInterceptor alloc]init]];
    _hasRequest = NO;

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (_hasRequest == NO)
    {
        _hasRequest = YES;

        // 检查版本更新
        [self checkAppVerson];

        // 请求登录用户个人信息
        [self requestUserInfo];
    }
}

#pragma mark - Request

/// 请求版本更新
- (void)checkAppVerson
{
    CheckVersonUtils *checkVerson = [CheckVersonUtils shareCheckVersonUtils];
    checkVerson.isShowErrorAlert = NO;
    [checkVerson checkAppVerson];
}

/// 请求个人资料
- (void)requestUserInfo
{
    NSString *userCityCode = [[NSUserDefaults standardUserDefaults]stringForKey:CityCode];
    NSString *staffNo = [[NSUserDefaults standardUserDefaults]stringForKey:UserStaffNumber];

    GetPersonalApi *getPersonalApi = [[GetPersonalApi alloc] init];
    getPersonalApi.staffNo = staffNo;
    getPersonalApi.cityCode = userCityCode;
    [_manager sendRequest:getPersonalApi];
}

#pragma mark - Notification

// 登录成功，跳首页
- (void)didReceiveLoginSuccessNotification:(NSNotification *)notification
{
    BaseTabBarController *basetarBar = [BaseTabBarController shareTabBarController];
    [basetarBar setSelectedIndex:0];
}

// 检查未读消息
- (void)checkUnreadMessage
{

    BOOL officalMsg = [[NSUserDefaults standardUserDefaults]boolForKey:OfficalMessageRemind];
    BOOL propMsg = [[NSUserDefaults standardUserDefaults] boolForKey:PropMessageRemind];
    BOOL customerMsg = [[NSUserDefaults standardUserDefaults]boolForKey:CustomerMessageRemind];
    BOOL dealMsg = [[NSUserDefaults standardUserDefaults]boolForKey:DealMessageRemind];
    BOOL privateMsg = [[NSUserDefaults standardUserDefaults] boolForKey:PrivateMessageRemind];

#warning text--
    if (officalMsg || propMsg || customerMsg || dealMsg || privateMsg)
    {
//        [self.tabBar showBadgeOnItemIndex:1];
    }
    else
    {
//        [self.tabBar hideBadgeOnItemIndex:1];
    }
}

#pragma mark - ObserveValueForKeyPath

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context
{
    if ([keyPath isEqualToString:UserLoginSuccess])
    {
        if ([[change objectForKey:@"new"] intValue] == 1)
        {
            // 登录成功，检查服务端版本号，看是否需要更新版本
//            [self checkAppVerson];
        }
    }
}

#pragma mark - 自动跳转到某个index

- (void)setCurrentSelectIndex:(NSInteger)currentSelectIndex
{
    UIButton *currentBtn = (UIButton *)[self.view viewWithTag:BasicBtnTag + currentSelectIndex];
    
    [self selectItemWithClick:BasicBtnTag + 1];
    [self changeViewController:currentBtn];
}


#pragma mark - LoadTabBar

- (void)initData
{
    _barItemArr = [NSMutableArray new];
    _barVCArr = [NSMutableArray new];
}

/// 初始化tabbar
- (void)loadTabBarWithItem:(NSArray *)barItems
                  andBarVC:(NSArray *)barVC
        andSelectItemColor:(UIColor *)selectColor
{
    [self initData];
    
    [_barItemArr addObjectsFromArray:barItems];
    
    _barSelectColor = selectColor;
    
    if (barVC.count > 0 && barItems.count > 0)
    {
        self.viewControllers = barVC;
        
        [self loadCusTabBarView];
    }
}

/// 加载自定义tabbar
- (void)loadCusTabBarView
{
    /*
     bar层级关系:
     _cusBarView
     barImage
     barItemView
     barItem
     barItemLabel
     barButton
     */
    
    // 防止重新添加
    [_cusBarView removeFromSuperview];

    _cusBarView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                          APP_SCREEN_HEIGHT - APP_TAR_HEIGHT,
                                                          APP_SCREEN_WIDTH,
                                                          APP_TAR_HEIGHT)];
    _cusBarView.backgroundColor = [UIColor whiteColor];
    
    UIButton *bottomBigView = [UIButton buttonWithType:UIButtonTypeCustom];
    bottomBigView.backgroundColor = MainRedColor;
    [self.view addSubview:bottomBigView];

    // tab阴影
    _cusBarView.layer.shadowColor = [UIColor grayColor].CGColor;
    _cusBarView.layer.shadowRadius = 3;
    _cusBarView.layer.shadowOpacity = 0.3;

    
    // tabBarImgView
    UIImageView *barBgImg = [[UIImageView alloc]initWithFrame:_cusBarView.bounds];
    [barBgImg setImage:[UIImage imageNamed:@"tabBar_bgImg"]];
    [_cusBarView addSubview:barBgImg];
    
    // addBarItem
    NSInteger barItemCount = _barItemArr.count;
    for (int i = 0; i < barItemCount; i++)
    {
        [_cusBarView addSubview:[self getBarItemWithIndex:i]];

    }
    [self.view addSubview:_cusBarView];

    // 默认选择第一个tabBar
    _currentSelectItemTag = BasicBtnTag;
    [self selectItemWithClick:_currentSelectItemTag];
}


/// 获取barItems
- (UIView *)getBarItemWithIndex:(NSInteger)barIndex
{
    CGFloat barItemWidth = APP_SCREEN_WIDTH / _barItemArr.count;
    
    UIView *barItemView = [[UIView alloc] init];
    
    [barItemView setFrame:CGRectMake(barItemWidth * barIndex, 0, barItemWidth, APP_TAR_HEIGHT)];
    
    [barItemView setBackgroundColor:[UIColor clearColor]];

    // 当前barItem实体
    BaseTabBarItemModel *curBarItem = _barItemArr[barIndex];
    
    // tabBarItem图标
    UIButton *barImgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGRect rect;
    if (barIndex != 2)
    {
        rect = CGRectMake(barItemWidth / 2 - 12, 8, 24, 24);
    }
    else
    {
        rect = CGRectMake(barItemWidth / 2 - 25, 0, 50, 33);
    }
    [barImgButton setFrame:rect];
    barImgButton.tag = BasicItemImageTag + barIndex;
    [barImgButton setBackgroundColor:[UIColor clearColor]];
    barImgButton.userInteractionEnabled = NO;
    [barImgButton setBackgroundImage:[UIImage imageNamed:curBarItem.barNormalImgName] forState:UIControlStateNormal];
    [barImgButton setBackgroundImage:[UIImage imageNamed:curBarItem.barSelectImgName] forState:UIControlStateSelected];

    // tabBarItem标题
    UILabel *barItemLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 35, barItemWidth, 11)];
    barItemLabel.tag = BasicItemTitleTag + barIndex;
    barItemLabel.backgroundColor = [UIColor clearColor];
    barItemLabel.font = [UIFont systemFontOfSize:10.0];
    barItemLabel.textAlignment = NSTextAlignmentCenter;
    barItemLabel.text = curBarItem.barItemName;

    // tabBarItem背景
    UIButton *barBgImgButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [barBgImgButton setFrame:CGRectMake(0,0,barItemWidth,APP_TAR_HEIGHT)];
    barBgImgButton.tag = BasicBtnTag + barIndex;
    [barBgImgButton addTarget:self
                       action:@selector(changeViewController:)
             forControlEvents:UIControlEventTouchUpInside];
    
    [barItemView addSubview:barBgImgButton];
    [barItemView addSubview:barImgButton];
    [barItemView addSubview:barItemLabel];

    return barItemView;
}

/// 切换tabBarVC
- (void)changeViewController:(UIButton *)button
{
    [self selectItemWithClick:button.tag];
    
}

// 根据传进的参数值设置item的高亮状态
- (void)selectItemWithClick:(NSInteger)curItemTag
{
    NSInteger selectedTagIndex = _currentSelectItemTag - BasicBtnTag;
    NSInteger currentTagIndex = curItemTag - BasicBtnTag;
    
    // 切换到当前点击的viewController
    self.selectedIndex = currentTagIndex;
    
    //（取消）上次点击的图片、文字
    UIButton *selectedImgBtn = (UIButton *)[_cusBarView viewWithTag:selectedTagIndex + BasicItemImageTag];
    UILabel *selectedLabel = (UILabel *)[_cusBarView viewWithTag:selectedTagIndex + BasicItemTitleTag];
    UIButton *selectedBgImgBtn = (UIButton *)[_cusBarView viewWithTag:_currentSelectItemTag];
    
    selectedBgImgBtn.selected = NO;
    selectedImgBtn.selected = NO;
    selectedLabel.textColor = ComTabBarNormalLabelBlack;
    
    //（选中）当前点击的图片、文字
    UIButton *currentImgBtn = (UIButton *)[_cusBarView viewWithTag:currentTagIndex + BasicItemImageTag];
    UILabel *currentLabel = (UILabel *)[_cusBarView viewWithTag:currentTagIndex + BasicItemTitleTag];
    UIButton *currentBgImgBtn = (UIButton *)[_cusBarView viewWithTag:curItemTag];

    currentBgImgBtn.selected = YES;
    currentImgBtn.selected = YES;
    currentLabel.textColor = _barSelectColor;
    
    // 设置选中的btnTag
    _currentSelectItemTag = curItemTag;
}

- (void)hideTabBarView
{
    [UIView beginAnimations:nil context:nil];
    [_cusBarView setFrame:CGRectMake(0, APP_SCREEN_HEIGHT, self.tabBar.width, APP_TAR_HEIGHT)];
    [UIView commitAnimations];
}

- (void)showTabBarView
{
    [UIView beginAnimations:nil  context:nil];
    [_cusBarView setFrame:CGRectMake(0, APP_SCREEN_HEIGHT - APP_TAR_HEIGHT, self.tabBar.width, APP_TAR_HEIGHT)];
    [UIView commitAnimations];
}


#pragma mark - <ResponseDelegate>

- (void)respSuc:(CentaResponse *)resData
{
    Class modelClass = [resData.api getRespClass];
    if ([modelClass isEqual:[PersonalInfoEntity class]])
    {
        PersonalInfoEntity *staffInfoEntity = resData.data;
        [CommonMethod setUserdefaultWithValue:staffInfoEntity.mobile forKey:APlusUserMobile];
        [CommonMethod setUserdefaultWithValue:staffInfoEntity.departmentName forKey:APlusUserDepartName];
        [CommonMethod setUserdefaultWithValue:staffInfoEntity.position forKey:APlusUserRoleName];
        [CommonMethod setUserdefaultWithValue:staffInfoEntity.photoPath forKey:APlusUserPhotoPath];
    }
}

- (void)respFail:(CentaResponse *)error
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
}

@end
