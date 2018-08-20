//
//  NSString+Utility.m
//  APlus
//
//  Created by sujp on 2017/9/7.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "NSString+Utility.h"

@implementation NSString (Utility)

-(CGFloat)getStringHeight:(UIFont*)font width:(CGFloat)width
{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSDictionary *attrSyleDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  font, NSFontAttributeName,
                                  nil];
    [attributedString addAttributes:attrSyleDict
                              range:NSMakeRange(0, self.length)];
    CGRect stringRect = [attributedString boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                       context:nil];
    
    return stringRect.size.height;
}

-(CGFloat)getStringWidth:(UIFont*)font Height:(CGFloat)height
{
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self];
    NSDictionary *attrSyleDict = [[NSDictionary alloc] initWithObjectsAndKeys:
                                  font, NSFontAttributeName,
                                  nil];
    
    [attributedString addAttributes:attrSyleDict
                              range:NSMakeRange(0, self.length)];
    CGRect stringRect = [attributedString boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                                       options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                         
                                                       context:nil];
    
    return stringRect.size.width;
}

// 获取某个字符串的范围
- (NSRange)rangeOfSubString:(NSString *)subString
{
    if (!self || self.length == 0 || !subString || subString.length == 0)
    {
        return NSMakeRange(NSNotFound, 0);
    }
    
    NSRange range = [self rangeOfString:subString];
    
    return range;
}

/// 去掉空格
- (NSString *)deleteBlank
{
    NSString *newString= [self stringByReplacingOccurrencesOfString:@" " withString:@""];
    return newString;
}

/// json字符串转字典
- (NSDictionary *)stringToDictionary
{
    if (self)
    {
        NSData *jsonData = [self dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *jsonDic;
        
        if (jsonData) {
            jsonDic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                      options:NSJSONReadingMutableContainers
                                                        error:nil];
        }
        
        return jsonDic;
    }
    
    return nil;
}

@end
