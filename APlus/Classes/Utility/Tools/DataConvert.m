//
//  DataConvert.m
//  MCocoapods
//
//  Created by 李慧娟 on 17/10/11.
//  Copyright © 2017年 李慧娟. All rights reserved.
//


#import "DataConvert.h"

@implementation DataConvert

/**
 *  将Dic转成model
 */
+ (id)convertData:(id)data
         toEntity:(Class)cls
{
    return [cls yy_modelWithJSON:data] ;
}


/**
 *  将Model转成dic
 */
+ (id)convertModeltToDic:(id)model
{
    return [NSJSONSerialization JSONObjectWithData:[model yy_modelToJSONData]
                                           options:NSJSONReadingMutableContainers
                                             error:nil];
}

@end
