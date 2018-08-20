//
//  Utility.h
//  APlus
//
//  Created by sujp on 2017/9/7.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

/// 判断是否是第一次启动
+ (BOOL)isFirstLaunching;

/// 计算不同尺寸控件在不同屏幕下的比例
+ (CGFloat)calculateLengthFromMultipleScreenSizeWithLength:(CGFloat)length;

/// 当前设备是否是iPhone6尺寸
+ (BOOL)is4_7InchScreen;

/// 当前设备是否是iPhone6plus尺寸或更大
+ (BOOL)is5InchScreen;

/// 存NSUserDefault
+ (void)setUserdefaultWithValue:(id)value forKey:(NSString *)key;

/// 取NSUserDefault
+ (id)getUserdefaultWithKey:(NSString *)key;

/// 设置UILabel的行间距
+ (NSMutableAttributedString *)setLabelParagraphStyleWithString:(NSString *)changeStr
                                                 andLineSpacing:(CGFloat)lineSpacing
                                                   andAlignment:(NSTextAlignment)textAlignment;

/// 设置不同颜色的字体，UILabel
+ (NSMutableAttributedString *)setLabelMutableColorWithColor:(UIColor *)otherTextColor
                                                     andStr:(NSString *)changeStr
                                                 andStarLoc:(NSInteger)starLocation
                                                  andLength:(NSInteger)length;
/// 设置图片公共方法
+ (void)setImageWithImageView:(UIImageView *)imageView
                 andImageUrl:(NSString *)imageUrl
     andPlaceholderImageName:(NSString *)placeholderImageName;

/// 设备是否支持打电话
+ (BOOL)isPhoneSupported;

/// 判断字符串是否为电话号码格式
+ (BOOL)isMobile:(NSString *)mobile;

@end
