//
//  PDFitstCell.m
//  APlus
//
//  Created by 李慧娟 on 2017/11/21.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "PDOneCell.h"

@implementation PDOneCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style
              reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        _trustType = -1;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    return self;

}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setTrustType:(NSInteger)trustType
{
    if (_trustType != trustType)
    {
        _trustType = trustType;
        [self setNeedsDisplay];
    }
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];

    if (_trustType >= 0)
    {
        NSArray *titleArr;
        NSArray *resultArr;
        if (_trustType == SALE)
        {
            titleArr = @[@"售价",@"户型"];
            resultArr = @[@"100万",@"1-0-1"];
        }
        else if (_trustType == RENT)
        {
            titleArr = @[@"租价",@"户型"];
            resultArr = @[@"2000元/月",@"1-0-1"];
        }
        else if (_trustType == BOTH)
        {
            titleArr = @[@"售价",@"租价",@"户型"];
            resultArr = @[@"100万",@"2000元/月",@"1-0-1"];
        }


        CGFloat width = APP_SCREEN_WIDTH / titleArr.count;
        CGFloat height = 20;
        NSInteger count = titleArr.count;
        for (int i = 0; i < count; i++)
        {
            NSString *text = [titleArr objectAtIndex:i];
            NSString *result = [resultArr objectAtIndex:i];
            NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            paragraphStyle.alignment = NSTextAlignmentCenter;
            // 绘制文字
            [text drawInRect:CGRectMake(width * i, 5, width, height)
              withAttributes:@{
                               NSFontAttributeName:[UIFont systemFontOfSize:14.0],
                               NSForegroundColorAttributeName:RGBColor(51, 51, 51),
                               NSParagraphStyleAttributeName:paragraphStyle
                               }];

            UIColor *fontColor = (i == (count - 1))?MainGrayFontColor:MainRedColor;
            [result drawInRect:CGRectMake(width * i, 30, width, 20)
                withAttributes:@{
                                 NSFontAttributeName:[UIFont systemFontOfSize:16.0],
                                 NSForegroundColorAttributeName:fontColor,
                                 NSParagraphStyleAttributeName:paragraphStyle
                                 }];
        }
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
