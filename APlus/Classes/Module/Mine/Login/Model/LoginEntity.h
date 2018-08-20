//
//  LoginEntity.h
//  APlus
//
//  Created by 张旺 on 2017/9/26.
//  Copyright © 2017年 Centaline. All rights reserved.
//

#import "HKBaseEntity.h"

@interface LoginResultDomainUserEntity : NSObject

@property (nonatomic,strong) NSString *cityCode;
@property (nonatomic,strong) NSString *staffNo;
@property (nonatomic,strong) NSString *cnName;
@property (nonatomic,strong) NSString *deptName;
@property (nonatomic,strong) NSString *domainAccount;
@property (nonatomic,strong) NSString *mobile;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *email;
@property (nonatomic,strong) NSString *agentUrl;
@property (strong,nonatomic) NSString *CompanyName;

@end

@interface LoginResultEntity : NSObject

@property (nonatomic,strong) NSString *session;
@property (nonatomic,strong) LoginResultDomainUserEntity *loginDomainUser;

@end


@interface LoginEntity : HKBaseEntity

@property (nonatomic, strong) LoginResultEntity *result;

@end
