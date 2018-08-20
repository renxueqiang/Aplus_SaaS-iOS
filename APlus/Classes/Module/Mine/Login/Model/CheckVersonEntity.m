//
//  CheckVersonEntity.m
//  APlus
//
//  Created by 李慧娟 on 2017/11/10.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "CheckVersonEntity.h"

@implementation CheckVersonResultEntity

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"platform":@"Platform",
             @"clientVer":@"ClientVer",
             @"channer":@"Channel",
             @"forceUpdate":@"ForceUpdate",
             @"updateUrl":@"UpdateUrl",
             @"updateContent":@"UpdateContent",
             @"createTime":@"CreateTime"};
}

@end


@implementation CheckVersonEntity

+ (NSDictionary *)modelCustomPropertyMapper
{
    return  [self getBaseFieldWithOthers:@{@"result":@"Result"}];

}

@end
