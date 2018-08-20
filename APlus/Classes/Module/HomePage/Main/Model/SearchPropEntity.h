//
//  SearchPropEntity.h
//  APlus
//
//  Created by 李慧娟 on 2017/11/15.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "APlusBaseEntity.h"

@interface SearchPropDetailEntity : NSObject

@property (nonatomic, copy) NSString *itemValue;    // 楼盘名
@property (nonatomic, copy) NSString *itemText;
@property (nonatomic, copy) NSString *extendAttr;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *houseNo;
@property (nonatomic, copy) NSString *districtName; // 城区
@property (nonatomic, copy) NSString *areaName;     // 片区

@end

@interface SearchPropEntity : APlusBaseEntity

@property (nonatomic,strong) NSArray *propPrompts;

@end


