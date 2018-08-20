//
//  BaseEntity.m
//  APlus
//
//  Created by 李慧娟 on 17/10/12.
//  Copyright (c) 2017年 李慧娟. All rights reserved.
//

#import "BaseEntity.h"

@implementation BaseEntity

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{

             };
}

+ (NSMutableDictionary *)getBaseFieldWithOthers:(NSDictionary *)dic
{
    NSMutableDictionary *mdic = [[NSMutableDictionary alloc] init];
    [mdic addEntriesFromDictionary:dic];
    return mdic;
}

//+ (NSMutableDictionary *)getBaseFieldMapping
//{
//    NSMutableDictionary *mdic = [[NSMutableDictionary alloc] init];
//    return mdic;
//}

@end
