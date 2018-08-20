//
//  LoginEntity.m
//  APlus
//
//  Created by 张旺 on 2017/9/26.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "LoginEntity.h"

@implementation LoginResultDomainUserEntity

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{
             @"cityCode":@"CityCode",
             @"staffNo":@"StaffNo",
             @"cnName":@"CnName",
             @"deptName":@"DeptName",
             @"domainAccount":@"DomainAccount",
             @"mobile":@"Mobile",
             @"title":@"Title",
             @"email":@"Email",
             @"agentUrl":@"AgentUrl",
             @"CompanyName":@"CompanyName"
             };   
}

@end

@implementation LoginResultEntity

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return @{
             @"session":@"Session",
             @"loginDomainUser":@"DomainUser",
             };
    
}

@end

@implementation LoginEntity

+ (NSDictionary *)modelCustomPropertyMapper {
    
    return [self getBaseFieldWithOthers:@{@"result":@"Result"}];
    
}

@end
