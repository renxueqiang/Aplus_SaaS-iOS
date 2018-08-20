//
//  NSString+Utility.h
//  APlus
//
//  Created by sujp on 2017/9/7.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Utility)

-(CGFloat)getStringHeight:(UIFont*)font
                    width:(CGFloat)width;

-(CGFloat)getStringWidth:(UIFont*)font
                  Height:(CGFloat)height;

- (NSRange)rangeOfSubString:(NSString *)subString;

/// 去掉空格
- (NSString *)deleteBlank;

/// json字符串转字典
- (NSDictionary *)stringToDictionary;

@end
