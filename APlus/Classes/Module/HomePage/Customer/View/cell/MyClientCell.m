//
//  MyClientCell.m
//  APlus
//
//  Created by 张旺 on 2017/11/13.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "MyClientCell.h"

static NSString * const cellIdentifier = @"MyClientCell";

@implementation MyClientCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (MyClientCell *)cellWithTableView:(UITableView *)tableView
{
    
    MyClientCell *cell = (MyClientCell *)[tableView cellFromXib:cellIdentifier];
    return cell;
}

- (void)setCellDataWithIndexPath:(NSIndexPath *)indexPath
{
    self.rentPrice.hidden = indexPath.row == 0 ? NO:YES;
    self.salePrice.attributedText = [UILabel chageLableFontWithString:@"200-300万" withFont:[UIFont fontWithName:FontName size:12.0] withStart:7 withLength:1];
    self.rentPrice.attributedText = [UILabel chageLableFontWithString:@"8000-9000元/月" withFont:[UIFont fontWithName:FontName size:12.0] withStart:9 withLength:3];
}

@end
