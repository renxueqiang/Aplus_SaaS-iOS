//
//  PersonalInfoEntity.m
//  APlus
//
//  Created by 李慧娟 on 17/11/1.
//  Copyright (c) 2017年 CentaLine. All rights reserved.
//

#import "PersonalInfoEntity.h"

@implementation PersonalInfoEntity

+ (NSDictionary *)modelCustomPropertyMapper
{
    return [self getBaseFieldWithOthers:@{
                                          @"employeeNo":@"EmployeeNo",
                                          @"employeeName":@"EmployeeName",
                                          @"position":@"Position",
                                          @"departmentName":@"DepartmentName",
                                          @"email":@"Email",
                                          @"tel":@"Tel",
                                          @"mobile":@"Mobile",
                                          @"wxNo":@"WxNo",
                                          @"weiXinQRCodeUrl":@"WeiXinQRCodeUrl",
                                          @"signature":@"Signature",
                                          @"photoPath":@"PhotoPath",
                                          @"extendTel":@"ExtendTel"
                                          }];
}

@end
