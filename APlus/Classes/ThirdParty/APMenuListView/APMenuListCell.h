//
//  APMenuListCell.h
//  APlus
//
//  Created by 张旺 on 2017/11/7.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APMenuListCell : UITableViewCell

/// 标题
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

/// icon
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

/// 分割线
@property (weak, nonatomic) IBOutlet UIView *seperateLineView;

/// 设置菜单内容
- (void)setMenuContentWithTitle:(NSString *)title iconImageName:(NSString *)imageName;

/// 设置是否显示分割线
- (void)setSeperateLineShow:(BOOL)show;
@end
