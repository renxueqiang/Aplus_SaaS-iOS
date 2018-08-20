//
//  DepartmentInfoEntity.m
//  APlus
//
//  Created by 李慧娟 on 17/11/1.
//  Copyright (c) 2017年 CentaLine. All rights reserved.
//

#import "DepartmentInfoEntity.h"

@implementation OperatorValPermisstionEntity

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"propertySearchPropertyNoOther":@"Property.SearchPropertyNo.Other",
             };

}

@end


@implementation PermisstionsEntity

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"menuPermisstion":@"MenuPermisstion",
             @"rights":@"Rights",
             @"operatorValPermisstion":@"OperatorValPermisstion",
             @"departmentKeyIds":@"DepartmentKeyIds",
             @"rightUpdateTime":@"RightUpdateTime",
             };

}

@end


@implementation IdentifyEntity

+ (NSDictionary *)modelCustomPropertyMapper
{
    return @{
             @"uId":@"UId",
             @"uName":@"UName",
             @"departId":@"DepartId",
             @"departName":@"DepartName",
             @"userNo":@"UserNo",
             };
}

@end


@implementation DepartmentInfoResultEntity

+ (NSDictionary *)modelCustomPropertyMapper{
    return @{
             @"identify":@"Identify",
             @"permisstions":@"Permisstions",
             @"accountInfo":@"AccountInfo",
             };
}

@end


@implementation DepartmentInfoEntity

+ (NSDictionary *)modelCustomPropertyMapper{
    return [self getBaseFieldWithOthers:@{
                                          @"result":@"PermisstionUserInfo"
                                          }];
}
+ (NSDictionary *)modelContainerPropertyGenericClass
{
    return @{
             @"result":[DepartmentInfoResultEntity class],
             };
}
@end
