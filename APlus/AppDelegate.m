//
//  AppDelegate.m
//  APlus
//
//  Created by sujp on 2017/9/6.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "AppDelegate.h"
#import "CheckAppVersonUtil.h"
#import "LoadingVC.h"
#import "AlertInputPwdView.h"

@interface AppDelegate ()<LoadingDelegate,ResponseDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // window实例
    [self setAppWindows];
    
    // 设置根视图
    [self setRootViewController];

    // 首次安装App
    [self installationForTheFirstTime];

    // 检查用户版本
    [CheckAppVersonUtil checkVersonMethod];

    // 配置接口环境
    [self setAPIConfigure];

    // 检查是否需要登录
    [self appLaunchLogin];

    // 添加启动动画
    LoadingVC *loadingVC = [self addLoadingView];
    loadingVC.delegate = self;

    // 添加第三方相关
//    [self setThirdPartyWithOptions:launchOptions];

    // 监听网络状态
    [self observeNetWorkState];

    // 创建数据库
    [self createAPlusDB];

    // 捕获崩溃日志
    NSSetUncaughtExceptionHandler (&UncaughtExceptionHandler);

    return YES;
}

#pragma mark - <LoadingDelegate>

/// 获取系统参数成功
- (void)getSysParamSuccessed
{
    BOOL isLoginSuccess = [[NSUserDefaults standardUserDefaults]boolForKey:UserLoginSuccess];

    [self hiddenLoaingWindow];

    if (!isLoginSuccess)
    {
        [self createLoginNav];
        self.window.rootViewController = _loginNav;
        [self.window makeKeyAndVisible];
    }
    else
    {
        [self.window makeKeyAndVisible];
        [CommonMethod registPushWithState:YES];

        // 从新调用set方法，是为了触发首页的监听，好做登录完成后的处理
        [CommonMethod setUserdefaultWithValue:[NSNumber numberWithBool:YES] forKey:UserLoginSuccess];

        // 验证手势密码是否存在
        BOOL hasPwd = [CLLockVC hasPwd];
        if (hasPwd)
        {
            // 验证手势密码
            [self validGestureView];
        }
        else
        {
            // 设置手势密码
            [self setGestureView];
        }

        // 检查是否倒计时锁定
        BOOL forceLock = [AlertInputPwdView isForceLock];
        if(_isForceUnLock)
        {
            // 不需要倒计时
            forceLock = NO;

            // 改变错误次数
            NSString *ErrorTimesString = [NSString stringWithFormat:@"%d",DefaultErrorTimes];
            [CommonMethod setUserdefaultWithValue:ErrorTimesString forKey:ErrorTimes];

            // 改变错误时间
            [CommonMethod setUserdefaultWithValue:[NSDate dateWithTimeIntervalSince1970:0] forKey:@"APlusPwdErrorTime"];

            // 设置手势密码
            [self setGestureView];

            // 恢复服务器
            RequestManager *manager = [RequestManager defaultManager:self];
            [manager setInterceptorForSuc:[[DataConvertInterceptor alloc] init]];

            ManageLockStatusApi *manageLockStatusApi = [[ManageLockStatusApi alloc] init];
            manageLockStatusApi.ManageAccountLockStatusType = ResetAccountLockStatus;
            [manager sendRequest:manageLockStatusApi];
            return;
        }

        if(forceLock)
        {
            [self showInputPwd:NO];
        }
    }
}


#pragma mark - <ResponseDelegate>

- (void)respSuc:(CentaResponse *)resData
{

}

- (void)respFail:(CentaResponse *)error
{

}

#pragma mark - PrivateMethod

/// 捕获崩溃日志
void UncaughtExceptionHandler(NSException *exception) {

    NSArray *arr = [exception callStackSymbols];//得到当前调用栈信息
    NSString *reason = [exception reason];//非常重要，就是崩溃的原因
    NSString *name = [exception name];//异常类型
    NSLog(@"====================================================================== \n 异常类型 : %@ \n 崩溃原因 : %@ \n 堆栈信息 : %@\n====================================================================== \n"
          ,name, reason, arr);
}

@end
