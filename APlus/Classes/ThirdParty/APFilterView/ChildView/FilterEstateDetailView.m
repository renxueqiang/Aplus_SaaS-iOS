//
//  FilterEstateDetailView.m
//  APlusFilterView
//
//  Created by 张旺 on 2017/10/25.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "FilterEstateDetailView.h"
#import "APFilterView.h"
#import "ItemView.h"
#import "FilterListCell.h"

@interface FilterEstateDetailView () <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
{
    // 价格需要用两个tablew关联
    UITableView *_firstTableView;
    UITableView *_secondTableView;
    
    // 价格自定义输入
    UIView *_priceInputView;
    
    NSMutableArray *_dataSourceArray;
    NSMutableArray *_itemTitleArray;
    NSInteger _selectIndex;
    NSInteger _firstTabSelectCellIndex;     // 第一个tablew选中的行数  0:出租，1:出售
    FilterType _estateFilterListType;
    APFilterEntity *_filterEntity;
}

@end

@implementation FilterEstateDetailView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        // 默认选中第一行
        _firstTabSelectCellIndex = 0;
    }
    return self;
}

- (void)setTableViewNumber:(NSInteger)tableViewNumber
{
    _tableViewNumber = tableViewNumber;
    
    _firstTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
    _firstTableView.delegate = self;
    _firstTableView.dataSource = self;
    _firstTableView.tableFooterView = [[UIView alloc]init];
    [self addSubview:_firstTableView];
    
    // 如需要两个tableView则添加两个
    if (tableViewNumber == 2)
    {
        _firstTableView.backgroundColor = UIColorFromHex(0xf9f9f9, 1.0);
        _secondTableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        _secondTableView.delegate = self;
        _secondTableView.dataSource = self;
        _secondTableView.tableFooterView = [[UIView alloc]init];
        [self addSubview:_secondTableView];
        
        [self addSubview:[self createInputView]];
    }
}

/// 创建价格输入视图
- (UIView *)createInputView
{
    if ([_itemTitleArray[_selectIndex] isEqualToString:@"价格"])
    {
        _priceInputView = [[UIView alloc] initWithFrame:CGRectMake(0, TableViewCellHeight * 8, APP_SCREEN_WIDTH, 46)];
        [_priceInputView setBackgroundColor:[UIColor whiteColor]];
        
        UILabel *cusPriceLabel = [[UILabel alloc]init];
        cusPriceLabel.text = @"自定义";
        cusPriceLabel.textColor = UIColorFromHex(0x333333, 1.0);
        cusPriceLabel.font = [UIFont fontWithName:FontName
                                             size:12.0];
        
        // 最小价格
        UITextField *minPriceTextField = [[UITextField alloc]init];
        minPriceTextField.placeholder = @"最小";
        [minPriceTextField setValue:UIColorFromHex(0x999999, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
        minPriceTextField.textColor = UIColorFromHex(0x666666, 1.0);
        minPriceTextField.layer.cornerRadius = 4.0;
        minPriceTextField.font = [UIFont fontWithName:FontName
                                                 size:12.0];
        minPriceTextField.keyboardType = UIKeyboardTypeNumberPad;
        minPriceTextField.backgroundColor = UIColorFromHex(0xEEEEEE, 1.0);
        minPriceTextField.delegate = self;
        minPriceTextField.textAlignment = NSTextAlignmentCenter;
        
        // 最小价格与最大价格之间的分割线
        UIImageView *middleHorizontalLine = [[UIImageView alloc]init];
        [middleHorizontalLine setImage:[UIImage imageNamed:@"horizontal_seperator _line"]];
        
        // 最大价格
        UITextField *maxPriceTextField = [[UITextField alloc]init];
        maxPriceTextField.placeholder = @"最大";
        [maxPriceTextField setValue:UIColorFromHex(0x999999, 1.0) forKeyPath:@"_placeholderLabel.textColor"];
        maxPriceTextField.textColor = UIColorFromHex(0x666666, 1.0);
        maxPriceTextField.layer.cornerRadius = 4.0;
        maxPriceTextField.font = [UIFont fontWithName:FontName
                                                 size:12.0];
        maxPriceTextField.keyboardType = UIKeyboardTypeNumberPad;
        maxPriceTextField.backgroundColor = UIColorFromHex(0xEEEEEE, 1.0);
        maxPriceTextField.delegate = self;
        maxPriceTextField.textAlignment = NSTextAlignmentCenter;
        
        // 确定按钮
        UIButton *confirmBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [confirmBtn setTitle:@"确认"
                    forState:UIControlStateNormal];
        [confirmBtn setBackgroundImage:[UIImage imageNamed:@"confirmBtn_bg"] forState:UIControlStateNormal];
        confirmBtn.titleLabel.font = [UIFont fontWithName:FontName
                                                     size:12.0];
        [confirmBtn setTitleColor:[UIColor whiteColor]
                         forState:UIControlStateNormal];
        
        [_priceInputView addSubview:cusPriceLabel];
        [_priceInputView addSubview:minPriceTextField];
        [_priceInputView addSubview:middleHorizontalLine];
        [_priceInputView addSubview:maxPriceTextField];
        [_priceInputView addSubview:confirmBtn];
        
        // 设置约束
        [cusPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(10);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.width.mas_equalTo(40);
        }];
        
        [middleHorizontalLine mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(0);
            make.centerX.equalTo(_priceInputView.mas_centerX).with.offset(-34);
            make.width.mas_equalTo(10);
            make.height.mas_equalTo(1.5);
        }];
        
        [minPriceTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(cusPriceLabel.mas_right).with.offset(13);
            make.centerY.mas_equalTo(0);
            make.right.equalTo(middleHorizontalLine.mas_left).with.offset(-5);
            make.height.mas_equalTo(23);
        }];
        
        [maxPriceTextField mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(middleHorizontalLine.mas_right).with.offset(5);
            make.centerY.mas_equalTo(0);
            make.right.equalTo(confirmBtn.mas_left).with.offset(-20);
            make.height.mas_equalTo(23);
        }];
        
        [confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(100);
            make.right.mas_equalTo(-10);
            make.height.mas_equalTo(23);
        }];
    }
    return  _priceInputView;
}

- (void)setDataSourceWithDataArray:(NSArray *)dataArray
                 andItemTitleArray:(NSArray *)itemTitleArray
                    andSelectIndex:(NSInteger)selectIndex
                   andFilterEntity:(APFilterEntity *)filterEntity
{
    _dataSourceArray = [[NSMutableArray alloc] initWithArray:dataArray];
    _itemTitleArray = [itemTitleArray mutableCopy];
    _selectIndex = selectIndex;
    _filterEntity = filterEntity;
    
    // 默认第一个tablew选中第一行
    if ([_filterEntity.salePriceStr contains:@"万"] || [_filterEntity.estateDealTypeStr isEqualToString:@"出售"])
    {
        _firstTabSelectCellIndex = 1;
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableViewNumber == 1)
    {
        return [_dataSourceArray[_selectIndex] count];
    }
    else
    {
        if (tableView == _firstTableView)
        {
            if ([_filterEntity.estateDealTypeStr contains:@"出"])
            {
                return 1;
            }
            return [_dataSourceArray[_selectIndex] count];
        }
        else
        {
            NSDictionary *dic = _dataSourceArray[_selectIndex];
            return [[dic objectForKey:[_dataSourceArray[_selectIndex] allKeys][_firstTabSelectCellIndex]] count];
        }
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return TableViewCellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FilterListCell * filterListCell = [FilterListCell cellWithTableView:tableView];
    if (self.tableViewNumber == 1)
    {
        filterListCell.filterLabel.text = _dataSourceArray[_selectIndex][indexPath.row];

        // 筛选实体中的字段设为红色
        if ([_dataSourceArray[_selectIndex][indexPath.row] isEqualToString: _filterEntity.estateDealTypeStr] || [_dataSourceArray[_selectIndex][indexPath.row] isEqualToString: _filterEntity.tagStr]
              || [_dataSourceArray[_selectIndex][indexPath.row] isEqualToString: _filterEntity.transactType]
              || [_dataSourceArray[_selectIndex][indexPath.row] isEqualToString: _filterEntity.clientState]
              || [_dataSourceArray[_selectIndex][indexPath.row] isEqualToString: _filterEntity.clientDatum])
        {
            filterListCell.filterLabel.textColor = UIColorFromHex(0xff3333, 1.0);
        }
        else
        {
            filterListCell.filterLabel.textColor = UIColorFromHex(0x333333, 1.0);
        }
    }
    else
    {
        if (tableView == _firstTableView)
        {
            // 选中时的状态，字体变红，背景变白
            if (indexPath.row == _firstTabSelectCellIndex || [_filterEntity.estateDealTypeStr contains:@"出"])
            {
                filterListCell.filterLabel.textColor = UIColorFromHex(0xff3333, 1.0);
                filterListCell.contentView.backgroundColor = [UIColor whiteColor];
            }
            else
            {
                filterListCell.filterLabel.textColor = UIColorFromHex(0x666666, 1.0);
                filterListCell.contentView.backgroundColor = UIColorFromHex(0xf9f9f9, 1.0);
            }
            
            if ([_filterEntity.estateDealTypeStr isEqualToString:@"出售"])
            {
                filterListCell.filterLabel.text = [_dataSourceArray[_selectIndex] allKeys][indexPath.row + 1];
            }
            else
            {
               filterListCell.filterLabel.text = [_dataSourceArray[_selectIndex] allKeys][indexPath.row];
            }
        }
        else
        {
            NSArray * dataArray = [_dataSourceArray[_selectIndex] allKeys];
            NSString *priceStr = [_dataSourceArray[_selectIndex] objectForKey:dataArray[_firstTabSelectCellIndex]][indexPath.row];
            
            filterListCell.filterLabel.textColor = UIColorFromHex(0x333333, 1.0);
            
            // 如果筛选过价格筛选实体中的字段设为选中，没有默认选中第一行不限
            if (_filterEntity.salePriceStr.length > 0 || _filterEntity.rentPriceStr.length > 0)
            {
                if ([priceStr isEqualToString:_filterEntity.salePriceStr] || [priceStr isEqualToString:_filterEntity.rentPriceStr])
                {
                    filterListCell.filterLabel.textColor = UIColorFromHex(0xff3333, 1.0);
                }
            }
            else
            {
                if (indexPath.row == 0)
                {
                    filterListCell.filterLabel.textColor = UIColorFromHex(0xff3333, 1.0);
                }
            }
            
            

            filterListCell.filterLabel.text = priceStr;
        }
    }

    return filterListCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath
                             animated:YES];
    
    // 改变ItemView箭头文字颜色以及将选择的文字回调
    UILabel *lastSelectLabel = (UILabel *)[[super superview] viewWithTag:ItemTitleBaseTag + _selectIndex];
    UIImageView *selectArrowImg = (UIImageView *)[[super superview] viewWithTag:ArrowImageBaseTag + _selectIndex];

    if (self.tableViewNumber == 2)
    {
        // 第一个tablew
        if (tableView == _firstTableView)
        {
            
            if (indexPath.row == 0)
            {
                // 出租
                _firstTabSelectCellIndex = 0;
            }
            else
            {
                // 出售
                _firstTabSelectCellIndex = 1;
            }
            [_firstTableView reloadData];
            [_secondTableView reloadData];
            return;
        }
        else
        {
            // 第二个tablew
            NSArray * dataArray = [_dataSourceArray[_selectIndex] allKeys];
            NSString *priceStr = [_dataSourceArray[_selectIndex] objectForKey:dataArray[_firstTabSelectCellIndex]][indexPath.row];
           
            if (_firstTabSelectCellIndex == 0)
            {
                _filterEntity.priceType = @"出租价格(元)";
                _filterEntity.rentPriceStr = priceStr;
                _filterEntity.salePriceStr = @"";
            }
            else
            {
                _filterEntity.priceType = @"出售价格(万)";
                _filterEntity.salePriceStr = priceStr;
                _filterEntity.rentPriceStr = @"";
            }
            lastSelectLabel.text = [priceStr isEqualToString:@"不限"]? @"价格":priceStr;
        }
    }
    else
    {
        // 只有一个tablew
        NSString *selectLabel = _dataSourceArray[_selectIndex][indexPath.row];
        if ([_itemTitleArray[_selectIndex] isEqualToString:@"全部"])
        {
            _filterEntity.estateDealTypeStr = selectLabel;
            lastSelectLabel.text = _filterEntity.estateDealTypeStr;
            
            // 选择房源类型，清空价格标签
            _filterEntity.priceType = @"价格";
            _filterEntity.rentPriceStr = @"";
            _filterEntity.salePriceStr = @"";
            UILabel *priceLabel =  (UILabel *)[[super superview] viewWithTag:ItemTitleBaseTag + 1];
            UIImageView *priceArrowImg = (UIImageView *)[[super superview] viewWithTag:ArrowImageBaseTag + 1];
            priceLabel.text = @"价格";
            priceLabel.textColor = UIColorFromHex(0x333333, 1.0);
            [priceArrowImg setImage:[UIImage imageNamed:ArrowDownGrayImgName]];
        }
        else if ([_itemTitleArray[_selectIndex] isEqualToString:@"标签"])
        {
            _filterEntity.tagStr = [selectLabel isEqualToString:@"不限"]? @"标签":selectLabel;
            lastSelectLabel.text = _filterEntity.tagStr;
        }
        else if ([_itemTitleArray[_selectIndex] isEqualToString:@"交易类型"])
        {
            _filterEntity.transactType = [selectLabel isEqualToString:@"不限"]? @"交易类型":selectLabel;
            lastSelectLabel.text = _filterEntity.transactType;
        }
        else if ([_itemTitleArray[_selectIndex] isEqualToString:@"客户状态"])
        {
            _filterEntity.clientState = [selectLabel isEqualToString:@"有效"]? @"客户状态":selectLabel;
            lastSelectLabel.text = _filterEntity.clientState;
        }
        else if ([_itemTitleArray[_selectIndex] isEqualToString:@"资料完整度"])
        {
            _filterEntity.clientDatum = [selectLabel isEqualToString:@"不限"]? @"资料完整度":selectLabel;
            lastSelectLabel.text = _filterEntity.clientDatum;
        }
    }
    
    if (self.block)
    {
        self.block(lastSelectLabel.text);
    }
    
    // 选择的是第一行 则ItemView上的颜色不变
    if (indexPath.row == 0)
    {
        lastSelectLabel.textColor = UIColorFromHex(0x333333, 1.0);
        [selectArrowImg setImage:[UIImage imageNamed:ArrowDownGrayImgName]];
    }
    else
    {
        lastSelectLabel.textColor = UIColorFromHex(0xff3333, 1.0);
        [selectArrowImg setImage:[UIImage imageNamed:ArrowDownRedImgName]];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        if (self.tableViewNumber == 1)
        {
            [cell setSeparatorInset:UIEdgeInsetsMake(0, 14, 0, 14)];
        }
        else
        {
            if (tableView == _firstTableView)
            {
                if (indexPath.row == _firstTabSelectCellIndex || [_filterEntity.estateDealTypeStr contains:@"出"])
                {
                    [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
                }
                else
                {
                    [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, cell.bounds.size.width)];
                }
            }else
            {
                [cell setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 14)];
            }
        }
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _firstTableView.frame = CGRectMake(0, 0, self.frame.size.width, [_dataSourceArray[_selectIndex] count] * TableViewCellHeight);
    
    if (self.tableViewNumber == 2)
    {
        NSDictionary *dic = _dataSourceArray[_selectIndex];
        NSInteger _listDataNumber = [[dic objectForKey:[_dataSourceArray[_selectIndex] allKeys][_firstTabSelectCellIndex]] count];
        
        _firstTableView.frame = CGRectMake(0, 0, self.frame.size.width / 3, _listDataNumber * TableViewCellHeight);
        _secondTableView.frame = CGRectMake(self.frame.size.width / 3, 0, self.frame.size.width - self.frame.size.width / 3, (_listDataNumber - 1) * TableViewCellHeight);
    }
}

@end
