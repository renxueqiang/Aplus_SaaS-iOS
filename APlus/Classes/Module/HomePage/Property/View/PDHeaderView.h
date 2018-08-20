//
//  HeaderView.h
//  APlus
//
//  Created by 李慧娟 on 2017/11/21.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <UIKit/UIKit.h>

/// 房源详情头视图
@interface PDHeaderView : UIView

@property (nonatomic, strong) UIButton *backBtn;

@property (nonatomic, strong) UIButton *moreBtn;

@property (nonatomic, copy) NSString *labelStr;         // 标签文本

@property (nonatomic, copy) NSString *photoSum;         // 房源实勘总数

@property (nonatomic, copy) NSString *propDetailStr;    // 房源名称

@end
