//
//  AgencyBaseEntity.m
//  APlus
//
//  Created by 张旺 on 2017/9/25.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "APlusBaseEntity.h"

@implementation APlusBaseEntity

+ (NSDictionary *)modelCustomPropertyMapper
{

    return [self getBaseFieldWithOthers:nil];
}

+ (NSMutableDictionary *)getBaseFieldWithOthers:(NSDictionary *)dic
{
    NSMutableDictionary *mdic = [super getBaseFieldWithOthers:@{
                                                                @"flag":@"Flag",
                                                                @"errorMsg":@"ErrorMsg",
                                                                @"runTime":@"RunTime",
                                                                }];

    [mdic addEntriesFromDictionary:dic];
    return mdic;
}

@end
