//
//  PropertyApi.m
//  APlus
//
//  Created by 李慧娟 on 2017/9/28.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "PropertyApi.h"

@implementation PropertyApi

@end

/**
 * 搜索房源
 */
@implementation SearchPropApi

- (NSDictionary *)getBody
{
    return @{
             @"Name":_name,
             @"TopCount":_topCount,
             @"BuildName":_buildName.length > 0?_buildName:@"",
             @"EstateSelectType":_estateSelectType?_estateSelectType:[NSString stringWithFormat:@"%d",EstateSelectTypeEnum_ALLNAME]
             };
}

- (NSString *)getPath
{
    return @"property/auto-estate";
}

- (Class)getRespClass
{
    return [SearchPropEntity class];
}

@end
 

