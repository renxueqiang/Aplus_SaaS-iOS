//
//  TopFirstCell.m
//  APlus
//
//  Created by ZhengHongye on 2017/10/15.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "RankingFirstCell.h"
#import "DDProgressView.h"
#import "HomePageVC.h"

@implementation RankingFirstCell 
{
    __weak IBOutlet DDProgressView *_performView;
    __weak IBOutlet UIImageView *_employeeImg;
    
    __weak IBOutlet UILabel *_myLabel;
}


- (void)awakeFromNib {
    [super awakeFromNib];

    [_employeeImg setLayerCornerRadius:24];
    UIView *bgView = [self.contentView viewWithTag:111];
    [bgView setLayerCornerRadius:6];

    _performView.progress = 0.6;
    _performView.emptyColor = RGBColor(254, 212, 212);


}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // 绘制顶部图片 文字
    UIImage *img = [UIImage imageNamed:@"Top"];
    [img drawInRect:CGRectMake(15, 20, 30, 30)];
    
    NSString *textStr = @"TOP10 业绩排行";
    [textStr drawInRect:CGRectMake(60, 20, 150, 30) withAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:20],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    CGContextMoveToPoint(ref, 220, 30); // 起点
    CGContextAddLineToPoint(ref, APP_SCREEN_WIDTH, 30);
    CGContextSetStrokeColorWithColor(ref, [UIColor lightGrayColor].CGColor);
    CGContextSetLineWidth(ref, 0.7);
    CGContextDrawPath(ref, kCGPathFillStroke);


}

@end
