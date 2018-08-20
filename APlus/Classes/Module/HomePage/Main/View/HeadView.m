//
//  HeadView.m
//  APlus
//
//  Created by 李慧娟 on 2017/10/13.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "HeadView.h"

@implementation HeadView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self initView];
    }
    return self;
}

- (void)initView {
    _bgImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, self.height - 25)];
    _bgImgView.image = [UIImage imageNamed:@"bg"];
    _bgImgView.userInteractionEnabled = YES;
    [self addSubview:_bgImgView];

    // 城市
    _cityView = [UIButton buttonWithType:UIButtonTypeCustom];
    _cityView.frame = CGRectMake(15, STATUS_BAR_HEIGHT + 10, 80, 30);
    _cityView.backgroundColor = [UIColor clearColor];
    [_cityView setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _cityView.titleLabel.font = [UIFont systemFontOfSize:16.0];
    [_cityView setImage:[UIImage imageNamed:@"定位"] forState:UIControlStateNormal];
    [_cityView setTitle:@"  天津" forState:UIControlStateNormal];
    [self addSubview:_cityView];

    // 扫一扫
    _scanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _scanBtn.frame = CGRectMake(APP_SCREEN_WIDTH - 50, _cityView.top, 30, 30);
    [_scanBtn setImage:[UIImage imageNamed:@"扫"] forState:UIControlStateNormal];
    [self addSubview:_scanBtn];

    // A
    _logoImgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.width - 50) / 2, 60, 50, 50)];
    _logoImgView.image = [UIImage imageNamed:@"A"];
    _logoImgView.backgroundColor = [UIColor clearColor];
    _logoImgView.userInteractionEnabled = YES;
    [self addSubview:_logoImgView];

    // 搜索
    _searchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _searchBtn.frame = CGRectMake(30, self.height - 50, self.width - 60, 50);
//    [_searchBtn setLayerCornerRadius:25];
//    _searchBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
//    _searchBtn.layer.borderWidth = 0.8;
    _searchBtn.backgroundColor = [UIColor clearColor];
    [_searchBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [_searchBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [_searchBtn setBackgroundImage:[UIImage imageNamed:@"Rectangle"] forState:UIControlStateNormal];
    [_searchBtn setTitle:@"  输入城区、片区、楼盘名" forState:UIControlStateNormal];
    _searchBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
    [self addSubview:_searchBtn];

}




@end
