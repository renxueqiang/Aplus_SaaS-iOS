//
//  BaseViewController.h
//  APlus
//
//  Created by sujp on 2017/9/7.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RequestManager.h"
#import "AppDelegate.h"

@interface BaseViewController : UIViewController <ResponseDelegate>
{
    RequestManager *_manager;
}

#pragma mark - SetNavItemMethod

- (void)setNavTitle:(NSString *)titleStr
     leftButtonItem:(UIButton *)leftBtn
    rightButtonItem:(UIButton *)rightBtn;

/// 自定义barItem按钮
- (UIButton *)customBarItemButton:(NSString *)title
                  backgroundImage:(NSString *)bgImg
                       foreground:(NSString *)fgImg
                              sel:(SEL)sel;

/// 返回按钮barItem
- (UIButton *)backBarItemBtnWithSel:(SEL)sel;

/// pop、dismiss
- (void)back;

/// 获取单例AppDelegate
- (AppDelegate *)sharedAppDelegate;

/// 处理数据
- (void)dealData:(CentaResponse *)resData;

#pragma mark - MBProgressHUD

- (void)showLoadingView:(NSString *)message;
- (void)hideLoadingView;

#pragma mark - 设置是否需要隐藏导航栏

- (void)navBarNeedHidden:(BOOL)isHidden
            andAnimation:(BOOL)isAnimation;

/// 设置是否需要隐藏导航栏
- (void)setNeedHiddenNavBar:(BOOL)isHidden
               andAnimation:(BOOL)isAnimation;


/// 创建搜索框中的语音按钮
- (UIButton *)createVoiceSearchBtnWithSelector:(SEL)selector;

/// 创建搜索框中的文字搜索按钮
- (UIButton *)createTextSearchBtnWithSelector:(SEL)selector;

/// 创建顶部搜索框
- (void)createTopSearchBarViewWithTextSearchBtn:(UIButton *)textSearchBtn
                                    andRightBtn:(UIButton *)rightBtn
                                 andPlaceholder:(NSString *)placeholder;

@end
