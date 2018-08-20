//
//  ModuleCell.m
//  APlus
//
//  Created by 李慧娟 on 2017/10/13.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "ModuleCell.h"

@implementation ModuleCell {

    __weak IBOutlet UIImageView *_iconImgView;
    __weak IBOutlet UILabel *_moduleNameLabel;
}

- (void)awakeFromNib {
    [super awakeFromNib];

    [_iconImgView setLayerCornerRadius:30];
    _iconImgView.userInteractionEnabled = YES;
}


- (void)setIconName:(NSString *)iconName {
    if (_iconName != iconName) {
        _iconName = iconName;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];

    _iconImgView.image = [UIImage imageNamed:self.iconName];
    _moduleNameLabel.text = self.iconName;
}

@end
