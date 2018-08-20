//
//  CityConfigEntity.m
//  APlus
//
//  Created by 李慧娟 on 17/11/1.
//  Copyright © 2016年 CentaLine. All rights reserved.
//

#import "CityConfigEntity.h"

@implementation AppConfigResponseEntity

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"configId":@"ConfigId",
             @"parentId":@"ParentId",
             @"dispIndex":@"DispIndex",
             @"title":@"Title",
             @"mdescription":@"Description",
             @"iconUrl":@"IconUrl",
             @"jumpType":@"JumpType",
             @"jumpContent":@"JumpContent",
             @"homeShow":@"HomeShow"
             };
}

@end

@implementation CityConfigEntity

+ (NSDictionary *)modelCustomPropertyMapper{
    return [self getBaseFieldWithOthers:@{
                                          @"result":@"Result"
                                          }];
}

+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"result":[AppConfigResponseEntity class],
             };
}

@end
