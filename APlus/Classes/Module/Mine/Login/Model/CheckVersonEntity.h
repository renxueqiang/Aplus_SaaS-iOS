//
//  CheckVersonEntity.h
//  APlus
//
//  Created by 李慧娟 on 2017/11/10.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "HKBaseEntity.h"

@interface CheckVersonResultEntity : NSObject

@property (nonatomic,strong) NSString *platform;        //平台
@property (nonatomic,strong) NSString *clientVer;       //版本
@property (nonatomic,strong) NSString *channer;         //渠道
@property (nonatomic,assign) NSInteger forceUpdate;     //强制更新（1：强制更新，0：不强制更新）
@property (nonatomic,strong) NSString *updateUrl;       //下载地址
@property (nonatomic,strong) NSString *updateContent;   //更新内容
@property (nonatomic,strong) NSString *createTime;      //创建时间

@end

@interface CheckVersonEntity : HKBaseEntity

@property (nonatomic, strong) CheckVersonResultEntity *result;

@end
