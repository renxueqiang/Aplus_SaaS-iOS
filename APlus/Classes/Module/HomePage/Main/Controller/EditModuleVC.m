//
//  EditModuleVC.m
//  APlus
//
//  Created by 李慧娟 on 2017/10/24.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "EditModuleVC.h"
#import "GridCell.h"
#import "EditModuleView.h"

#define GridCellIdtifier    @"GridCell"


@interface EditModuleVC ()<EditorModuleProtocal,UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
{
    __weak IBOutlet EditModuleView *_editView;
    __weak IBOutlet UICollectionView *_allCollectionView;
    __weak IBOutlet UICollectionViewFlowLayout *_flowLayOut;

    NSMutableArray *_titleArr;
    NSMutableArray *_imgNameArr;
    NSMutableArray *_idArr;
    NSArray *_dataArr;

    NSInteger _lastRowCount;    // 之前的行数
}

@end

@implementation EditModuleVC

- (void)viewDidLoad {
    [super viewDidLoad];

    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 50, 20);
    [rightBtn setTitle:@"完成" forState:UIControlStateNormal];
    [rightBtn setTitleColor:MainRedColor forState:UIControlStateNormal];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:16.0];

    [self setNavTitle:@"编辑首页应用"
       leftButtonItem:[self customBarItemButton:nil
                                backgroundImage:nil
                                     foreground:@"back"
                                            sel:@selector(back)]
      rightButtonItem:rightBtn];

    [self initData];

}


- (void)initData {
    _lastRowCount = 2;
    _titleArr = [NSMutableArray arrayWithObjects:@"通盘房源",@"房源贡献",@"我的收藏",@"我的客户",@"抢公盘",@"抢公客",@"渠道来电", nil];

    _imgNameArr = [NSMutableArray arrayWithObjects:@"通盘房源",@"房源贡献",@"我的收藏",@"我的客户",@"抢公盘",@"抢公客",@"渠道来电", nil];
    _idArr = [NSMutableArray arrayWithObjects:
              @"1000",@"1001", @"1002",
              @"1003",@"1004",@"1005" ,@"1006", nil];
    
    //如果个数小于12 就添加占位
    if (_titleArr.count < MAX_COUNT)
    {
        [_titleArr addObject:@"占位"];
        [_imgNameArr addObject:@"虚线框"];
        [_idArr addObject:@"0"];
    }
    [self initView];

    /*********首页全部应用假数据*************/
    NSMutableArray *mArr = [NSMutableArray array];
    for (int i = 0; i < _titleArr.count * 2 - 3; i++)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        if (i >= _titleArr.count - 1)
        {
            [dic setObject:_titleArr[i - (_titleArr.count - 1)] forKey:@"title"];
            [dic setObject:_imgNameArr[i - (_imgNameArr.count - 1)] forKey:@"image"];
        }
        else
        {
            [dic setObject:_titleArr[i] forKey:@"title"];
            [dic setObject:_imgNameArr[i] forKey:@"image"];
        }
        [dic setObject:[NSString stringWithFormat:@"%d", 1000 + i] forKey:@"gridID"];
        [mArr addObject:dic];
    }
    _dataArr = mArr;
    [_allCollectionView reloadData];

}

- (void)initView {
    [_editView creatViewWithTitleArr:_titleArr WithImgArr:_imgNameArr WithIdArr:_idArr];
    _editView.delegate = self;

    _flowLayOut.minimumInteritemSpacing = 0;
    _flowLayOut.minimumLineSpacing = 10;
    CGFloat width = (APP_SCREEN_WIDTH - 50) / 4;
    _flowLayOut.itemSize = CGSizeMake(width, width);

    _allCollectionView.backgroundColor = [UIColor whiteColor];
    _allCollectionView.delegate = self;
    _allCollectionView.dataSource = self;
    _allCollectionView.showsVerticalScrollIndicator = NO;

    UINib *attentionNib = [UINib nibWithNibName:GridCellIdtifier bundle:nil];
    [_allCollectionView registerNib:attentionNib forCellWithReuseIdentifier:GridCellIdtifier];
}


#pragma mark - <UICollectionViewDelegate>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _dataArr.count;
}
- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView
                                   cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    GridCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:GridCellIdtifier
                                                               forIndexPath:indexPath];
    [cell fillDataWithDic: _dataArr[indexPath.row] WithIdArr:_idArr];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    GridCell *cell = (GridCell *)[collectionView cellForItemAtIndexPath:indexPath];
    if (cell.addBtn.hidden == NO)
    {
        NSDictionary *seletedDic = _dataArr[indexPath.row];
        [_editView addBoxActionWithIsEmpty:NO WithDataDic:seletedDic];
    }
}

#pragma mark - <EditorModuleProtocal>

- (void)finishedRemoveGrid {
    NSLog(@"删除成功-----%@", _idArr);
    // 计算行数
    NSInteger count = _idArr.count;
    NSInteger row = count / 4;
    NSInteger rowCount = count % 4 == 0 ? row : row + 1;
    if (_lastRowCount != rowCount)
    {
        CGFloat addWidth;
        if (rowCount == 3)
        {
            addWidth = 80;
        }
        else
        {
            addWidth = 68;
        }
        self.editViewHeight.constant = rowCount * GridHeight + addWidth;
    }

    _lastRowCount = rowCount;
    [_allCollectionView reloadData];
}

- (void)finishedAddGrid {
    NSLog(@"添加完成------%@", _idArr);
    // 计算行数
    NSInteger count = _idArr.count;
    NSInteger row = count / 4;
    NSInteger rowCount = count % 4 == 0 ? row : row + 1;
    if (_lastRowCount != rowCount)
    {
        CGFloat addWidth;
        if (rowCount == 3)
        {
            addWidth = 80;
        }
        else
        {
            addWidth = 68;
        }
        self.editViewHeight.constant = rowCount * GridHeight + addWidth;
    }

    _lastRowCount = rowCount;
    [_allCollectionView reloadData];
}

- (void)finishedMoveGrid {
    NSLog(@"移动完成-----%@", _idArr);
}



@end
