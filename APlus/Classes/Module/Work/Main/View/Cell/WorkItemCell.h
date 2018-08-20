//
//  WorkItemCell.h
//  APlus
//
//  Created by 李慧娟 on 2017/10/17.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WorkItemCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *itemWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *itemHeight;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;



- (void)fillDataWithString:(NSString *)Title andImgString:(NSString *)imgStr;

@end
