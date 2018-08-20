//
//  BaseTabBarController.h
//  APlus
//
//  Created by sujp on 2017/9/6.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTabBarController : UITabBarController

//自动跳转到某个index
@property (nonatomic, assign) NSInteger currentSelectIndex;

///共享tabbar单例
+ (BaseTabBarController *)shareTabBarController;


///初始化tabbar
- (void)loadTabBarWithItem:(NSArray *)barItems
                  andBarVC:(NSArray *)barVC
        andSelectItemColor:(UIColor *)selectColor;


///隐藏、显示tabBar
- (void)hideTabBarView;
- (void)showTabBarView;

@end
