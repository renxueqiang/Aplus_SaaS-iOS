//
//  APFilterView.h
//  APlusFilterView
//
//  Created by 张旺 on 2017/10/24.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <UIKit/UIKit.h>

#define FilterViewHeight            40

/// 筛选类型
typedef enum FilterType
{
    FilterEstateType = 0,         // 房源
    FilterPriceType = 1,          // 价格
    FilterTagSt = 2,              // 标签
    FilterClientState = 3,        // 客户状态
    FilterClientDatum = 4,        // 客户资料完整度
    FilterClient = 5,             // 筛选客户
}FilterType;


/// 选择筛选项后回调的block
typedef void(^FilterCompleteBlock)(NSString *filterStr);

@interface APFilterView : UIView

- (instancetype)initWithFrame:(CGRect)frame;
/**
 *  创建筛选view
 *
 *  @param itemTitleArray   筛选项数组
 *  @param dataSourceArray  具体数据
 *  @param filterType       筛选类型
 *
 *  @return 创建好的view
 */
- (UIView *)createFiterViewWithItemTitleArray:(NSArray *)itemTitleArray
                           andDataSourceArray:(NSArray *)dataSourceArray
                                 andFiterType:(FilterType)filterType
                                     andBlock:(FilterCompleteBlock)block;

@end
