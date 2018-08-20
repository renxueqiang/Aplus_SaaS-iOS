//
//  CityConfigEntity.h
//  APlus
//
//  Created by 李慧娟 on 17/11/1.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "HKBaseEntity.h"

@interface AppConfigResponseEntity : NSObject

@property (nonatomic,assign) NSInteger configId;        // 编号 （Int32）
@property (nonatomic,strong) NSString *mdescription;    // 描述
@property (nonatomic, assign) NSInteger dispIndex;      // 显示顺序
@property (nonatomic,assign) BOOL homeShow;             // 是否APP首页显示 （Boolean）
@property (nonatomic,strong) NSString *iconUrl;         //图标 （String）
@property (nonatomic,strong) NSString *jumpContent;     //跳转内容 （String）
@property (nonatomic,assign) NSInteger jumpType;        //跳转类型 （Int32）
@property (nonatomic,assign) NSInteger parentId;        //ParentId （Int32）
@property (nonatomic,strong) NSString *title;           //标题 （String）

@end

@interface CityConfigEntity : HKBaseEntity

@property (nonatomic,strong) NSArray *result;

@end
