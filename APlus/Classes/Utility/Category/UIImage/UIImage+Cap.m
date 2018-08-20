//
//  UIImage+Cap.m
//  LianDong
//
//  Created by ByronYan on 14-6-27.
//  Copyright (c) 2014年 Grant Yuan. All rights reserved.
//

#import "UIImage+Cap.h"

@implementation UIImage (Cap)

+ (UIImage *)imageNamed:(NSString *)name withCapInsets:(UIEdgeInsets)capInsets
{
    UIImage *image = [UIImage imageNamed:name];
    return [image resizableImageWithCapInsets:capInsets];
}

@end
