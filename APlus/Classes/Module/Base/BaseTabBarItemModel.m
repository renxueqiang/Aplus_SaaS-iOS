//
//  BaseTabBarItemModel.m
//  APlus
//
//  Created by sujp on 2017/9/18.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "BaseTabBarItemModel.h"

@implementation BaseTabBarItemModel

/// 初始化model
+ (id)initWithBarItemName:(NSString *)barItemName
        andBarSelectColor:(UIColor *)selectColor
      andBarNormalImgName:(NSString *)barNormalImgName
      andBarSelectImgName:(NSString *)barSelectImgName
{
    BaseTabBarItemModel *itemModel = [BaseTabBarItemModel new];
    
    if (self)
    {
        itemModel.barItemName = barItemName;
        itemModel.barSelectColor = selectColor;
        itemModel.barNormalImgName = barNormalImgName;
        itemModel.barSelectImgName = barSelectImgName;
    }
    
    return itemModel;
}

@end
