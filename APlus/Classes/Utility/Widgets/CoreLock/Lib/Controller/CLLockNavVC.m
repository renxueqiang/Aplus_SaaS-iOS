//
//  CLLockNavVC.m
//  CoreLock
//
//  Created by 成林 on 15/4/28.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

#import "CLLockNavVC.h"

@interface CLLockNavVC ()

@end

@implementation CLLockNavVC


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:[UIFont systemFontOfSize:20]}];

    self.navigationBar.translucent = NO;
//    [self.navigationBar setBackgroundColor:MainRedColor];
//    [self.navigationBar setBackgroundImage:[UIImage imageNamed:@"navBarBg_img"] forBarMetrics:UIBarMetricsDefault];

    // 设置导航栏颜色
    self.navigationBar.barTintColor = MainRedColor;
}


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


@end
