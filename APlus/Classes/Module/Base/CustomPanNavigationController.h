//
//  CustomPanNavigationController.h
//  FangYouQuan
//
//  Created by sujp on 2017/7/5.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseTabBarController.h"


@interface CustomPanNavigationController : UINavigationController<UIGestureRecognizerDelegate,UINavigationControllerDelegate>

/// 导航的当前Viewcontroller
@property(nonatomic,weak) UIViewController *currentShowVC;


@end
