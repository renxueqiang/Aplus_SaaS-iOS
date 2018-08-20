//
//  APAutoRefresh.h
//  APlus
//
//  Created by 张旺 on 2017/9/28.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJRefresh.h"

@interface APAutoRefresh : NSObject

/// 创建公共下拉刷新
+ (void)createHeaderRefreshWithTarget:(id)target
                            andAction:(SEL)action
                         andTableView:(UITableView *)tableView;

/// 结束下拉刷新
+ (void)endHeaderRefreshWithTableView:(UITableView *)tableView;


/// 创建公共上拉加载
+ (void)createFooterRefreshWithTarget:(id)target
                            andAction:(SEL)action
                         andTableView:(UITableView *)tableView;

/// 结束上拉加载
+ (void)endFooterRefreshWithTableView:(UITableView *)tableView
                            andNoMore:(BOOL)noMore;

@end
