//
//  AppDelegate+AppService.h
//  APlus
//
//  Created by 张旺 on 2017/9/30.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (AppService)

/// 首次安装App
- (void)installationForTheFirstTime;

/// 配置接口
- (void)setAPIConfigure;

/// 配置第三方资源
- (void)setThirdPartyWithOptions:(NSDictionary *)launchOptions;

/// 监听网络状态
- (void)observeNetWorkState;

/// 创建数据库
- (void)createAPlusDB;

@end
