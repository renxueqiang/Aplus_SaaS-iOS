//
//  DiscoverViewController.m
//  APlus
//
//  Created by sujp on 2017/9/18.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "HomePageVC.h"
#import "ADView.h"
#import "HeadView.h"
#import "ModuleCollectionView.h"
#import "RankingFirstCell.h"
#import "RankingCell.h"
#import "NewPropertyCell.h"
#import "SearchVC.h"

#define ModuleViewTag           100
#define SecondViewBtnBaseTag    1000

@interface HomePageVC () <UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,
ResponseDelegate,ClickNewPropDelegate>
{
    ADView *_adView;
    UIView *_shadowView;
    UITableView *_mainTableView;
    ModuleCollectionView *_moduleView;
    HeadView *_headView;
    UIView *_titleView;

    NSArray *_textArr;
}
@end

@implementation HomePageVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self navBarNeedHidden:YES
              andAnimation:YES];

    // 手势密码视图消失
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loadADView:)
                                                 name:@"GesDismiss"
                                               object:nil];

    [self initAdView];
    [self initView];

    // 获取首页模块数据
    //    [self requestData];
    _textArr = @[@"测试新上房源1",@"测试新上房源2",@"测试新上房源3",@"测试新上房源4",@"测试新上房源5"];

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // 设置电池条为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

    _mainTableView.contentOffset = CGPointZero;
}

#pragma mark - ObserveValueForKeyPath

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:UserLoginSuccess])
    {

        if ([[change objectForKey:@"new"] intValue] == 1)
        {
            // 登录成功，检查服务端版本号，看是否需要更新版本
        }
    }
}

#pragma mark - Notification

/// 广告视图
- (void)loadADView:(NSNotification *)notifi
{
    [self isNeedShowAdvert:YES];
}

#pragma mark - init

- (void)initAdView
{
    _shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT)];
    _shadowView.backgroundColor = [UIColor blackColor];
    _shadowView.alpha = 0.6;

    // 广告页
    _adView = [[ADView alloc] initWithFrame:CGRectMake(10, 50, APP_SCREEN_WIDTH - 20, APP_SCREEN_HEIGHT - 100)];
    [_adView.cancelBtn addTarget:self action:@selector(cancelAdAction:) forControlEvents:UIControlEventTouchUpInside];

    AppDelegate *appDelegate = [self sharedAppDelegate];
    [appDelegate.window addSubview:_shadowView];
    [appDelegate.window addSubview:_adView];
    _shadowView.hidden = YES;
    _adView.hidden = YES;
}

- (void)initView
{
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT - APP_TAR_HEIGHT)
                                                  style:UITableViewStylePlain];
    _mainTableView.showsVerticalScrollIndicator  = NO;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_mainTableView];

    _headView = [[HeadView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 165)];
    [_headView.searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [_headView.scanBtn addTarget:self action:@selector(scanAction:) forControlEvents:UIControlEventTouchUpInside];
    _mainTableView.tableHeaderView = _headView;

    if (@available(iOS 11.0, *))
    {
        _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else
    {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }

    // TitleView
    CGFloat height = APP_NAV_HEIGHT;
    _titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, height)];
    _titleView.backgroundColor = AppBackgroundColor;
    UIButton *searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    searchBtn.frame = CGRectMake(30, height - 44, APP_SCREEN_WIDTH - 60, 30);
    searchBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [searchBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    searchBtn.backgroundColor = [UIColor whiteColor];
    [searchBtn setLayerCornerRadius:15];
    [searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [searchBtn setTitle:@"  请输入城区、片区、楼盘名" forState:UIControlStateNormal];
    [searchBtn addTarget:self action:@selector(searchAction:) forControlEvents:UIControlEventTouchUpInside];
    [_titleView addSubview:searchBtn];
    [self.view addSubview:_titleView];
    _titleView.alpha = 0;
}

#pragma mark - 是否显示广告

- (void)isNeedShowAdvert:(BOOL)isNeed
{
    if (isNeed)
    {
        [UIView animateWithDuration:0.1 animations:^{
            _shadowView.hidden = NO;
            _adView.hidden = NO;
        }];
    }
    else
    {
        _shadowView.hidden = YES;
        _adView.hidden = YES;
    }
}

#pragma mark - Button Action

/// 去除广告
- (void)cancelAdAction:(UIButton *)btn
{
    [self isNeedShowAdvert:NO];
}

/// 跳转搜索
- (void)searchAction:(UIButton *)btn
{
    SearchVC *searchVC = [[SearchVC alloc] init];
    [self.navigationController pushViewController:searchVC animated:YES];
}

/// 扫一扫
- (void)scanAction:(UIButton *)btn
{
    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:1];
    [_mainTableView reloadRowsAtIndexPaths:@[indexpath] withRowAnimation:UITableViewRowAnimationNone];
}

/// 点击广告管理或其他
- (void)eventAction:(UIButton *)btn
{
    NSString *titleStr = btn.titleLabel.text;
    if ([titleStr isEqualToString:@"广告管理"])
    {

    }
    else if ([titleStr isEqualToString:@"录客户"])
    {

    }
}

#pragma mark - <ClickNewPropDelegate>
- (void)clickNewPropWithIndex:(NSInteger)index
{
    NSLog(@"%ld",(long)index);
}


#pragma mark - <ScrollViewDelagete>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UITableView class]])
    {
        CGFloat yOfSet = scrollView.contentOffset.y;
        CGFloat contentOffset = 140;
        if (yOfSet < 0)
        {
            // 橡皮筋效果
            CGFloat nowHeight = 140 - yOfSet;
            CGFloat nowWidth = APP_SCREEN_WIDTH * (nowHeight / 140);

            _headView.bgImgView.y = yOfSet;
            _headView.bgImgView.height = nowHeight;
            _headView.bgImgView.width = nowWidth;
            _headView.bgImgView.x = (APP_SCREEN_WIDTH - nowWidth) / 2;

            _headView.cityView.y = STATUS_BAR_HEIGHT + 10 + yOfSet;
            _headView.scanBtn.y = STATUS_BAR_HEIGHT + 10 + yOfSet;

            CGFloat width = 50 * (nowWidth / APP_SCREEN_WIDTH);
            _headView.logoImgView.frame = CGRectMake((APP_SCREEN_WIDTH - width) / 2, 60 + yOfSet, width, width);
        }
        else
        {
            // 隐藏／显示导航栏
            float alpha = 1 - ((contentOffset - yOfSet) / contentOffset);
            if (alpha > 0.5)
            {
                _headView.searchBtn.hidden = YES;
                _titleView.hidden = NO;
                // 设置电池条为黑色
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];
            }
            else
            {
                _headView.searchBtn.hidden = NO;
                _titleView.hidden = YES;
                // 设置电池条为白色
                [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
            }

            _titleView.alpha = alpha;
        }
    }
}

#pragma mark - <UITableViewDelegate/UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 3)
    {
        return 11;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 0 || section == 3)
    {
        return 0;
    }
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1)
    {
        return 50;
    }
    else if (indexPath.section == 2)
    {
        return 80;
    }
    else if (indexPath.section == 3)
    {
        if (indexPath.row == 0)
        {
            return 170;
        }
        return 44;
    }
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0)
    {
        _moduleView = [cell.contentView viewWithTag:100];
        if (_moduleView == nil)
        {
            CGFloat spaceWidth = (APP_SCREEN_WIDTH - 4 * 80) / 5;
            UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
            flowLayOut.itemSize = CGSizeMake(80, 100);
            flowLayOut.minimumLineSpacing = 0;
            flowLayOut.minimumInteritemSpacing = spaceWidth;
            flowLayOut.scrollDirection = UICollectionViewScrollDirectionVertical;
            _moduleView = [[ModuleCollectionView alloc] initWithFrame:CGRectMake(spaceWidth, 0, APP_SCREEN_WIDTH - spaceWidth * 2, 200)
                                                 collectionViewLayout:flowLayOut];
            _moduleView.tag = 100;
            [cell.contentView addSubview:_moduleView];
        }
    }
    else if (indexPath.section == 1)
    {
        NSString *identifier = @"NewPropertyCell";
        NewPropertyCell *firstCell = (NewPropertyCell *)[tableView cellFromXib:identifier];
        firstCell.marqueeView.delegate = self;
        firstCell.propertyNewArr = _textArr;
        return firstCell;
    }
    else if (indexPath.section == 2)
    {
        UIScrollView *secondView = [cell.contentView viewWithTag:111];
        if (secondView == nil)
        {
            secondView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 80)];
            secondView.tag = 111;
            secondView.showsHorizontalScrollIndicator = NO;
            secondView.contentSize = CGSizeMake(200 * 8, 80);
            // 假数据
            for (int i = 0; i < 5; i++)
            {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.tag = SecondViewBtnBaseTag + i;
                btn.frame = CGRectMake(20 + 100 * i, 10, 100, 60);
                [btn setImage:[UIImage imageNamed:@"ad"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(eventAction:) forControlEvents:UIControlEventTouchUpInside];
                [secondView addSubview:btn];
            }
            [cell.contentView addSubview:secondView];
        }

    }
    else if (indexPath.section == 3)
    {
        if (indexPath.row == 0)
        {
            RankingFirstCell *firstCell = (RankingFirstCell *)[tableView cellFromXib:@"RankingFirstCell"];
            return firstCell;
        }
        else
        {
            RankingCell *rankingCell = (RankingCell *)[tableView cellFromXib:@"RankingCell"];
            [rankingCell fillDataWithArray:nil AndRow:indexPath.row];
            return rankingCell;

        }
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 15, 0, 15)];
    }

    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsMake(0, 15, 0, 15)];
    }
}

/// 请求工具使用示范
- (void)requestData
{
    RequestManager *manager = [RequestManager defaultManager:self];
    [manager setInterceptorForSuc:[[DataConvertInterceptor alloc]init]];

    HKCommonApi *api = [[HKCommonApi alloc] init];
    api.configType = @"3";
    api.length = @"100";


    [manager sendRequest:api sucBlock:^(CentaResponse *result)
    {
        if(!result.suc)
        {
            NSLog(@"%@", result.msg);
            return;
        }

        CityConfigEntity *entity = result.data;

        //        NSInteger code = entity.rCode;
        //        NSString *msg = entity.rMessage;

    } failBlock:^(CentaResponse *error)
    {

    }];

    //        [manager sendRequest:api];
}

#pragma mark - <ResponseDelegate>

- (void)respSuc:(CentaResponse *)resData
{
}

- (void)respFail:(CentaResponse *)error
{
}

@end
