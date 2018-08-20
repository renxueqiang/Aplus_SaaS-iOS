//
//  BaseViewController.m
//  APlus
//
//  Created by sujp on 2017/9/7.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "BaseViewController.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface BaseViewController ()
{
    /// 是否需要隐藏导航栏
    BOOL _needHiddenNavBar;
    
    /// 是否需要动画隐藏导航栏
    BOOL _hiddenNavBarAnimation;
    
    /// 加载中提示
    MBProgressHUD *_progressHUD;
}

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 取消导航栏模糊层
    self.navigationController.navigationBar.translucent = NO;
    
    // 默认不隐藏导航栏
    _needHiddenNavBar = NO;
    _hiddenNavBarAnimation = YES;
    
    _manager = [RequestManager defaultManager:self];
    [_manager setInterceptorForSuc:[[DataConvertInterceptor alloc] init]];

    self.view.backgroundColor = AppBackgroundColor;
    
    [self unifyLayout];
    
}

- (void)unifyLayout
{
    // 统一iOS 7 和 iOS 6 的布局，是的布局代码统一
    if (MODEL_VERSION >= 7.0)
    {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"horizontalLongSeperator_line"]];
    // 设置电池条字体颜色(如果页面需要变色，单独设置)
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];

    // 处理导航栏是否显示
    [self setNeedHiddenNavBar:_needHiddenNavBar
                 andAnimation:_hiddenNavBarAnimation];

    // tabbar处理，隐藏原生tabbar，使用自定义的
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
}

#pragma mark - SetNavBarItem

- (void)setNavTitle:(NSString *)titleStr
     leftButtonItem:(UIButton *)leftBtn
    rightButtonItem:(UIButton *)rightBtn
{
    self.title = titleStr;

//    UIBarButtonItem *rightBarItem = nil;
    
    if (rightBtn)
    {
        
        UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc]initWithCustomView:rightBtn];
        rightBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [rightBtn setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, -3)];
        
        self.navigationItem.rightBarButtonItem = rightBarItem;
    }
    
 //   UIBarButtonItem *leftBackItem = nil;
    
    if (leftBtn)
    {
        UIBarButtonItem *leftBackItem = [[UIBarButtonItem alloc]initWithCustomView:leftBtn];
        leftBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -3, 0, 0)];
        
        self.navigationItem.leftBarButtonItem = leftBackItem;
    }
}

/// 自定义barItem按钮
- (UIButton *)customBarItemButton:(NSString *)title
                  backgroundImage:(NSString *)bgImg
                       foreground:(NSString *)fgImg
                              sel:(SEL)sel {
    
    UIButton *customBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    UIFont *font = [UIFont fontWithName:FontName size:15.0];
    CGFloat titleWidth = [title getStringWidth:[UIFont fontWithName:FontName size:15.0] Height:44];

    if (!title || [title isEqualToString:@""] || titleWidth < 44)
    {
        titleWidth = 44;
        
    }
    else if (titleWidth >= 50)
    {
        titleWidth = 50;
    }
    
    [customBtn setFrame:CGRectMake(0, 0, titleWidth, 44)];
    [customBtn setBackgroundColor:[UIColor clearColor]];
    [customBtn setTitleShadowColor:[UIColor clearColor]
                          forState:UIControlStateNormal];
    [customBtn.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [customBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    
    if (bgImg)
    {
        UIImage *image = [UIImage imageNamed:bgImg];
        [customBtn setBackgroundImage:image forState:UIControlStateNormal];
    }
    
    if (fgImg)
    {
        [customBtn setImage:[UIImage imageNamed:fgImg]
                   forState:UIControlStateNormal];
    }
    
    if (title)
    {
        [customBtn setTitle:title forState:UIControlStateNormal];
    }
    
    [customBtn.titleLabel setFont:font];
    [customBtn setTitleColor:MainBlackColor forState:UIControlStateNormal];
    
    if (sel)
    {
        [customBtn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    }

    return customBtn;
}

/// 返回按钮barItem
- (UIButton *)backBarItemBtnWithSel:(SEL)sel
{
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 0, 50, 44)];
    [backBtn setBackgroundColor:[UIColor clearColor]];
    [backBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [backBtn setImage:[UIImage imageNamed:@"navBar_back_btnImg"]
             forState:UIControlStateNormal];

    if (sel)
    {
        [backBtn addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
    }
    
    return backBtn;
}

/// pop、dismiss
- (void)back
{
    NSArray *vcArray = [self.navigationController viewControllers];

    if (vcArray.count > 1)
    {
        // pop
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else
    {
        //dismiss
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/// 获取单例AppDelegate
- (AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}

#pragma mark - MBProgressHUD

- (void)initHUDView
{
    
    UIImageView *hudBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-5, -6, 45, 45)];
    [hudBgImageView setImage:[UIImage imageNamed:@"spinner_outer"]];
    
    CABasicAnimation *animation = [CABasicAnimation   animationWithKeyPath:@"transform.rotation"];
    animation.duration = MAXFLOAT * 0.4;
    animation.additive = YES;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.fromValue = [NSNumber numberWithFloat:0];
    animation.toValue = [NSNumber numberWithFloat:MAXFLOAT];
    animation.repeatCount = MAXFLOAT;
    [hudBgImageView.layer addAnimation:animation forKey:nil];
    
    UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(5, -3, 35, 35)];
    [iconView setImage:[UIImage imageNamed:@"zy_icon"]];
    [iconView addSubview:hudBgImageView];

    [_progressHUD hideAnimated:NO];
    _progressHUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    _progressHUD.mode = MBProgressHUDModeIndeterminate;
    _progressHUD.removeFromSuperViewOnHide = YES;
    iconView.center = _progressHUD.center;
    
    [self.view addSubview:_progressHUD];
}

- (void)showLoadingView:(NSString *)message
{
    [self initHUDView];

    _progressHUD.label.text = message ? message : @"";
    [_progressHUD showAnimated:YES];
}

- (void)hideLoadingView
{
    if (_progressHUD)
    {
        [_progressHUD hideAnimated:YES];
    }
}

#pragma mark - 设置是否需要隐藏导航栏

/// 设置通用属性
- (void)navBarNeedHidden:(BOOL)isHidden
            andAnimation:(BOOL)isAnimation
{
    _needHiddenNavBar = isHidden;
    _hiddenNavBarAnimation = isAnimation;
    
}

/// 设置是否需要隐藏导航栏
- (void)setNeedHiddenNavBar:(BOOL)isHidden
               andAnimation:(BOOL)isAnimation
{
    BOOL isCurNavHidden = self.navigationController.isNavigationBarHidden;
    
    if (isHidden)
    {
        // 导航栏如果已经隐藏，不需要重复设置
        if (!isCurNavHidden)
        {
            [self.navigationController setNavigationBarHidden:isHidden animated:isAnimation];
        }
        
    }
    else
    {
        // 导航栏已经显示，不需要重复设置
        if (isCurNavHidden)
        {
            [self.navigationController setNavigationBarHidden:isHidden animated:isAnimation];
        }
        
    }
}

#pragma mark 创建导航栏搜索

/// 创建搜索框中的语音按钮
-(UIButton *)createVoiceSearchBtnWithSelector:(SEL)selector;
{
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"语音"]
              forState:UIControlStateNormal];
    [rightBtn setBackgroundColor:[UIColor clearColor]];
    [rightBtn addTarget:self
                 action:selector
       forControlEvents:UIControlEventTouchUpInside];
    
    return rightBtn;
}

/// 文字搜索按钮
- (UIButton *)createTextSearchBtnWithSelector:(SEL)selector
{   
    UIButton *textSearchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [textSearchBtn setBackgroundColor:[UIColor clearColor]];
    [textSearchBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    [textSearchBtn setTitleColor:RGBColor(153.0, 153.0, 153.0) forState:UIControlStateNormal];
    [textSearchBtn addTarget:self
                      action:selector
            forControlEvents:UIControlEventTouchUpInside];
    
    return textSearchBtn;
}

/// 创建顶部搜索框
- (void)createTopSearchBarViewWithTextSearchBtn:(UIButton *)textSearchBtn
                                    andRightBtn:(UIButton *)rightBtn
                                 andPlaceholder:(NSString *)placeholder
{
    CGFloat topSearchViewWidth = APP_SCREEN_WIDTH;
    
    if (self.navigationItem.leftBarButtonItems.count > 0 ||
        self.navigationItem.leftBarButtonItem) {
        
        topSearchViewWidth -= 62;
    }
    
    if (self.navigationItem.rightBarButtonItems.count > 0 ||
        self.navigationItem.rightBarButtonItem) {
        
        topSearchViewWidth -= 62;
    }
    
    // titleView
    UIView *topSearchView = [[UIView alloc] init];
    [topSearchView setFrame:CGRectMake(0,
                                       0,
                                       topSearchViewWidth,
                                       30)];
    
    // 默认提示文字
    [textSearchBtn setBackgroundColor:[UIColor clearColor]];
    [textSearchBtn setImage:[UIImage imageNamed:@"search"]
                   forState:UIControlStateNormal];
    [textSearchBtn setTitle:placeholder
                   forState:UIControlStateNormal];
    textSearchBtn.titleLabel.font = [UIFont fontWithName:FontName
                                                    size:13.0];
    [textSearchBtn.titleLabel setLineBreakMode:NSLineBreakByTruncatingTail];
    [textSearchBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    [textSearchBtn setContentEdgeInsets:UIEdgeInsetsMake(0,
                                                         8,
                                                         0,
                                                         0)];
    [textSearchBtn setTitleEdgeInsets:UIEdgeInsetsMake(0,
                                                       10,
                                                       0,
                                                       0)];
    
    UILabel *placeholderLabel = [[UILabel alloc]init];
    placeholderLabel.backgroundColor = [UIColor clearColor];
    placeholderLabel.text = placeholder;
    placeholderLabel.font = [UIFont fontWithName:FontName
                                            size:12.0];
    placeholderLabel.textColor = [UIColor whiteColor];
    
    // 搜索框背景图片imageView
    UIImage *image = [UIImage imageNamed:@"搜索框背景"];
    UIImage *newImage = [image stretchableImageWithLeftCapWidth:image.size.width*0.5 topCapHeight:image.size.height*0.5];
    UIImageView *searchBarBgImage = [[UIImageView alloc]initWithImage:newImage];
    
    [topSearchView addSubview:searchBarBgImage];
    [topSearchView addSubview:rightBtn];
    [topSearchView addSubview:textSearchBtn];
    
    // 添加控件约束
    [searchBarBgImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-2);
        
    }];
    [rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.right.mas_equalTo(0);
        make.centerY.mas_equalTo(-2);
        make.width.mas_equalTo(35);
        make.height.mas_equalTo(30);
    }];
    [textSearchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(-2);
        make.right.equalTo(rightBtn.mas_left).with.offset(-2);
    }];
    
    self.navigationItem.titleView = topSearchView;
}

#pragma mark - <ResponseDelegate>
- (void)respSuc:(CentaResponse *)resData
{
    if (!resData.suc)
    {
        [self hideLoadingView];
        showMsg(resData.msg);
        return;
    }
    else
    {
        [self dealData:resData];
    }

}

- (void)respFail:(CentaResponse *)error
{
    [self hideLoadingView];
    NSString *errorMsg = error.msg;
    showMsg(errorMsg);
    return;
}

- (void)dealData:(CentaResponse *)resData
{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
