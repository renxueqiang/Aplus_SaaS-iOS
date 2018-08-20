//
//  PDPropFollowCell.m
//  APlus
//
//  Created by 李慧娟 on 2017/11/23.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "PDPropFollowCell.h"

@implementation PDPropFollowCell
{
    __weak IBOutlet UILabel *_followLabel;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setFollowContent:(NSString *)followContent
{
    if (_followContent != followContent)
    {
        _followContent = followContent;

        _followLabel.text = _followContent;
        
    }
}

@end
