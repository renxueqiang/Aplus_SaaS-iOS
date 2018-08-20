//
//  MyClientCell.h
//  APlus
//
//  Created by 张旺 on 2017/11/13.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyClientCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *clientName;            // 客户名字
@property (weak, nonatomic) IBOutlet UIImageView *vipClient;         // vip客户
@property (weak, nonatomic) IBOutlet UILabel *rentPrice;             // 租价
@property (weak, nonatomic) IBOutlet UILabel *salePrice;             // 售价
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *clientNameLeft;    //客户名称左边距


+ (MyClientCell *)cellWithTableView:(UITableView *)tableView;

- (void)setCellDataWithIndexPath:(NSIndexPath *)indexPath;

@end
