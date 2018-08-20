//
//  WorkViewController.m
//  APlus
//
//  Created by 李慧娟 on 2017/9/20.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "WorkVC.h"
#import "WorkSectionHeaderView.h"
#import "WorkItemCell.h"

#define WorkCellIdentifier @"WorkItemCell"

#define WashClientBtnTag    1000
#define WashAreaBtnTag      2000

@interface WorkVC ()<UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> {
    
    __weak IBOutlet UICollectionView *_mainCollectionView;
    __weak IBOutlet UICollectionViewFlowLayout *_mainFlowLayOut;
    UIView *_headerView;

    NSArray *_dataArr;
    NSArray *_imgArr;   // 图片数组
    
}

@end

@implementation WorkVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setNavTitle:@"工作"
       leftButtonItem:nil
      rightButtonItem:nil];


    [self initView];

    //假数据
    _dataArr = @[@[@"工具",@"房贷计算器",@"税费计算",@"通讯录",@"快速匹配",@"笋盘匹配"],
                 @[@"查询",@"佣金查询",@"办事地点",@"交易进度"],
                 @[@"审核",@"实勘审核",@"委托审核",@"开盘审核",@"不租不售"],
                 @[@"日常工作",@"我的客户",@"我的店铺",@"录入客户"],
                 @[@"数据",@"数据看板",@"业绩排名"],
                 @[@"其他",@"考勤信息"]
                 ];
    
    _imgArr = @[@[@"房贷计算器",@"税费计算",@"通讯录",@"快速匹配",@"笋盘匹配"],
                @[@"佣金查询",@"办事地点",@"交易进度"],
                @[@"RealSurvey",@"委托",@"开盘审核",@"不租不售"],
                @[@"MyClient",@"我的店铺",@"录入客户"],
                @[@"ODC",@"业绩排名"],
                @[@"考勤信息"]
                ];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

//    self.hidesBottomBarWhenPushed = NO;
    [_mainCollectionView setContentOffset:CGPointZero];
}

- (void)initView
{
    _mainFlowLayOut.minimumInteritemSpacing = 0;
    _mainFlowLayOut.minimumLineSpacing = 10;
    _mainFlowLayOut.itemSize = CGSizeMake(APP_SCREEN_WIDTH / 4, 80);
    _mainFlowLayOut.headerReferenceSize = CGSizeMake(APP_SCREEN_WIDTH, 40);

    _mainCollectionView.frame = CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT - APP_NAV_HEIGHT - APP_TAR_HEIGHT);
    _mainCollectionView.backgroundColor = [UIColor whiteColor];
    _mainCollectionView.delegate = self;
    _mainCollectionView.dataSource = self;
//    _mainCollectionView.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    _mainCollectionView.showsVerticalScrollIndicator = NO;

    //头视图
    [_mainCollectionView addSubview:self.workHeaderView];
    _mainCollectionView.contentInset = UIEdgeInsetsMake(120, 0, 0, 0);

    //组头视图
    [_mainCollectionView registerNib:[UINib nibWithNibName:@"WorkSectionHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WorkSectionHeaderView"];
    UINib *attentionNib = [UINib nibWithNibName:WorkCellIdentifier bundle:nil];
    [_mainCollectionView registerNib:attentionNib forCellWithReuseIdentifier:WorkCellIdentifier];
}

- (UIView *)workHeaderView
{
    if (!_headerView)
    {
        _headerView = [[UIView alloc] initWithFrame:CGRectMake(0, -120, APP_SCREEN_WIDTH  , 120)];
        _headerView.backgroundColor = [UIColor whiteColor];

        CGFloat width = 150;
        CGFloat height = 70;
        UIButton *washClientBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        washClientBtn.tag = WashAreaBtnTag;
        washClientBtn.frame = CGRectMake(APP_SCREEN_WIDTH / 2 - width - 20, 25,width , height);
        [washClientBtn setImage:[UIImage imageNamed:@"洗客"] forState:UIControlStateNormal];
        [washClientBtn addTarget:self
                          action:@selector(WashClientOrAreaClick:)
                forControlEvents:UIControlEventTouchUpInside];
        [_headerView addSubview:washClientBtn];

        UIButton *washAreaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        washAreaBtn.tag = WashAreaBtnTag;
        washAreaBtn.frame = CGRectMake(APP_SCREEN_WIDTH / 2 + 20, 25,width , height);
        [washAreaBtn setImage:[UIImage imageNamed:@"洗盘"] forState:UIControlStateNormal];
        [washAreaBtn addTarget:self
                          action:@selector(WashClientOrAreaClick:)
                forControlEvents:UIControlEventTouchUpInside];

        [_headerView addSubview:washAreaBtn];
    }
    return _headerView;
}

#pragma mark - BtnClick

/// 洗盘／洗客
- (void)WashClientOrAreaClick:(UIButton *)btn
{

}



#pragma mark - UICollectionView

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return _dataArr.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *subArr = _dataArr[section];
    return subArr.count - 1;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
           viewForSupplementaryElementOfKind:(NSString *)kind
                                 atIndexPath:(NSIndexPath *)indexPath
{
    WorkSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader
                                                                           withReuseIdentifier:@"WorkSectionHeaderView"
                                                                                  forIndexPath:indexPath];
    NSArray *subArr = _dataArr[indexPath.section];
    headerView.titleLabel.text = subArr[0];
    if (indexPath.section == 0)
    {
        headerView.lineView.hidden = YES;
    }
    else
    {
        headerView.lineView.hidden = NO;
    }
    return headerView;
}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    WorkItemCell *item = [collectionView dequeueReusableCellWithReuseIdentifier:WorkCellIdentifier
                                                                   forIndexPath:indexPath];
    NSArray *subArr1 = _dataArr[indexPath.section];
    NSArray *subArr2 = _imgArr[indexPath.section];
    [item fillDataWithString:subArr1[indexPath.item + 1] andImgString:subArr2[indexPath.item]];
    return item;
}


@end
