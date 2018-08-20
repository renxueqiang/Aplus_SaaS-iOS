//
//  FilterMoreDetailCell.m
//  APlus
//
//  Created by 张旺 on 2017/11/8.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "FilterMoreDetailCell.h"

static NSString * const cellIdentifier = @"EstateListCell";

@interface FilterMoreDetailCell() <UICollectionViewDelegate,UICollectionViewDataSource>
{
    NSString *_filterTitle;                 // 筛选标题
    NSArray *_filterDataArray;              // 筛选数据
    NSInteger _lineNum;                     // CollectionViewCell的每行数量
}

@end

@implementation FilterMoreDetailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[CollectionCell class] forCellWithReuseIdentifier:@"CollectionCell"];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (FilterMoreDetailCell *)cellWithTableView:(UITableView *)tableView
{
    FilterMoreDetailCell *cell = (FilterMoreDetailCell *)[tableView cellFromXib:cellIdentifier];
//    [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    if (!cell)
//    {
//        [tableView registerNib:[UINib nibWithNibName:@"FilterMoreDetailCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
//        
//        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
//    }
    return cell;
}

- (void)setCellDataWithDataArray:(NSMutableArray *)dataArray
                  andSelectArray:(NSMutableArray *)selectArray
                    andIndexPath:(NSIndexPath *)indexPath
                      andLineNum:(NSInteger)lineNum
{
    // 筛选标题
    NSDictionary *filterDict = dataArray[indexPath.row];
    _filterTitle = filterDict.allKeys.firstObject;
    self.estateFilterTitle.text = _filterTitle;
    NSArray *array = filterDict.allValues.firstObject;
    _filterDataArray = [array mutableCopy];
    _lineNum = lineNum;
    [self.collectionView reloadData];
    
    self.areaView.hidden = ![_filterTitle isEqualToString:@"建筑面积（平米)"];
    self.collectionView.hidden = [_filterTitle isEqualToString:@"建筑面积（平米)"];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _filterDataArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
     CollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    [cell setCellDataWithData:_filterDataArray[indexPath.row] andIsSelected:indexPath.row == 0 ? YES:NO];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //  每列的宽度 = (屏幕宽 - 两边边距 - 两个按钮直接的间距 *(num-1) ) / num
    CGFloat width = (APP_SCREEN_WIDTH  - InteritemSpacing * 2 - InteritemSpacing * (_lineNum - 1))/_lineNum;
    return CGSizeMake(width, ItemHeight);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, InteritemSpacing, 0, InteritemSpacing);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    // 行间距
    return LineSpacing;
}

@end

@interface CollectionCell()
@property (strong, nonatomic) UIButton *filterButton;
@end

@implementation CollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.filterButton = [[UIButton alloc] init];
        [self.filterButton setTitleColor:UIColorFromHex(0x666666,1.0) forState:UIControlStateNormal];
        [self.filterButton setTitleColor:UIColorFromHex(0xEE4848,1.0) forState:UIControlStateSelected];
        [self.filterButton setBackgroundImage:[UIImage imageNamed:@"filter_more_btn_normal"] forState:UIControlStateNormal];
        [self.filterButton setBackgroundImage:[UIImage imageNamed:@"filter_more_btn_select"] forState:UIControlStateSelected];
        self.filterButton.titleLabel.font = [UIFont fontWithName:FontName size:12];
        self.filterButton.userInteractionEnabled = NO;
        [self.contentView addSubview:self.filterButton];
    }
    return self;
}

- (void)setCellDataWithData:(NSString *)data andIsSelected:(BOOL)isSelected
{
    [self.filterButton setTitle:data forState:UIControlStateNormal];
    self.filterButton.selected = isSelected;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.filterButton.frame = self.bounds;
}

@end
