//
//  DepartmentInfoEntity.h
//  APlus
//
//  Created by 李慧娟 on 17/11/1.
//  Copyright (c) 2017年 CentaLine. All rights reserved.
//

#import "APlusBaseEntity.h"

@interface OperatorValPermisstionEntity : NSObject

@property (nonatomic, strong) NSString *propertySearchPropertyNoOther;

@end


@interface PermisstionsEntity : NSObject

@property (nonatomic, strong) NSString *menuPermisstion;
@property (nonatomic, strong) NSString *rights;
@property (nonatomic, strong) OperatorValPermisstionEntity *operatorValPermisstion;
@property (nonatomic, strong) NSString *departmentKeyIds;
@property (nonatomic, strong) NSString *rightUpdateTime;

@end

@interface IdentifyEntity : NSObject

@property (nonatomic, copy) NSString *uId;
@property (nonatomic, copy) NSString *uName;
@property (nonatomic, copy) NSString *departId;
@property (nonatomic, copy) NSString *departName;
@property (nonatomic, copy) NSString *userNo;

@end


@interface DepartmentInfoResultEntity : NSObject

@property (nonatomic,strong) IdentifyEntity *identify;
@property (nonatomic,strong) PermisstionsEntity *permisstions;
@property (nonatomic,copy) NSString *accountInfo;

@end


@interface DepartmentInfoEntity : APlusBaseEntity

@property (nonatomic,strong) NSArray *result;

@end
