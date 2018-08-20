//
//  PropertyApi.h
//  APlus
//
//  Created by 李慧娟 on 2017/9/28.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "APlusBaseApi.h"
#import "EstateSelectTypeEnum.h"
#import "SearchPropEntity.h"

static NSString *propertyApi = @"property";

/// 房源相关接口
@interface PropertyApi : APlusBaseApi
@end

/**
 * 搜索房源
 */
@interface SearchPropApi : APlusBaseApi

@property (nonatomic,copy)NSString *name;               // 表示城区/片区/楼盘名的楼盘名
@property (nonatomic,copy)NSString *topCount;           // 返回的记录的Top数
@property (nonatomic,copy)NSString *estateSelectType;   // 查询范围枚举
@property (nonatomic,copy)NSString *buildName;          // 模糊栋座名称

@end

