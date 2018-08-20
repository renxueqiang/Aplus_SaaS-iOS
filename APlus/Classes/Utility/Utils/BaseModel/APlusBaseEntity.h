//
//  AgencyBaseEntity.h
//  APlus
//
//  Created by 张旺 on 2017/9/25.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "BaseEntity.h"

/// 处理北京接口
@interface APlusBaseEntity : BaseEntity

@property (nonatomic,assign) BOOL flag;
@property (nonatomic,strong) NSString *errorMsg;
@property (nonatomic,strong) NSString *runTime;

@end
