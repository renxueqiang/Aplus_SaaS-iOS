//
//  SystemParamEntity.m
//  APlus
//
//  Created by 李慧娟 on 17/11/3.
//  Copyright (c) 2017年 CentaLine. All rights reserved.
//

#import "SystemParamEntity.h"

@implementation SelectItemDtoEntity
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"itemValue":@"ItemValue",
             @"itemText":@"ItemText",
             @"itemCode":@"ItemCode",
             @"itemStatus":@"ItemStatus",
             @"extendAttr":@"ExtendAttr",
             @"flagDefault":@"FlagDefault",
             @"seq":@"Seq",
             };
}
@end


@implementation SysParamItemEntity
+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"parameterName":@"ParameterName",
             @"parameterType":@"ParameterType",
             @"parameterStatus":@"ParameterStatus",
             @"itemList":@"Items",
             };
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"itemList":[SelectItemDtoEntity class],
             };
}
@end


@implementation SystemParamEntity
+ (NSDictionary *)modelCustomPropertyMapper
{
    return [self getBaseFieldWithOthers:@{
                                          @"sysParamNewUpdTime":@"SysParamNewUpdateTime",
                                          @"needUpdate":@"NeedUpdate",
                                          @"sysParamList":@"SystemParam"
                                          }];
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"sysParamList":[SysParamItemEntity class],
             };

}
@end
