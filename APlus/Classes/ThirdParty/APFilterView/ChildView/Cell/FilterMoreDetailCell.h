//
//  FilterMoreDetailCell.h
//  APlus
//
//  Created by 张旺 on 2017/11/8.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <UIKit/UIKit.h>

#define InteritemSpacing     10.f
#define LineSpacing          11.f   
#define ItemHeight           27.f

@interface FilterMoreDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *estateFilterTitle;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *areaView;

- (void)setCellDataWithDataArray:(NSMutableArray *)dataArray
                  andSelectArray:(NSMutableArray *)selectArray
                    andIndexPath:(NSIndexPath *)indexPath
                      andLineNum:(NSInteger)lineNum;

+ (FilterMoreDetailCell *)cellWithTableView:(UITableView *)tableView;

@end


@interface CollectionCell : UICollectionViewCell

- (void)setCellDataWithData:(NSString *)data andIsSelected:(BOOL)isSelected;
@end
