//
//  FMDBTool.h
//  APlus
//
//  Created by 张旺 on 2017/9/30.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMDBTool : NSObject

/// 实例化
+ (instancetype)shareFMDBTool;

/// 创建表或插入数据
- (BOOL)insertDataWithModel:(id)model;

/// 获取全部数据
- (NSArray *)getAllDataWithTableName:(NSString *)tableName;

/// 条件查询
- (NSArray *)getDataWithTableName:(NSString *)tableName withCondition:(NSDictionary *)condition;

/// 删除所有的数据
- (BOOL)deleteAllDataWithTableName:(NSString *)tableName;

/// 条件删除
- (BOOL)deleteDataWithTableName:(NSString *)tableName withCondition:(NSDictionary *)condition;
@end
