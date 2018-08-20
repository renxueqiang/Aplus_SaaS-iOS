//
//  BaseTabBarItemModel.h
//  APlus
//
//  Created by sujp on 2017/9/18.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseTabBarItemModel : NSObject

/// 初始化model
+ (id)initWithBarItemName:(NSString *)barItemName
        andBarSelectColor:(UIColor *)selectColor
      andBarNormalImgName:(NSString *)barNormalImgName
      andBarSelectImgName:(NSString *)barSelectImgName;


/// tabBarName
@property (nonatomic, copy) NSString *barItemName;

/// tabBarSelectColor
@property (nonatomic, copy) UIColor *barSelectColor;

/// tabBarNormalImg
@property (nonatomic, copy) NSString *barNormalImgName;

/// tabBarSelectImg
@property (nonatomic, copy) NSString *barSelectImgName;

@end
