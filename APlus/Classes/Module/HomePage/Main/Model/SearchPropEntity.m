//
//  SearchPropEntity.m
//  APlus
//
//  Created by 李慧娟 on 2017/11/15.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "SearchPropEntity.h"

@implementation SearchPropDetailEntity

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"itemValue":@"ItemValue",
             @"itemText":@"ItemText",
             @"extendAttr":@"ExtendAttr",
             @"time":@"Time",
             @"houseNo":@"HouseNo",
             @"districtName":@"DistrictName",
             @"areaName":@"AreaName",
             };
}


@end


@implementation SearchPropEntity

+ (NSDictionary *)modelCustomPropertyMapper
{
    return [self getBaseFieldWithOthers:@{
                                          @"propPrompts":@"PropertyParamHints",
                                          }];
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"propPrompts":[SearchPropDetailEntity class],
             };
}

@end
