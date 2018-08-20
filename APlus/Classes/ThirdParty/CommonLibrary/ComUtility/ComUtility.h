//
//  ComUtility.h
//  FangYouQuan
//
//  Created by sujp on 2017/9/6.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ComBaseCell.h"

@interface ComUtility : NSObject

#pragma mark - 数据驱动

/// 获取当前list中所有有效的cell（去除隐藏的cell）
+ (NSMutableArray *)getAllValidCellWithData:(NSDictionary *)vObj;

/// 获取fields中的自定义cell
+ (ComBaseCell*)getCommonCell:(UITableView*)tableView
                 andIndexPath:(NSIndexPath*)indexPath
                  andDelegate:(id)delegate
                andDataSource:(NSMutableArray*)dataSource;

/// 获取fields中自定义cell的高度
+ (CGFloat)getCommonCellHeightWithData:(NSMutableArray *)dataSource
                          andIndexPath:(NSIndexPath *)indexPath;



@end
