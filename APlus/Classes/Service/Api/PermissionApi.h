//
//  PermissionApi.h
//  APlus
//
//  Created by 李慧娟 on 2017/9/28.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "APlusBaseApi.h"

/// 获取信息及权限相关接口
@interface PermissionApi : APlusBaseApi
@end

/**
 * 用户权限
 */
@interface AgencyUserInfoApi : APlusBaseApi
@property (strong, nonatomic) NSArray *staffNo;
@end

/**
 * 获取个人信息
 */
@interface GetPersonalApi : APlusBaseApi
@property (nonatomic,copy)NSString *staffNo;
@property (nonatomic,copy)NSString *cityCode;
@end

/**
 * 获取系统参数
 */
@interface GetSystemParamApi : APlusBaseApi
@property (nonatomic, copy)NSString *updateTime;
@end



