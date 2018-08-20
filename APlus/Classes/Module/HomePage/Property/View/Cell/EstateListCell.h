//
//  EstateListCell.h
//  APlus
//
//  Created by 张旺 on 2017/10/18.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EstateListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

+ (EstateListCell *)cellWithTableView:(UITableView *)tableView;

- (void)setCellData;

@end
