//
//  GridCell.h
//  APlus
//
//  Created by 李慧娟 on 2017/10/19.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GridCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *addBtn;

- (void)fillDataWithDic:(NSDictionary *)dic WithIdArr:(NSArray *)idArr;

@end
