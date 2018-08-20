//
//  FMDBTool.m
//  APlus
//
//  Created by 张旺 on 2017/9/30.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "FMDBTool.h"

#define DBNAME @"APlusData.sqlite"
#define DBPATH [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject stringByAppendingPathComponent:DBNAME]

@interface FMDBTool()

@property (nonatomic, strong)FMDatabaseQueue *baseQueue;

@end

@implementation FMDBTool

static FMDBTool *_instance;

+ (instancetype)shareFMDBTool
{
    static dispatch_once_t onceToken_FileManager;
    
    dispatch_once(&onceToken_FileManager, ^{
        _instance = [[self alloc]init];
    });
    return _instance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        if (!_baseQueue)
        {
            _baseQueue = [FMDatabaseQueue databaseQueueWithPath:DBPATH];
        }
    }
    return self;
}

/// 创建表或插入数据
- (BOOL)insertDataWithModel:(id)model
{
    BOOL __block result;
    [self.baseQueue inDatabase:^(FMDatabase *db) {
        
        if ([db open])
        {
            // 表如果不存在  创建
            /*
             表和模型建立一个映射关系：表名 = 类名   属性 = 表字段
             */
            Class class = [model class];
            NSString *tableName = NSStringFromClass(class);
            
            // 为数据库设置缓存，提高查询效率
            [db setShouldCacheStatements:YES];
            
            // 如果当前数据库不存在当前表，就创建
            if (![db tableExists:tableName])
            {
                [db executeUpdate:[self createTableInDatabaseWithObject:model]];
            }
            // 获取所有的属性
            NSArray *properties = [self propertiesFromClass:class];
            
            // sql语句
            NSMutableString *keySql = [NSMutableString stringWithFormat:@"insert into %@ (", tableName];
            NSMutableString *valueSql = [NSMutableString stringWithString:@" values ("];
            
            // insert into XXX (key1,key2) values ('xx','xx')
            [properties enumerateObjectsUsingBlock:^(id  _Nonnull key, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (idx == properties.count - 1)
                {
                    [keySql appendFormat:@"%@)",key];
                    [valueSql appendFormat:@"'%@')",[model valueForKey:key]];
                }
                else
                {
                    [keySql appendFormat:@"%@,",key];
                    [valueSql appendFormat:@"'%@',",[model valueForKey:key]];
                }
            }];
            [keySql appendString:valueSql];
            // 执行sql语句
            result = [db executeUpdate:keySql];
        }
        [db close];
    }];
    
    return result;
}

/// 获取全部数据
- (NSArray *)getAllDataWithTableName:(NSString *)tableName
{
    return [self getDataWithTableName:tableName withCondition:nil];
}

/// 条件查询
- (NSArray *)getDataWithTableName:(NSString *)tableName withCondition:(NSDictionary *)condition
{
    NSMutableArray *objectArray = [[NSMutableArray alloc]init];
    [self.baseQueue inDatabase:^(FMDatabase *db) {
        
        if ([db open])
        {
            if(![db tableExists:tableName])
            {
                NSLog(@"表格不存在");
                return;
            }
            
            // 获取属性的名字
            NSArray *properties = [self propertiesFromClass:NSClassFromString(tableName)];
            
            // sql
            NSString *sql = [NSString stringWithFormat:@"select * from %@",tableName];
            
            // 条件查询
            if (condition)
            {
                NSString *conditionString = [self conditionStringFromCondition:condition];
                
                sql = [NSString stringWithFormat:@"select * from %@ where %@",tableName,conditionString];
            }
            
            // 执行sql
            FMResultSet *results = [db executeQuery:sql];
            
            while (results.next)
            {
                // 创建一个对象
                id object = [[NSClassFromString(tableName) alloc] init];
                
                for (NSString *property in properties)
                {
                    // 从数据库里面取值
                    NSString *value = [results stringForColumn:property];
                    
                    // 对象赋值
                    [object setValue:value forKey:property];
                }
                
                [objectArray addObject:object];
            }
        }
        [db close];
    }];
    
    return objectArray;
}

/// 删除所有的数据
- (BOOL)deleteAllDataWithTableName:(NSString *)tableName
{
    BOOL __block result;
    [self.baseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        
        if ([db open])
        {
            if(![db tableExists:tableName])
            {
                NSLog(@"表格不存在");
                result = NO;
            }
            
            if ([db executeUpdate:[NSString stringWithFormat:@"delete from %@",tableName]])
            {
                result = YES;
            }
            else
            {
                result = NO;
            }
        }
        [db close];
    }];
    
    return result;
}

/// 条件删除
- (BOOL)deleteDataWithTableName:(NSString *)tableName withCondition:(NSDictionary *)condition
{
    BOOL __block result;
    [self.baseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        
        if ([db open])
        {
            if(![db tableExists:tableName])
            {
                NSLog(@"表格不存在");
                result = NO;
            }
            
            // 条件删除
            NSString *conditionString = [self conditionStringFromCondition:condition];
            
            // sql
            NSString *sql = [NSString stringWithFormat:@"delete from %@ where %@",tableName,conditionString];
            
            if ([db executeUpdate:sql])
            {
                result = YES;
            }
            else
            {
                result = NO;
            }
        }
        [db close];
    }];
    
    return result;
}

#pragma mark - private

/// 创建表
- (NSString *)createTableInDatabaseWithObject:(id)object
{
    Class cls = [object class];
    // 表名
    NSString *tableName = NSStringFromClass(cls);
    
    // 动态获取属性
    NSArray *properties = [self propertiesFromClass:cls];
    
    // 创建表
    __block NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement",tableName];
    
    // create table if not exists %@ (id integer primary key autoincrement,name text,age text, address text);
    // 拼接sql语句
    [properties enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        sql = [sql stringByAppendingFormat:@",%@ text",obj];
    }];
    sql = [sql stringByAppendingString:@")"];
    
    // 返回sql语句
    return sql;
}

/// 动态获取指定类属性
- (NSArray *)propertiesFromClass:(Class)class
{
    // 属性列表
    NSMutableArray *propertyArray = [NSMutableArray array];
    
    // 属性个数
    unsigned int outCount;
    // 获取属性的结构体指针
    objc_property_t *properties = class_copyPropertyList(class, &outCount);
    
    // 遍历所有属性
    for (int i = 0; i < outCount; i++)
    {
        // 获取属性的结构体
        objc_property_t property = properties[i];
        // 获取属性名字
        const char *name = property_getName(property);
        
        [propertyArray addObject:[NSString stringWithUTF8String:name]];
    }

    return propertyArray;
}

/// 条件语句
- (NSString *)conditionStringFromCondition:(NSDictionary *)condition
{
    NSMutableString *conditionString = [NSMutableString string];
    
    NSArray *keys = condition.allKeys;
    
    for (int i = 0; i < keys.count; i++)
    {
        NSString *key = keys[i];
        
        if (i == condition.count - 1)
        {
            [conditionString appendFormat:@" %@='%@'",key,condition[key]];
        }
        else
        {
            [conditionString appendFormat:@" %@='%@' and",key,condition[key]];
        }
    }
    
    return conditionString;
}

- (FMDatabaseQueue *)baseQueue
{
    if (!_baseQueue)
    {
        _baseQueue = [FMDatabaseQueue databaseQueueWithPath:DBPATH];
    }
    return _baseQueue;
}


@end
