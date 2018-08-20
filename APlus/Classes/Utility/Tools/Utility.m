//
//  Utility.m
//  APlus
//
//  Created by sujp on 2017/9/7.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "Utility.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation Utility

/// 判断是否是第一次启动
+ (BOOL)isFirstLaunching
{
    BOOL firstLaunching = false;
    
    NSString *lastAppVersion =  [[NSUserDefaults standardUserDefaults] valueForKey:@"LastAppVersion"];
    NSString *currentAppVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
    
    if ([lastAppVersion floatValue] < [currentAppVersion floatValue])
    {
        [[NSUserDefaults standardUserDefaults] setValue:currentAppVersion forKey:@"LastAppVersion"];
        firstLaunching = true;
    }
    
    return firstLaunching;
}

/// 计算不同尺寸控件在不同屏幕下的比例
+ (CGFloat)calculateLengthFromMultipleScreenSizeWithLength:(CGFloat)length
{
    // 不同屏幕尺寸下相差的大小
    CGFloat multipleDifferLength = (length * APP_SCREEN_WIDTH)/320;
    
    return multipleDifferLength;
}

/// 当前设备是否是iPhone6尺寸
+ (BOOL)is4_7InchScreen
{
    if (APP_SCREEN_WIDTH == 375)
    {
        return YES;
    }
    
    return NO;
}

/// 当前设备是否是iPhone6plus尺寸或更大
+ (BOOL)is5InchScreen
{
    if (APP_SCREEN_WIDTH >= 414)
    {
        return YES;
    }
    
    return NO;
}

/// 存NSUserDefault
+ (void)setUserdefaultWithValue:(id)value forKey:(NSString *)key
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:value forKey:key];
    [userDefault synchronize];
}

/// 取NSUserDefault
+ (id)getUserdefaultWithKey:(NSString *)key
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    
    return [userDefault objectForKey:key];
}

/// 设置UILabel的行间距
+ (NSMutableAttributedString *)setLabelParagraphStyleWithString:(NSString *)changeStr
                                                 andLineSpacing:(CGFloat)lineSpacing
                                                   andAlignment:(NSTextAlignment)textAlignment
{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:changeStr];
    NSMutableParagraphStyle * paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:lineSpacing];
    [paragraphStyle setAlignment:textAlignment];
    [paragraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [changeStr length])];
    
    return attributedString;
}

/// 设置不同颜色的字体，UILabel
+ (NSMutableAttributedString *)setLabelMutableColorWithColor:(UIColor *)otherTextColor
                                                      andStr:(NSString *)changeStr
                                                  andStarLoc:(NSInteger)starLocation
                                                   andLength:(NSInteger)length
{
    NSMutableAttributedString *attriStr = [[NSMutableAttributedString alloc] initWithString:changeStr];
    [attriStr addAttribute:NSForegroundColorAttributeName
                     value:otherTextColor
                     range:NSMakeRange(starLocation, length)];
    
    return attriStr;
}

/// 设置图片公共方法
+ (void)setImageWithImageView:(UIImageView *)imageView
                 andImageUrl:(NSString *)imageUrl
     andPlaceholderImageName:(NSString *)placeholderImageName
{
    
    UIImage *placeholderImg = [UIImage new];
    
    if (![placeholderImageName isEqualToString:@""] &&
        placeholderImageName) {
        
        placeholderImg = [UIImage imageNamed:placeholderImageName];
    }
    
    if (placeholderImg) {
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]
                     placeholderImage:placeholderImg
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                
                                if (cacheType == SDImageCacheTypeNone) {
                                    
                                    imageView.alpha = 0;
                                    
                                    [UIView transitionWithView:imageView
                                                      duration:0.5
                                                       options:UIViewAnimationOptionTransitionCrossDissolve
                                                    animations:^{
                                                        
                                                        [imageView setImage:image];
                                                        imageView.alpha = 1.0;
                                                        
                                                    } completion:nil];
                                }
                                
                            }];
    }else{
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    }
    
}

/// 设备是否支持打电话
+ (BOOL)isPhoneSupported
{
    NSString* deviceType = [UIDevice currentDevice].model;
    return [deviceType isEqualToString:@"iPhone"];
}

/// 判断字符串是否为电话号码格式
+ (BOOL)isMobile:(NSString *)mobile
{
    NSString *regex = @"^[1][34578][0-9]{9}$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    BOOL isMatch = [pred evaluateWithObject:mobile];
    return isMatch;
}

@end
