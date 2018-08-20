//
//  BaseEntity.h
//  APlus
//
//  Created by 张旺 on 2017/9/25.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "BaseEntity.h"

/// 处理上海接口
@interface HKBaseEntity : BaseEntity

@property (nonatomic, assign) NSInteger  rCode;
@property (nonatomic, strong) NSString  *rMessage;
@property (nonatomic, assign) NSInteger total;

@end
