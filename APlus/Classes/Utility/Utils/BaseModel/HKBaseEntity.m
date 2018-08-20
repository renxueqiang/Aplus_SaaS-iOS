//
//  BaseEntity.m
//  APlus
//
//  Created by 张旺 on 2017/9/25.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "HKBaseEntity.h"

@implementation HKBaseEntity

+ (NSDictionary *)modelCustomPropertyMapper
{
    return [self getBaseFieldWithOthers:nil];
}


+ (NSMutableDictionary *)getBaseFieldWithOthers:(NSDictionary *)dic
{
    NSMutableDictionary *mdic = [super getBaseFieldWithOthers:@{
                                                                @"rCode":@"RCode",
                                                                @"rMessage":@"RMessage",
                                                                @"total":@"Total",
                                                                }];
    [mdic addEntriesFromDictionary:dic];
    return mdic;
}

@end
