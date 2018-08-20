//
//  WorkItemCell.m
//  APlus
//
//  Created by 李慧娟 on 2017/10/17.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "WorkItemCell.h"

@interface WorkItemCell() {
    
    __weak IBOutlet UIImageView *_imgView;
    
}
@end

@implementation WorkItemCell

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)fillDataWithString:(NSString *)Title
              andImgString:(NSString *)imgStr
{
    _imgView.image = [UIImage imageNamed:imgStr];
    _titleLabel.text = Title;
}

@end
