//
//  PropertyInfoView.m
//  APlus
//
//  Created by 李慧娟 on 2017/11/24.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "PropertyInfoView.h"
#import "PropertyInfoCell.h"

@implementation PropertyInfoView


- (instancetype)initWithFrame:(CGRect)frame
//         collectionViewLayout:(UICollectionViewLayout *)layout
{
    CGFloat Width = (APP_SCREEN_WIDTH - 20) / 2;
    UICollectionViewFlowLayout *flowLayOut = [[UICollectionViewFlowLayout alloc] init];
    flowLayOut.itemSize = CGSizeMake(Width, 30);
    flowLayOut.minimumLineSpacing = 0;
    flowLayOut.minimumInteritemSpacing = 0;
    flowLayOut.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    self = [super initWithFrame:frame collectionViewLayout:flowLayOut];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor clearColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bounces = NO;
    }

    return self;
}

- (void)setTitleArr:(NSArray *)titleArr
{
    if (_titleArr != titleArr)
    {
        _titleArr = titleArr;
        [self reloadData];
    }
}


#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _titleArr.count;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *identifier = @"PropertyInfoCell";
    UINib *nib = [UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
    PropertyInfoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    return cell;
}



@end
