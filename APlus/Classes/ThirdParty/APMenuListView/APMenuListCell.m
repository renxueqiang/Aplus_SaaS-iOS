//
//  APMenuListCell.m
//  APlus
//
//  Created by 张旺 on 2017/11/7.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "APMenuListCell.h"

@implementation APMenuListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark ----------------------- Set Content -------------------------

- (void)setMenuContentWithTitle:(NSString *)title iconImageName:(NSString *)imageName{
    _titleLabel.textColor = UIColorFromHex(0xff333333, 1.0);
    _titleLabel.font = [UIFont fontWithName:FontName size:12.f];
    _titleLabel.text = title;
    
    _iconImageView.image = [UIImage imageNamed:imageName];
}

- (void)setSeperateLineShow:(BOOL)show{
    _seperateLineView.hidden = !show;
}

@end
