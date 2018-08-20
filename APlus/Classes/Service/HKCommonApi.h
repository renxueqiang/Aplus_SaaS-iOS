//
//  HKCommonApi.h
//  APlus
//
//  Created by 李慧娟 on 2017/11/10.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "HKBaseApi.h"
#import "LoginEntity.h"
#import "CityConfigEntity.h"
#import "CheckVersonEntity.h"
#import "LockStatusEntity.h"

/**
 * 登录
 */
@interface HKLoginApi : HKBaseApi

@property (nonatomic, copy)NSString *account;
@property (nonatomic, copy)NSString *pwd;

@end

/**
 * 配置
 */
@interface HKCommonApi : HKBaseApi

@property (nonatomic, copy) NSString *configType;
@property (nonatomic, copy) NSString *length;

@end

/**
 * 检查用户版本
 */
@interface CheckAppVersonApi : HKBaseApi

@end

/**
 * 获取或恢复强制解锁密码状态
 */
#define GetAccountLockStatus    1
#define ResetAccountLockStatus  2
@interface ManageLockStatusApi : HKBaseApi

@property (nonatomic,assign) NSInteger ManageAccountLockStatusType;

@end

