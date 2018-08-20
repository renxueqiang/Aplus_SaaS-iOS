//
//  AppDelegate+AppService.m
//  APlus
//
//  Created by 张旺 on 2017/9/30.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "AppDelegate+AppService.h"
#import "UserGuideVC.h"
#import "Reachability.h"
#import "ServiceDefine.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <AdSupport/AdSupport.h>
#import "JPUSHService.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import <iflyMSC/iflyMSC.h>
#import "Growing.h"


@implementation AppDelegate (AppService)

#pragma mark - 首次安装App

- (void)installationForTheFirstTime
{
    // 是否开启显示聊天的开关
    NSString *curAppVerson = [[NSUserDefaults standardUserDefaults] stringForKey:CurrentAppVerson];

    // 首次安装APP
    if (!curAppVerson || [curAppVerson isEqualToString:@""])
    {
        // 默认打开聊天入口
        [CommonMethod setUserdefaultWithValue:[NSNumber numberWithBool:YES] forKey:ShowChatIcon];

        // 默认开启消息提醒
        [CommonMethod setUserdefaultWithValue:[NSNumber numberWithBool:YES] forKey:EnableNotify];

        // 是否仅wifi网络显示图片，默认NO
        [CommonMethod setUserdefaultWithValue:[NSNumber numberWithBool:NO] forKey:ShowImageOnlyWIFI];
    }

    // 欢迎页
    BOOL isShowedWelcomePage = [[[NSUserDefaults standardUserDefaults]objectForKey:ShowWelcomePage] boolValue];
    if (!isShowedWelcomePage)
    {
        [self addAddUserGuideView];
    }
}

#pragma mark -  配置接口

- (void)setAPIConfigure
{
#warning 测试：ApiDomainUtil
    [BaseApiDomainUtil shareApiDomain:[ApiDomainUtil class]];

    //#warning SIM：SimApiDomainUtil
    //    [BaseApiDomainUtil shareApiDomain:[SimApiDomainUtil class]];

    //#warning 正式: FormalApiDomainUtil
    //    [BaseApiDomainUtil shareApiDomain:[FormalApiDomainUtil class]];

}

#pragma mark -  显示新手教程

- (void)addAddUserGuideView
{
    _guideWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _guideWindow.windowLevel = UIWindowLevelStatusBar + 1;

    NSMutableArray *imageArray = [NSMutableArray arrayWithObjects:@"轮播图1",@"轮播图2",@"轮播图3",@"轮播图4", nil];
    UserGuideVC *controlGuide = [[UserGuideVC alloc] initWithArrayGuideImage:imageArray];
    _guideWindow.rootViewController = controlGuide;
    [_guideWindow makeKeyAndVisible];
}

#pragma mark - 配置第三方资源

- (void)setThirdPartyWithOptions:(NSDictionary *)launchOptions
{
    /*
     * IQKeyboardManager:键盘出现时输入框自动上移不遮挡输入框
     */
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    // 控制整个功能是否启用
    keyboardManager.enable = YES;

    /*
     * 极光推送
     */
    // 如不需要使用IDFA，advertisingIdentifier 可为nil
    NSString *advertisingId = [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"JPushConfig" ofType:@"plist"];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    NSString *APP_KEY = dic[@"APP_KEY"];
    BOOL Production = TRUE;
    if ([dic[@"APS_FOR_PRODUCTION"] isEqualToString:@"0"])
    {
        Production = FALSE;
    }
    NSLog(@"APP_KEY = %@,apsForProduction = %d",APP_KEY,Production);
    [JPUSHService setupWithOption:launchOptions appKey:APP_KEY
                          channel:dic[@"CHANNEL"]
                 apsForProduction:Production
            advertisingIdentifier:advertisingId];

    /*
     * 友盟分享
     */
    [UMSocialData setAppKey:UMAppKey];
    [UMSocialData openLog:NO];


    /*
     * 微信
     */
    [UMSocialWechatHandler setWXAppId:WeixinAppKey
                            appSecret:WeixinAppSecret
                                  url:nil];

    /*
     * 百度地图
     */
    _mapManager = [[BMKMapManager alloc]init];
    [_mapManager start:BaiduMapAppKey generalDelegate:nil];


    /*
     * 科大讯飞
     */
    // 设置sdk的log等级，log保存在下面设置的工作路径中
    [IFlySetting setLogFile:LVL_NONE];

    // 打开输出在console的log开关
    [IFlySetting showLogcat:NO];

    NSString *IFlySpeechInitStr = [NSString stringWithFormat:@"appid=%@",IFlySpeechAppId];
    [IFlySpeechUtility createUtility:IFlySpeechInitStr];


    /*
     * GrowingIO
     */
    // 启动GrowingIO
    [Growing startWithAccountId:GrowingIOKey];
    // 其他配置
    // 开启Growing调试日志 可以开启日志
    // [Growing setEnableLog:YES];


}


#pragma mark - 监听网络状态

- (void)observeNetWorkState
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    __weak typeof (self) weakSelf = self;
    Reachability *reach = [Reachability reachabilityWithHostname:SERVER_IP];
    reach.reachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf handleNetworkStatusChanged:[reachability isReachable]];
        });
    };

    reach.unreachableBlock = ^(Reachability * reachability)
    {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf handleNetworkStatusChanged:[reachability isReachable]];
        });
    };

    [reach startNotifier];
}

- (void)reachabilityChanged:(NSNotification*)note
{
    Reachability *reach = [note object];
//    NetworkStatus currentNetworkStatus = [reach currentReachabilityStatus];
//    NSLog(@"当前网络状态------%ld",currentNetworkStatus);
    [self handleNetworkStatusChanged:[reach isReachable]];
}

- (void)handleNetworkStatusChanged:(BOOL)isReachable
{
    self.reachableNetwork = isReachable;

    if (self.messageChangeDelegate &&  [self.messageChangeDelegate respondsToSelector:@selector(networkStatusChanged:)])
    {
        [self.messageChangeDelegate networkStatusChanged:isReachable];
    }
}


#pragma mark - 创建数据库
- (void)createAPlusDB
{
    DataBaseManager *dbManager = [DataBaseManager shareDataBaseManager];
    [dbManager createDataBaseMethod];
}

@end
