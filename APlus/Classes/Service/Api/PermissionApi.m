//
//  PermissionApi.m
//  APlus
//
//  Created by 李慧娟 on 2017/9/28.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "PermissionApi.h"
#import "DepartmentInfoEntity.h"
#import "PersonalInfoEntity.h"
#import "SystemParamEntity.h"

static NSString *permissionApi = @"permission/";

/// 获取信息及权限相关接口
@implementation PermissionApi
@end

@implementation AgencyUserInfoApi

/**
 * 用户权限
 */
- (NSDictionary *)getBody
{
    return @{
             @"UserNumbers":_staffNo,
             };
}

- (NSString *)getPath
{
    return [permissionApi addSubStr:@"user-permisstion"];
}

- (Class)getRespClass
{
    return [DepartmentInfoEntity class];
}

@end

/**
 * 获取个人信息
 */
@implementation GetPersonalApi

- (NSDictionary *)getBody
{
    return @{
             @"staffNo":_staffNo,
             @"cityCode":_cityCode
             };
}

- (NSString *)getPath
{
    return [permissionApi addSubStr:@"user-info"];
}

- (Class)getRespClass
{
    return [PersonalInfoEntity class];
}

@end

/**
 * 获取系统参数
 */
@implementation GetSystemParamApi

- (NSDictionary *)getBody
{
    _updateTime = _updateTime ? _updateTime : @"";
    return @{@"UpdateTime":_updateTime};
}

- (NSString *)getPath
{
    return [permissionApi addSubStr:@"update-parameter"];
}

- (Class)getRespClass
{
    return [SystemParamEntity class];
}

@end
