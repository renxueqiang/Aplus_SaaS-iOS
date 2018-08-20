//
//  CustomPanNavigationController.m
//  FangYouQuan
//
//  Created by sujp on 2017/7/5.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "CustomPanNavigationController.h"

@interface CustomPanNavigationController ()

@end

@implementation CustomPanNavigationController

- (id)initWithRootViewController:(UIViewController *)rootViewController
{

    CustomPanNavigationController *cusNVC = [super initWithRootViewController:rootViewController];
    self.hidesBottomBarWhenPushed = YES;
    if (MODEL_VERSION >= 7.0)
    {
        self.interactivePopGestureRecognizer.delegate = self;
//        self.hidesBottomBarWhenPushed = YES;
    }
    cusNVC.delegate = self;
    
    return cusNVC;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    BaseTabBarController *baseTabBar = (BaseTabBarController *)self.tabBarController;

    NSArray *vcArr = navigationController.viewControllers;
    if (vcArr.count > 1) {
        [baseTabBar hideTabBarView];
    }
    else
    {
        [baseTabBar showTabBarView];
    }
}

// 解决rootViewController滑动返回手势也会触发的问题
- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (navigationController.viewControllers.count == 1)
    {
        self.currentShowVC = Nil;
    }
    else
    {
        self.currentShowVC = viewController;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    // 当前controller是否是根controller
    if (gestureRecognizer == self.interactivePopGestureRecognizer)
    {
        return (self.currentShowVC == self.topViewController);
    }
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
