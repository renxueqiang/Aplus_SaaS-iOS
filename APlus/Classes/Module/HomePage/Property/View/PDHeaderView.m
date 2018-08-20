//
//  HeaderView.m
//  APlus
//
//  Created by 李慧娟 on 2017/11/21.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "PDHeaderView.h"

@implementation PDHeaderView
{
    UIImageView *_bgImgView;    // 房源图片背景图
    UILabel *_label;            // 标签文本
    UILabel *_photoSumlLabel;   // 房源实勘图总数
    UILabel *_propDetailLabel;  // 房源
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 加载UI
        [self initView];
    }
    return self;
}

- (void)initView
{
    // 房源图片背景图
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 180)];
    _bgImgView.image = [UIImage imageNamed:@"测试"];
//    _bgImgView.contentMode = UIViewContentModeScaleAspectFit;
    _bgImgView.userInteractionEnabled = YES;
//    [_bgImgView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"暂无图片"]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(tapAction:)];
    [_bgImgView addGestureRecognizer:tap];
    [self addSubview:_bgImgView];

    // 返回按钮
    _backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _backBtn.frame = CGRectMake(15, STATUS_BAR_HEIGHT + 5, 40, 40);
    [_backBtn setImage:[UIImage imageNamed:@"PDback"] forState:UIControlStateNormal];
    [self addSubview:_backBtn];

    // 更多按钮
    _moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _moreBtn.frame = CGRectMake(APP_SCREEN_WIDTH - 55, STATUS_BAR_HEIGHT + 5,40 , 40);
    [_moreBtn setImage:[UIImage imageNamed:@"PDMore"] forState:UIControlStateNormal];
    [self addSubview:_moreBtn];

    // 标签文本
    _label = [[UILabel alloc] initWithFrame:CGRectMake(15, 115, APP_SCREEN_WIDTH - 100, 50)];
    _label.numberOfLines = 0;
    _label.textColor = [UIColor whiteColor];
    _label.font = [UIFont systemFontOfSize:14.0];
    _label.text = @"有两套、委托已审、满五年、贷款已清、有两套、委托已审、满五年";
    [self addSubview:_label];

    // 房源实勘总数
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH - 65, 130, 20, 20)];
    imgView.image = [UIImage imageNamed:@"图片"];
    imgView.contentMode = UIViewContentModeCenter;
    [self addSubview:imgView];

    _photoSumlLabel = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right, 130, 30, 20)];
    _photoSumlLabel.textColor = [UIColor whiteColor];
    _photoSumlLabel.font = [UIFont systemFontOfSize:14.0];
    _photoSumlLabel.text = @"20";
    [self addSubview:_photoSumlLabel];

    // 房源名称
    _propDetailLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 170, APP_SCREEN_WIDTH, 60)];
    _propDetailLabel.textColor = [UIColor blackColor];
    _propDetailLabel.backgroundColor = [UIColor whiteColor];
    _propDetailLabel.font = [UIFont systemFontOfSize:16.0];
    _propDetailLabel.textAlignment = NSTextAlignmentCenter;
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:_propDetailLabel.bounds
                                                   byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight
                                                         cornerRadii:CGSizeMake(10, 10)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = _propDetailLabel.bounds;
    maskLayer.path = maskPath.CGPath;
    _propDetailLabel.layer.mask = maskLayer;
    _propDetailLabel.text = @"壹街区静的花园1号楼1门";
    [self addSubview:_propDetailLabel];

}

#pragma mark - 跳转实勘列表浏览

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    
}



@end
