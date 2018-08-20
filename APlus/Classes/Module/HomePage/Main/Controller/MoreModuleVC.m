//
//  MoreModuleVC.m
//  APlus
//
//  Created by 李慧娟 on 2017/10/16.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "MoreModuleVC.h"
#import "WorkItemCell.h"
#import "WorkSectionHeaderView.h"
#import "EditModuleVC.h"

#define HeaderView @"WorkSectionHeaderView"
#define FooterView @"FooterView"


@interface MoreModuleVC ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    __weak IBOutlet UICollectionView *_mainCollectionView;
    
    __weak IBOutlet UICollectionViewFlowLayout *_mainFlowLayOut;

    __weak IBOutlet UIView *_TopView;
    __weak IBOutlet UIButton *_moreBtn;
    
}

@end

@implementation MoreModuleVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setNavTitle:@"更多应用"
       leftButtonItem:[self customBarItemButton:nil
                                backgroundImage:nil
                                     foreground:@"back"
                                            sel:@selector(back)]
      rightButtonItem:nil];
    

    [self initView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    _mainCollectionView.contentOffset = CGPointZero;
}

- (void)initView {
    // 循环创建首页应用
    _homeModuleArr = @[@"1",@"1",@"1",@"1",@"1",@"1",@"1",@"1"];
    NSInteger count = _homeModuleArr.count;
    for (int i = 0;  i < count; i ++)
    {
        if (count < 7)
        {
            _moreBtn.hidden = YES;
            CGFloat width = (APP_SCREEN_WIDTH - 120) / (count - 1) * 10;
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((width * i) + 10 + 80, 0, width, 50)];
            imgView.backgroundColor = [UIColor redColor];
            [_TopView addSubview:imgView];
        }
        else
        {
            _moreBtn.hidden = NO;
        }
    }

    _mainFlowLayOut.minimumInteritemSpacing = 0;
    _mainFlowLayOut.minimumLineSpacing = 10;
    _mainFlowLayOut.itemSize = CGSizeMake(APP_SCREEN_WIDTH / 4, 80);
    _mainFlowLayOut.headerReferenceSize = CGSizeMake(APP_SCREEN_WIDTH, 40);
    _mainFlowLayOut.footerReferenceSize = CGSizeMake(APP_SCREEN_WIDTH, 120);

    _mainCollectionView.frame = CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT - APP_NAV_HEIGHT - APP_TAR_HEIGHT);
    _mainCollectionView.backgroundColor = [UIColor whiteColor];
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
    _mainCollectionView.showsVerticalScrollIndicator = NO;

    // 组头视图
    [_mainCollectionView registerNib:[UINib nibWithNibName:HeaderView bundle:nil]
          forSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                 withReuseIdentifier:HeaderView];

    // 组尾视图
    [_mainCollectionView registerClass:[UICollectionReusableView class]
            forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                   withReuseIdentifier:FooterView];

    if (@available(iOS 11.0, *))
    {
        _mainCollectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else
    {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }

}

#pragma mark - editClick

- (void)editClick:(UIButton *)btn {
    EditModuleVC *editModuleVC = [[EditModuleVC alloc] init];
    [self.navigationController pushViewController:editModuleVC animated:YES];
}

#pragma mark - <UICollectionViewDelegate>

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section {
    return 21;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    if (kind == UICollectionElementKindSectionHeader)
    {
        // 头视图
        WorkSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                               withReuseIdentifier:HeaderView
                                                                                      forIndexPath:indexPath];
        headerView.titleLabel.text = @"所有应用";
        headerView.lineView.hidden = YES;
        return headerView;
    }

    // 尾视图
    UICollectionReusableView *footerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                                                              withReuseIdentifier:FooterView
                                                                                     forIndexPath:indexPath];
    footerView.backgroundColor = AppBackgroundColor;
    UIButton *editBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    editBtn.frame = CGRectMake((APP_SCREEN_WIDTH - 80) / 2, 5, 80, 92);
    [footerView addSubview:editBtn];
    [editBtn setImage:[UIImage imageNamed:@"编辑"] forState:UIControlStateNormal];
    [editBtn addTarget:self action:@selector(editClick:) forControlEvents:UIControlEventTouchUpInside];
    return footerView;

}


- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    NSString *identifier = @"WorkItemCell";
    UINib *nib = [UINib nibWithNibName:identifier bundle:[NSBundle mainBundle]];
    [collectionView registerNib:nib forCellWithReuseIdentifier:identifier];

    WorkItemCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:identifier
                                                                   forIndexPath:indexPath];
    item.itemWidth.constant = 50;
    item.itemHeight.constant = 50;
    item.titleLabel.textColor = MainGrayFontColor;
    [item fillDataWithString:@"通盘房源" andImgString:@"通盘房源"];
    return item;
}

@end
