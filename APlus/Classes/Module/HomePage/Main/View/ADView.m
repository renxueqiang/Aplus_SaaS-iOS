//
//  ADView.m
//  APlus
//
//  Created by 李慧娟 on 2017/10/12.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "ADView.h"

@implementation ADView{
    UIView *_contentViw;    // 内容视图
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self)
    {
        // 设置UI
        [self initView];

    }
    return self;
}

- (void)initView {
    // 内容视图
    _contentViw = [[UIView alloc] initWithFrame:CGRectMake(15, 30, self.width - 30, self.height - 110)];
    [_contentViw setLayerCornerRadius:10];
    _contentViw.backgroundColor = [UIColor whiteColor];
    [self addSubview:_contentViw];

    CGFloat height = self.height - _contentViw.bottom - 50;
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((self.width - 3) / 2, _contentViw.bottom, 3, height)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self addSubview:lineView];

    // 去除广告按钮
    _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancelBtn.frame = CGRectMake((self.width - 36) / 2, lineView.bottom, 36, 36);
    _cancelBtn.backgroundColor = [UIColor whiteColor];
    [_cancelBtn setLayerCornerRadius:18];
    _cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:22];
    [_cancelBtn setImage:[UIImage imageNamed:@"关闭"] forState:UIControlStateNormal];
    [self addSubview:_cancelBtn];
}

@end
