//
//  HKCommonApi.m
//  APlus
//
//  Created by 李慧娟 on 2017/11/10.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "HKCommonApi.h"

/**
 * 登录
 */
@implementation HKLoginApi

- (NSDictionary *)getBody
{
    return @{
             @"DomainAccount":_account,
             @"DomainPass":_pwd,
             };
}

- (NSString *)getPath
{
    return @"Login";
}

- (Class)getRespClass
{
    return LoginEntity.class;
}

@end

/**
 * 配置
 */
@implementation HKCommonApi

- (NSDictionary *)getBody
{
    return @{
             @"configType":_configType,
             @"length":_length,
             };

}

- (NSString *)getPath
{
    return @"HomeConfig";
}

- (Class)getRespClass
{
    return CityConfigEntity.class;
}

- (int)getRequestMethod
{
    return RequestMethodGET;
}

@end

/**
 * 检查用户版本
 */
@implementation CheckAppVersonApi

- (NSDictionary *)getBody{
    return nil;
}

- (NSString *)getPath
{
    return @"AppVersion?";
}


- (Class)getRespClass
{
    return [CheckVersonEntity class];

}

- (int)getRequestMethod
{
    return RequestMethodGET;
}

@end

/**
 * 获取或恢复强制解锁密码状态
 */
@implementation ManageLockStatusApi

- (NSString *)getPath
{
    return @"AccountLock";
}

- (int)getRequestMethod
{
    if (self.ManageAccountLockStatusType == GetAccountLockStatus)
    {
        //获取
        return RequestMethodGET;
    }
    //重置
    return RequestMethodPOST;
}

- (Class)getRespClass
{
    return [LockStatusEntity class];
}

@end

