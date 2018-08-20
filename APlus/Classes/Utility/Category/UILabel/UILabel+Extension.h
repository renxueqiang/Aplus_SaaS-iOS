//
//  UILabel+Extension.h
//  AOPAyun
//
//  Created by AOPA云 on 15/9/22.
//  Copyright (c) 2015年 AOPA云. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)

///// 设置字号的同时加粗字体
//@property (nonatomic, assign) CGFloat boldFont;
/////  计算label中文字长度
//@property (nonatomic, assign) CGFloat textWidth;
///// 计算label中文字高度
//@property (nonatomic, assign) CGFloat textHeight;

#pragma mark - method
- (CGSize)contentSizeForWidth:(CGFloat)width;
- (CGSize)contentSize;
- (BOOL)isTruncated;

/// 改变行间距
+ (NSMutableAttributedString *)changeLineSpaceForLabel:(NSString *)title WithSpace:(float)space;


/// 改变字间距
+ (NSMutableAttributedString *)changeWordSpaceForLabel:(NSString *)title WithSpace:(float)space;


/// 改变行间距和字间距
+ (NSMutableAttributedString *)changeSpaceForLabel:(NSString *)title withLineSpace:(float)lineSpace WordSpace:(float)wordSpace;

/**
 改变部分字体大小
 
 @param content 要改变的字符串
 @param font 要改变的字体Font
 @param start 开始改变的位置
 @param length 改变的长度
 @return  返回NSMutableAttributedString
 */
+ (NSMutableAttributedString *)chageLableFontWithString:(NSString *)content
                                               withFont:(UIFont *)font
                                              withStart:(NSInteger )start
                                             withLength:(NSInteger )length;

/// 改变部分字体颜色
+ (NSMutableAttributedString *)chageLableColorWihtString:(NSString *)content
                                               withColor:(UIColor *)color
                                               withStart:(NSInteger )start
                                              withLength:(NSInteger )length;

/// 改变部分字体颜色和大小
+ (NSMutableAttributedString *)chageLableColorAndFontWithString:(NSString *)content
                                                       wihtFont:(UIFont *)font
                                                      withColor:(UIColor *)color
                                                      withStart:(NSInteger )start
                                                     withLength:(NSInteger )length;

@end
