//
//  AppDelegate+ViewController.m
//  APlus
//
//  Created by 张旺 on 2017/9/30.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "AppDelegate+ViewController.h"
#import "SearchPropertyManager.h"

@implementation AppDelegate (ViewController)

/// window实例
- (void)setAppWindows
{
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = AppBackgroundColor;
    
}

/// 设置根视图
- (void)setRootViewController
{
     _tabBarController = [BaseTabBarController shareTabBarController];
    self.window.rootViewController = _tabBarController;
}

/// 检查是否需要登陆
- (void)appLaunchLogin
{
    [self createLoginNav];

    self.isForceUnLock = NO;

    BOOL isUserLogin = [[NSUserDefaults standardUserDefaults] boolForKey:UserLoginSuccess];

    if (isUserLogin)
    {
        _tabBarController = [BaseTabBarController shareTabBarController];
        self.window.rootViewController = _tabBarController;
    }
    else
    {
        self.window.rootViewController = _loginNav;
    }

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    // 监听用户是否登录成功，用来处理登录成功后首页的数据加载
    [[NSUserDefaults standardUserDefaults] addObserver:_tabBarController
                                            forKeyPath:UserLoginSuccess
                                               options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld
                                               context:nil];
}

/// 创建登录页面
- (void)createLoginNav
{
    NSString *navBgImgName = @"navBarBg_img.png";
    LoginVC *loginVC = [[LoginVC alloc] initWithNibName:@"LoginVC" bundle:nil];

    _loginNav = [[CustomPanNavigationController alloc] initWithRootViewController:loginVC];
    [_loginNav.navigationBar setBackgroundImage:[UIImage imageNamed:navBgImgName]
                                  forBarMetrics:UIBarMetricsDefault];
    [_loginNav.navigationBar setTintColor:[UIColor whiteColor]];
}

/// 是否弹出登陆页面
- (void)changeDiscoverRootVCIsLogin:(BOOL)isLogin
{
    if (isLogin)
    {
        // 需要登录
        [self createLoginNav];
        self.window.rootViewController = _loginNav;
    }
    else
    {
        // 不需登录
        if(!_tabBarController)
        {
            _tabBarController = [[BaseTabBarController alloc] init];
        }

        self.window.rootViewController = _tabBarController;

        // 从新调用set方法，是为了触发首页的监听，好做登录完成后的处理
        [CommonMethod setUserdefaultWithValue:[NSNumber numberWithBool:YES]
                                       forKey:UserLoginSuccess];

        [CommonMethod registPushWithState:YES];

        // 判断跟上次登录用户是否一样
        NSString *lastUserName = [CommonMethod getUserdefaultWithKey:LastStaffNo];
        NSString *userName = [CommonMethod getUserdefaultWithKey:UserStaffNumber];

        NSString *cityCode = [CommonMethod getUserdefaultWithKey:CityCode];
        NSString *lastCityCode = [CommonMethod getUserdefaultWithKey:LastStaffCityCode];

        // 如果不是上次登录用户
        if (![lastUserName isEqualToString:userName])
        {
            // 清空手势密码
            [CLLockVC clearCoreLockPWDKey];
            // 设置手势密码
            [self setGestureView];

             // 清空房源默认搜索条件
            [CommonMethod setUserdefaultWithValue:nil forKey:KeyWord];
            [CommonMethod setUserdefaultWithValue:nil forKey:NameString];
        }

        // 如果跟上次所属城市不一致
        if (![cityCode isEqualToString:lastCityCode]  && lastCityCode != nil)
        {
            // 切换城市城市，清空搜索历史(房源搜索历史+筛选条件)
            SearchPropertyManager *searchManager = [[SearchPropertyManager alloc] init];
            [searchManager deleteAllSearchResult];

#warning text - 清空房源筛选条件

            [CommonMethod setUserdefaultWithValue:nil forKey:NameString];
            [CommonMethod setUserdefaultWithValue:nil forKey:KeyWord];
        }
    }
}

/// 设置手势密码
- (void)setGestureView
{
    BOOL hasPwd = [CLLockVC hasPwd];
    UIViewController *jumpBaseVC;

    if (hasPwd)
    {
        return;
    }

    if (_clLockVC)
    {
        jumpBaseVC = _clLockVC;
    }
    else
    {
        jumpBaseVC = self.window.rootViewController;
    }

    [CLLockVC showSettingLockVCInVC:jumpBaseVC successBlock:^(CLLockVC *lockVC, NSString *pwd){

        NSLog(@"密码设置成功");
        [lockVC dismissNow];

        // 设置手势密码倒计时时间间隔默认为一分钟
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        if(![userDefault objectForKey:AutoGestureLockTimeSpan])
        {
            [CommonMethod setUserdefaultWithValue:@"1" forKey:AutoGestureLockTimeSpan];
        }

        [AlertInputPwdView resetErrorTimes];
        // 验证手势密码
        if (_clLockVC)
        {
            [_clLockVC resetValidPwd];
        }

        // 请求系统参数
        [[NSNotificationCenter defaultCenter] postNotificationName:RequestSystemParamNotification object:nil];

    }
                     isShowNavClose:NO];

}

/// 验证手势密码
- (void)validGestureView
{
    BOOL hasPwd = [CLLockVC hasPwd];
    _isResetGesture = NO;

    if(!hasPwd)
    {
        NSLog(@"你还没有设置密码，请先设置密码");
    }
    else
    {
        _clLockVC = [CLLockVC showVerifyLockVCInVC:self.window.rootViewController forgetPwdBlock:^(CLLockVC *lockVC)
        {
            _isResetGesture = YES;
            [self showInputPwd:YES];
        } successBlock:^(CLLockVC *lockVC, NSString *pwd)
        {
            NSLog(@"密码正确");
            [AlertInputPwdView resetErrorTimes];
            [lockVC dismiss:0.2f];
            _clLockVC = nil;
        } errorLimit:DefaultErrorTimes achieveErrorLimitBlock:^(CLLockVC *lockVC)
        {
            [self showInputPwd:NO];
            _isResetGesture = YES;
        }];
    }

}

/// 输入密码
- (void)showInputPwd:(BOOL)isShowColse
{
    _inputPwdWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT)];

    AlertInputPwdView *customView = [AlertInputPwdView viewFromXib];
    customView.delegate = self;
    customView.frame = CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT);
    [customView showClose:isShowColse];
    [_inputPwdWindow makeKeyAndVisible];
    [_inputPwdWindow addSubview:customView];
}

/// 添加启动页动画
- (LoadingVC *)addLoadingView
{
    CGRect screenBounds = [UIScreen mainScreen].bounds;

    _loadingWindow = [[UIWindow alloc] initWithFrame:screenBounds];
    UIImageView *bgImageView = [[UIImageView alloc]initWithFrame:_loadingWindow.bounds];

    UIImage *logoImage = [UIImage imageNamed:@"ZFLogo.png"];
    UIImageView *logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH / 2 -logoImage.size.width/2,
                                                                               80,
                                                                               logoImage.size.width,
                                                                               logoImage.size.height)];
    [logoImageView setImage:logoImage];

    [_loadingWindow addSubview:bgImageView];
    [_loadingWindow addSubview:logoImageView];

    LoadingVC *loadingVC = [[LoadingVC alloc]initWithNibName:@"LoadingVC"
                                                      bundle:nil];
    _loadingWindow.rootViewController = loadingVC;
    _loadingWindow.windowLevel = UIWindowLevelStatusBar + 1;

    [_loadingWindow makeKeyAndVisible];

    return loadingVC;
}

/// 隐藏启动动画
- (void)hiddenLoaingWindow
{
    __weak UIWindow *weakAdWindow = _loadingWindow;

    [UIView animateWithDuration:0.8 animations:^{
        weakAdWindow.alpha = 0;
    } completion:^(BOOL finished){
        [weakAdWindow removeFromSuperview];
    }];
}


#pragma mark - <AlertInputPwdViewDelegate>

- (void)validSuc
{
    if (_isResetGesture)
    {
        if (_clLockVC)
        {
            // 清空手势密码
            [CLLockVC clearCoreLockPWDKey];
        }
        // 设置新的手势密码
        [self setGestureView];
    }
    else
    {
        [_clLockVC dismissNow];
    }

}

- (void)locked
{
    if(_clLockVC)
    {
        [_clLockVC userInteractionDisEnabled];
    }
}



@end
