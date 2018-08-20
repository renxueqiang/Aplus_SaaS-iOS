//
//  APAutoRefresh.m
//  APlus
//
//  Created by 张旺 on 2017/9/28.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "APAutoRefresh.h"

@implementation APAutoRefresh

/// 创建公共下拉刷新
+ (void)createHeaderRefreshWithTarget:(id)target
                           andAction:(SEL)action
                        andTableView:(UITableView *)tableView
{
    MJRefreshNormalHeader *headerRefresh = [MJRefreshNormalHeader headerWithRefreshingTarget:target
                                                                            refreshingAction:action];
    
    headerRefresh.lastUpdatedTimeLabel.hidden = YES;
    
    tableView.mj_header = headerRefresh;
}

/// 结束下拉刷新
+ (void)endHeaderRefreshWithTableView:(UITableView *)tableView
{
    [tableView.mj_header endRefreshing];
}


/// 创建公共上拉加载
+ (void)createFooterRefreshWithTarget:(id)target
                           andAction:(SEL)action
                        andTableView:(UITableView *)tableView
{
    MJRefreshAutoNormalFooter *refreshFooter = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:target refreshingAction:action];
    
    refreshFooter.automaticallyRefresh = YES;
    refreshFooter.automaticallyHidden = YES;
    
    tableView.mj_footer = refreshFooter;
}


/// 结束上拉加载
+ (void)endFooterRefreshWithTableView:(UITableView *)tableView
                           andNoMore:(BOOL)noMore
{
    if (noMore)
    {
        [tableView.mj_footer endRefreshingWithNoMoreData];
    }
    else
    {
        [tableView.mj_footer endRefreshing];
    }
}

@end
