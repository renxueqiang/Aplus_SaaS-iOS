//
//  PDTwoSecondCell.m
//  APlus
//
//  Created by 李慧娟 on 2017/11/22.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "PDPropNameCell.h"

@implementation PDPropNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    // 绘制直线
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ref, 15, 0);                        // 起点
    CGContextAddLineToPoint(ref, APP_SCREEN_WIDTH - 15, 0);  // 终点
    CGContextSetStrokeColorWithColor(ref, RGBColor(200, 200, 200).CGColor);
    CGContextSetLineWidth(ref, 0.8);
    CGContextDrawPath(ref, kCGPathFillStroke);
}

@end
