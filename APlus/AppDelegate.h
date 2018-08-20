//
//  AppDelegate.h
//  APlus
//
//  Created by sujp on 2017/9/6.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLLockVC.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>

@protocol MessageChangeDelegate <NSObject>

@optional
- (void)networkStatusChanged:(BOOL)isReachable;
- (void)loadAnimationSuccess;
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    BaseTabBarController *_tabBarController;
    CustomPanNavigationController *_loginNav;
    UIWindow *_loadingWindow;   // 启动动画
    UIWindow *_guideWindow;     // 新手教程
    UIWindow *_inputPwdWindow;  // 输入密码window
    
    CLLockVC *_clLockVC;        // 手势密码视图
    BOOL _isResetGesture;

    BMKMapManager *_mapManager; // 百度地图
}

@property (strong, nonatomic) UIWindow *window;

// 检查是否需要倒计时解锁
@property (nonatomic, assign) BOOL isForceUnLock;

// 网络连接成功
@property (nonatomic, assign) BOOL reachableNetwork;

@property (nonatomic, weak) id <MessageChangeDelegate> messageChangeDelegate;

@end

