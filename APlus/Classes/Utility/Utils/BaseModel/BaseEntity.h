//
//  BaseEntity.h
//  APlus
//
//  Created by 李慧娟 on 17/10/12.
//  Copyright (c) 2017年 李慧娟. All rights reserved.
//

/**
 *  移动A+ 实体基类
 *
 */
#import <Foundation/Foundation.h>


@interface BaseEntity : NSObject

@property (nonatomic, assign) NSInteger tag;

/// 在其子类中重写此方法
+ (NSMutableDictionary *)getBaseFieldWithOthers:(NSDictionary *)dic;

@end
