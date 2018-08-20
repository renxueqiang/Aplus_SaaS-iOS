//
//  FilterMoreDetailView.m
//  APlusFilterView
//
//  Created by 张旺 on 2017/10/25.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "FilterMoreDetailView.h"
#import "FilterMoreDetailCell.h"

@interface FilterMoreDetailView () <UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UITableView *_mainTableView;
    NSMutableArray *_dataSourceArray;
    NSMutableArray *_selectDataArray;
    NSMutableArray *_cellHeightArray;
}
@end

@implementation FilterMoreDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self = [FilterMoreDetailView viewFromXib];
        self.frame = frame;
        _mainTableView.delegate = self;
        _mainTableView.dataSource = self;
        _mainTableView.tableFooterView = [[UIView alloc] init];
        if (IS_iPhone_X)
        {
            self.buttonBottomConstant.constant = BOTTOM_SAFE_HEIGHT;
            self.backgroundColor = UIColorFromHex(0xf9f9f9, 1.0);
        }
    }
    return self;
}

- (void)setDataSourceArray:(NSMutableArray *)dataSourceArray
      estateFilterListType:(FilterType)estateFilterListType
{
    _dataSourceArray = [dataSourceArray mutableCopy];
    _selectDataArray = [[NSMutableArray alloc] init];
    _cellHeightArray = [[self getCellHeightArray] mutableCopy];
    [_mainTableView reloadData];
}

// - (void)

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSourceArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *heightCacheDict = _cellHeightArray[indexPath.row];
    NSDictionary *filterDict = _dataSourceArray[indexPath.row];
    
    CGFloat cellHeight = [[heightCacheDict valueForKey:@"height"] floatValue];
    
    if ([filterDict.allKeys.firstObject isEqualToString:@"建筑面积（平米)"])
    {
        cellHeight = 82;
    }
    
    return cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FilterMoreDetailCell *cell = [FilterMoreDetailCell cellWithTableView:tableView];
    [cell setCellDataWithDataArray:_dataSourceArray
                    andSelectArray:_selectDataArray
                      andIndexPath:indexPath
                        andLineNum:[[_cellHeightArray[indexPath.row] valueForKey:@"num"] integerValue]];
    return cell;
}

/// 获取TablewCell高度
- (NSMutableArray *)getCellHeightArray
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < _dataSourceArray.count; i++)
    {
        NSDictionary *filterDict = _dataSourceArray[i];
        
        // 1. 计算列数
        __block NSInteger num = 4;
        CGFloat commonFourWidth = (APP_SCREEN_WIDTH-10-10-10*3)/4;
        CGFloat commonThreeWidth = (APP_SCREEN_WIDTH-10-10-10*2)/3;
        
        NSArray *values = filterDict.allValues.firstObject;
        
        [values enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            CGFloat actureW = [obj boundingRectWithSize:CGSizeMake(CGFLOAT_MAX, 15) options:NSStringDrawingUsesFontLeading attributes:nil context:nil].size.width;
            
            if (actureW > commonThreeWidth)
            {
                num = 2;
                *stop = YES;
            }
            else if (actureW > commonFourWidth)
            {
                num = 3;
            }
        }];
        
        // 2. 计算cell高度
        NSInteger lat = values.count % num;
        NSInteger lng = values.count / num;
        if (lat > 0) {
            lng = lng + 1;
        }
        // 高度 =  sectionInsert + itemHeight*lng + LineSpacing*(lng-1)
        CGFloat height = 36 + InteritemSpacing * 2 + lng * ItemHeight + (lng - 1) * LineSpacing;
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        
        [dict setValue:[NSNumber numberWithInteger:num] forKey:@"num"];
        [dict setValue:[NSNumber numberWithFloat:height] forKey:@"height"];
        [array addObject:dict];
    }
    
    return array;
}
@end
