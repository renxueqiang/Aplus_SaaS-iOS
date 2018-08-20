//
//  AppDelegate+ViewController.h
//  APlus
//
//  Created by 张旺 on 2017/9/30.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "AppDelegate.h"
#import "LoadingVC.h"
#import "AlertInputPwdView.h"
#import "LoginVC.h"

@interface AppDelegate (ViewController)<AlertInputPwdViewDelegate>

/// window实例
- (void)setAppWindows;

/// 设置根视图
- (void)setRootViewController;

/// 检查是否需要登陆
- (void)appLaunchLogin;

/// 是否弹出登陆页面
- (void)changeDiscoverRootVCIsLogin:(BOOL)isLogin;

/// 创建登录页面
- (void)createLoginNav;

/// 设置手势密码
- (void)setGestureView;

/// 验证手势密码
- (void)validGestureView;

/// 是否要显示输入密码
- (void)showInputPwd:(BOOL)isShowColse;

/// 添加启动页动画
- (LoadingVC *)addLoadingView;

/// 隐藏启动动画
- (void)hiddenLoaingWindow;

@end
