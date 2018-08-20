//
//  GridCell.m
//  APlus
//
//  Created by 李慧娟 on 2017/10/19.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "GridCell.h"

@implementation GridCell
{
    __weak IBOutlet UIImageView *_imgView;
    __weak IBOutlet UILabel *_titleLabel;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = AppBackgroundColor;
}

- (void)fillDataWithDic:(NSDictionary *)dic WithIdArr:(NSArray *)idArr{
    _titleLabel.text = dic[@"title"];
    _imgView.image = [UIImage imageNamed:dic[@"image"]];
    self.addBtn.hidden = NO;
    for (NSString *idStr in idArr) {
        if ([dic[@"gridID"] integerValue] == idStr.integerValue) {
            self.addBtn.hidden = YES;
            break;
        }
    }
}

@end
