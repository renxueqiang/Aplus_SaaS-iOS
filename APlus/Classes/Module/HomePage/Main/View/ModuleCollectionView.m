//
//  ModuleCollectionView.m
//  APlus
//
//  Created by 李慧娟 on 2017/10/13.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "ModuleCollectionView.h"
#import "ModuleCell.h"
#import "MoreModuleVC.h"
#import "EstateListVC.h"
#import "MyClientVC.h"
#import "PropertyDetailVC.h"

@implementation ModuleCollectionView

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.backgroundColor = [UIColor whiteColor];
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;

        _dataArr = @[@"通盘房源",@"房源贡献",@"我的收藏",@"我的客户",@"抢公盘",@"抢公客",@"渠道来电",@"更多"];
    }
    return self;
}

#pragma mark - <UICollectionViewDataSource>

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 8;
}

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *identifier = @"ModuleCell";
    UINib *nib = [UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];
    ModuleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    cell.iconName = _dataArr[indexPath.item];
    return cell;
}

#pragma mark - <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.item == 0)
    {
        // 跳转到通盘房源
        EstateListVC *estateListVC = [[EstateListVC alloc] init];
        [self.viewController.navigationController pushViewController:estateListVC animated:YES];
    }
    else if (indexPath.item == 3)
    {
        // 点击跳转房源详情
        PropertyDetailVC *vc = [[PropertyDetailVC alloc] init];
        [self.viewController.navigationController pushViewController:vc animated:YES];

//         我的客户
//        MyClientVC *myClientVC = [[MyClientVC alloc] init];
//        [self.viewController.navigationController pushViewController:myClientVC animated:YES];
    }
    else if (indexPath.item == _dataArr.count - 1)
    {
        // 跳转到更多应用界面
        MoreModuleVC *moreModuleVC = [[MoreModuleVC alloc] init];
        [self.viewController.navigationController pushViewController:moreModuleVC animated:YES];

    }
}

@end
