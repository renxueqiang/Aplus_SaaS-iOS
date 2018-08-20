//
//  LeftTopCell.h
//  APlus
//
//  Created by 李慧娟 on 2017/10/17.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 业绩排行榜单元格
@interface RankingCell : UITableViewCell

- (void)fillDataWithArray:(NSArray *)dataArr AndRow:(NSInteger)row;

@end
