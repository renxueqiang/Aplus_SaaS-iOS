//
//  NewPropertyCell.m
//  APlus
//
//  Created by ZhengHongye on 2017/10/15.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "NewPropertyCell.h"

@implementation NewPropertyCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)setPropertyNewArr:(NSArray *)propertyNewArr
{
    if (_propertyNewArr != propertyNewArr)
    {
        _propertyNewArr = propertyNewArr;

        [self setNeedsLayout];
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];

    _marqueeView.titleArr = _propertyNewArr;
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    // 顶部画线
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ref, 15, 0); // 起点
    CGContextAddLineToPoint(ref, APP_SCREEN_WIDTH - 15, 0);
    CGContextSetStrokeColorWithColor(ref, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(ref, 0.5);
    CGContextDrawPath(ref, kCGPathFillStroke);
}
@end
