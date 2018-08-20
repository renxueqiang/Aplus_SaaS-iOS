//
//  PDPropFollowCell.h
//  APlus
//
//  Created by 李慧娟 on 2017/11/23.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 房源详情中房源跟进
@interface PDPropFollowCell : UITableViewCell

// 跟进内容
@property (nonatomic, copy) NSString *followContent;

// 业务员姓名
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

// 时间
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
