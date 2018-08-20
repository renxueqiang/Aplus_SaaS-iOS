//
//  EstateListCell.m
//  APlus
//
//  Created by 张旺 on 2017/10/18.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "EstateListCell.h"

static NSString *const cellIdentifier = @"EstateListCell";

@implementation EstateListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (EstateListCell *)cellWithTableView:(UITableView *)tableView
{
    
    EstateListCell *cell = (EstateListCell *)[tableView cellFromXib:cellIdentifier];
    return cell;
}

- (void)setCellData
{
    
    self.priceLabel.attributedText = [UILabel chageLableFontWithString:@"325万" withFont:[UIFont fontWithName:BoldFontName size:12.0] withStart:3 withLength:1];
}

@end
