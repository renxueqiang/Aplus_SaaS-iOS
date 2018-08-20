//
//  APMenuListView.h
//  APlus
//
//  Created by 张旺 on 2017/11/7.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 可以动态添加的类型 用于初始化
typedef NS_ENUM(NSInteger,MenuItemType)
{
    DefaultMenuItemType,    /// 动态、首页、我的
};

@interface APMenuListView : UIView

/// 消息点击回调 默认跳转消息
@property (copy, nonatomic) void (^newsMenuItemDidSelected) (APMenuListView *menuView);

/// 首页点击回调 默认跳转首页
@property (copy, nonatomic) void (^homeMenuItemDidSelected) (APMenuListView *menuView);

/// 工作点击回调 默认跳转工作
@property (copy, nonatomic) void (^workMenuItemDidSelected) (APMenuListView *menuView);

/// 分享点击回调 没有默认逻辑 需要自行处理
//@property (copy, nonatomic) void (^shareMenuItemDidSelected) (APMenuListView *menuView);

/// 举报点击回调 没有默认逻辑 需要自行处理
//@property (copy, nonatomic) void (^reportMenuItemDidSelected) (APMenuListView *menuView);

/**
 根据依赖的View和菜单类型 初始化菜单
 
 @param view            依赖View
 @param menuItemType    菜单类型
 @return APMenuListView
 */
- (instancetype)showMenuWithRalyonView:(UIView *)view menuItemType:(MenuItemType)menuItemType;

/// 消失
- (void)dismiss;

@end
