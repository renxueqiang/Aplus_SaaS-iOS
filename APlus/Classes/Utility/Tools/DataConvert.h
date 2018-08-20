//
//  DataConvert.h
//  MCocoapods
//
//  Created by 李慧娟 on 17/10/11.
//  Copyright © 2017年 李慧娟. All rights reserved.
//

#import <Foundation/Foundation.h>
/// 数据转换
@interface DataConvert : NSObject

/**
 *  将Dic转成model
 */
+ (id)convertData:(id)data
         toEntity:(Class)cls;

/**
 *  将Model转成dic
 */
+ (id)convertModeltToDic:(id)model;

@end
