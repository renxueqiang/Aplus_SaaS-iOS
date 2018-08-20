//
//  SystemParamEntity.h
//  APlus
//
//  Created by 李慧娟 on 17/11/3.
//  Copyright (c) 2017年 CentaLine. All rights reserved.
//

#import "APlusBaseEntity.h"

@interface SelectItemDtoEntity : NSObject

/// <summary>
/// 值
/// </summary>
@property (nonatomic,strong) NSString *itemValue;

/// <summary>
/// 名称
/// </summary>
@property (nonatomic,strong) NSString *itemText;

/// <summary>
/// 编码
/// </summary>
@property (nonatomic,strong) NSString *itemCode;

/// <summary>
/// 状态
/// 1：ACTIVE-激活状态, 2:INACTIVE-冻结状态
/// </summary>
@property (nonatomic,assign) NSInteger itemStatus;

/// <summary>
/// 扩展属性
/// </summary>
@property (nonatomic,strong) NSString *extendAttr;

/// <summary>
/// 是否是默认值
/// </summary>
@property (nonatomic,assign) BOOL flagDefault;

/// <summary>
/// 排序号
/// </summary>
@property (nonatomic,assign) NSInteger seq ;

@end


@interface SysParamItemEntity : NSObject
/// <summary>
/// 参数名称
/// </summary>
@property (nonatomic,strong) NSString *parameterName;

/// <summary>
/// 参数类型
/// </summary>
@property (nonatomic,assign) NSInteger parameterType;

/// <summary>
/// 参数状态
/// </summary>
@property (nonatomic,assign) NSNumber *parameterStatus ;

/// <summary>
/// 房源筛选条件选项集合
/// </summary>
@property (nonatomic,strong) NSArray *itemList;

@end


@interface SystemParamEntity : APlusBaseEntity
/// <summary>
/// 系统参数最新更新时间
/// </summary>
@property (nonatomic,strong) NSString *sysParamNewUpdTime;

/// <summary>
/// 是否需要更新
/// </summary>
@property (nonatomic,assign) BOOL needUpdate;

/// <summary>
/// agency系统参数
/// </summary>
@property (nonatomic,strong) NSArray *sysParamList;
@end
