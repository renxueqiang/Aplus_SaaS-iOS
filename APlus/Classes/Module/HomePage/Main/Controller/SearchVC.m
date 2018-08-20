//
//  SearchVC.m
//  APlus
//
//  Created by 李慧娟 on 2017/10/16.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "SearchVC.h"
#import "SelectBtnView.h"
#import "SearchListCell.h"
#import "EstateListVC.h"

#import "PropertyApi.h"
#import "SearchPropertyManager.h"

#define SearchEstateTF_Tag  1000
#define SearchHouseNum_Tag  2000

@interface SearchVC ()<SelectBtnDelegate,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    IBOutlet UIView *_headerView;                   // 头视图
    __weak IBOutlet SelectBtnView *_selectView;     // 选择视图
    __weak IBOutlet UITextField *_searchEstateTF;   // 搜索楼盘栋座等TextField
    __weak IBOutlet UITextField *_searchHouseNumTF; // 搜索房号TextField
    UITableView *_mainTableView;

    SearchPropApi *_searchPropApi;
    SearchPropDetailEntity *_searchEntity;          // 选中的某条搜索记录
    NSArray *_dataArr;

    BOOL _isSearchNow;                              // 是否要进行搜索
    BOOL _isHistoryData;// 显示数据是否为搜索的历史记录

    NSString *_searchPropText;                      // 楼盘
    CGFloat _headerHeight;
    SearchPropertyManager *_searchPropManager;

}

@end

@implementation SearchVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self setNavTitle:@"搜索"
       leftButtonItem:[self customBarItemButton:nil
                                backgroundImage:nil
                                     foreground:@"back"
                                            sel:@selector(back)]
      rightButtonItem:nil];
    

    [self initView];

    //获取搜索历史记录
    [self getSearchHistoryData];
}

- (void)initView
{
    // 头视图
    _headerHeight = 150;
    _selectView.titleArr = @[@"楼盘地址",@"房源编号"];
    _selectView.selectBtnDelegate = self;
    [self setHeaderViewFrameWithHiddenHouseNumTF:YES];

    UIView *searchView = [_headerView viewWithTag:1111];
    searchView.layer.shadowOffset = CGSizeMake(0, 3);
    searchView.layer.shadowColor = [UIColor blackColor].CGColor;
    searchView.layer.shadowRadius = 3;
    searchView.layer.shadowOpacity = 0.3;
    _searchHouseNumTF.layer.borderColor = RGBColor(230, 230, 230).CGColor;
    _searchHouseNumTF.layer.borderWidth = 1;
    _searchEstateTF.delegate = self;
    _searchHouseNumTF.delegate = self;
    [self.view addSubview:_headerView];

    // 表视图
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, _headerHeight, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT - APP_NAV_HEIGHT - _headerHeight)
                                                  style:UITableViewStylePlain];
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];

    if (@available(iOS 11.0, *))
    {
        _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else
    {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }
}

- (void)setHeaderViewFrameWithHiddenHouseNumTF:(BOOL)isHidden
{
    _headerView.frame = CGRectMake(0, 0, APP_SCREEN_WIDTH, _headerHeight);
    _searchHouseNumTF.hidden = isHidden;

    _mainTableView.top = _headerHeight;
    _mainTableView.height = APP_SCREEN_HEIGHT - APP_NAV_HEIGHT - _headerHeight;
}

- (void)getSearchHistoryData
{
    _searchPropManager = [[SearchPropertyManager alloc] init];
    NSDictionary *history = [_searchPropManager selectSearchResultType:PropListSearchType];
    NSArray *dataArr = [history valueForKey:PropListSearchType];
    NSLog(@"%@",history);
    NSMutableArray *mArr = [NSMutableArray array];
    for (NSString *jsonStr in dataArr)
    {
        SearchPropDetailEntity *entity = [DataConvert convertData:jsonStr toEntity:[SearchPropDetailEntity class]];
        [mArr addObject:entity];
    }

    _dataArr = mArr;
    mArr = nil;

    if (_dataArr.count == 0)
    {
        _mainTableView.hidden = YES;
    }
    else
    {
        _isHistoryData = YES;
    }
}

#pragma mark - RequestData

- (void)requestData
{
    _searchPropApi = [[SearchPropApi alloc] init];
    _searchPropApi.name = _searchPropText;
    _searchPropApi.topCount = @"10";
    _searchPropApi.estateSelectType = _estateSelectType;
    _searchPropApi.buildName = @"";
    [_manager sendRequest:_searchPropApi];
}

#pragma mark - <SelectBtnDelegate>

- (void)didSelectWithBtnIndex:(NSInteger)selectBtnIndex
{
    _searchEstateTF.text = nil;
    _searchHouseNumTF.text = nil;
    _searchHouseNumTF.hidden = YES;
    [_searchEstateTF resignFirstResponder];
    [_searchHouseNumTF resignFirstResponder];
    _dataArr = nil;
    _isHistoryData = NO;
    _headerHeight = 150;
    [self setHeaderViewFrameWithHiddenHouseNumTF:YES];

    if (selectBtnIndex == 0)
    {
        _searchEstateTF.placeholder = @"输入城区、片区、楼盘名";
    }
    else
    {
        _searchEstateTF.placeholder = @"输入房源编号";
    }

    [_mainTableView reloadData];
}

#pragma mark - <UITextFieldDelegate>

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField becomeFirstResponder];

}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *inputString = [textField.text stringByReplacingCharactersInRange:range withString:string];
    if (textField.tag == SearchEstateTF_Tag)
    {
        // 搜索楼盘、栋座等
        if (_searchHouseNumTF.hidden == NO)
        {
            _headerHeight = 150;
            [self setHeaderViewFrameWithHiddenHouseNumTF:YES];
        }
        _estateSelectType = [NSString stringWithFormat:@"%d",EstateSelectTypeEnum_ALLNAME];
        _searchPropText = inputString;
        [self requestData];
    }
    else
    {
        // 搜索房号
        if (inputString.length > 0)
        {
            _searchEntity.houseNo = inputString;
        }

    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    if (_searchHouseNumTF.hidden == NO)
    {
        // 跳转到房源列表，保存历史记录
        NSDictionary *dic = [DataConvert convertModeltToDic:_searchEntity];
        NSString *jsonStr = [dic JSONString];
        [_searchPropManager insertSearchResultType:PropListSearchType andValue:jsonStr];

    }
}


#pragma mark - 语音输入

- (IBAction)voiceSearchAction:(UIButton *)sender
{

}

#pragma mark - <UITableViewDelegate/UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (_isHistoryData)
    {
        return 50;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (_isHistoryData)
    {
        UIButton *clearBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        clearBtn.frame = CGRectMake(0, 0, APP_SCREEN_WIDTH, 50);
        [clearBtn setTitle:@"清空搜索历史" forState:UIControlStateNormal];
        [clearBtn setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        clearBtn.titleLabel.font = [UIFont systemFontOfSize:14.0];
        return clearBtn;
    }

    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchListCell *cell = (SearchListCell *)[tableView cellFromXib:@"SearchListCell"];
    cell.entity = _dataArr[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    SearchPropDetailEntity *entity = _dataArr[indexPath.row];
    if (_isHistoryData)
    {
        // 搜索历史数据

    }
    else
    {
        // 搜索结果
        _searchEstateTF.text = entity.itemText;
        if (_searchHouseNumTF.hidden == YES)
        {
            // 未显示搜索房号时
            [_searchEstateTF resignFirstResponder];
            _headerHeight = 200;
            [self setHeaderViewFrameWithHiddenHouseNumTF:NO];
            [_searchHouseNumTF becomeFirstResponder];
            _searchEntity = entity;
        }
        else
        {
            // 显示过搜索房号时

        }
    }
}

#pragma mark - <ResponseDelegate>

- (void)dealData:(CentaResponse *)resData
{
    Class modelClass = [resData.api getRespClass];

    if ([modelClass isEqual:[SearchPropEntity class]])
    {
        _isHistoryData = NO;
        SearchPropEntity *entity = resData.data;
        _dataArr = entity.propPrompts;
        if (_dataArr.count > 0)
        {
            _mainTableView.hidden = NO;
        }
        [_mainTableView reloadData];
    }

}

- (void)respFail:(CentaResponse *)error
{

}




@end
