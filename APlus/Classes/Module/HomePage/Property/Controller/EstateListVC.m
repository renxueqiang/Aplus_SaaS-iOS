//
//  EstateListVC.m
//  APlus
//
//  Created by 张旺 on 2017/10/18.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "EstateListVC.h"
#import "EstateListCell.h"
#import "APFilterView.h"
#import "APMenuListView.h"
#import "APSortView.h"

@interface EstateListVC ()<UITableViewDelegate,UITableViewDataSource>
{
    __weak IBOutlet UITableView *_mainTableView;
    __weak IBOutlet NSLayoutConstraint *_backTopBtnConstraint;    // 返回顶部Constraint
    
    __weak IBOutlet NSLayoutConstraint *_sortBtnConstraint;       //Constraint
    
    UIButton *_searchRightBtn;                  // 搜索框右部语音按钮
    UIButton *_searchTextBtn;                   // 搜索框文字搜索按钮
    UIButton *_navRightBtn;                     // 导航栏右边按钮
    
    NSString *_selectSortStr;                   // 默认选中的排序
}

@end

@implementation EstateListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    [self initData];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController.navigationBar setShadowImage:[UIImage imageNamed:@"nav_line_clear"]];
}

- (void)initView
{
    // 创建筛选view
    [self creatFilterView];

    // 创建右部语音搜索按钮
    _searchRightBtn = [self createVoiceSearchBtnWithSelector:@selector(clickVoiceSearch)];
    
    // 创建文字搜索按钮
    _searchTextBtn = [self createTextSearchBtnWithSelector:@selector(clickTextSearch)];
    
    // 创建搜索框
    [self createTopSearchBarViewWithTextSearchBtn:_searchTextBtn
                                      andRightBtn:_searchRightBtn
                                   andPlaceholder:@"请输入地区、片区、楼盘名"];
    
    if (IS_iPhone_X)
    {
        self.viewBottmConstant.constant = BOTTOM_SAFE_HEIGHT;
    }
    
    [self setNavTitle:@"房源列表"
       leftButtonItem:[self customBarItemButton:nil
                                backgroundImage:nil
                                     foreground:@"back"
                                            sel:@selector(back)]
      rightButtonItem:[self customBarItemButton:nil
                                backgroundImage:nil
                                     foreground:@"更多_black"
                                            sel:@selector(clickRightBtnItem:)]];
    _mainTableView.tableFooterView = [[UIView alloc] init];
}

- (void)creatFilterView
{
    APFilterView * filterView = [[APFilterView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, FilterViewHeight)];
    
    [filterView createFiterViewWithItemTitleArray:@[@"全部",@"价格",@"标签",@"更多"] andDataSourceArray:[self getDataArray] andFiterType:FilterEstateType andBlock:^(NSString *fiterStr) {
        
        NSLog(@"%@",fiterStr);
    }];
    [self.view addSubview:filterView];
}

- (NSArray *)getDataArray
{
    // 模拟数据
    NSArray *arr1 = @[@"全部",@"出租",@"出售",@"租售"];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    NSArray *array1 = @[@"不限",@"500以下",@"1000~1500元",@"1500~2000元",@"2000~2500元",@"2500~3000元",@"3000~3500元",@"3500~4000元",@"4000~4500元"];
    NSArray *array2 = @[@"不限",@"100万以下",@"100~150万",@"150~200万",@"200~250万",@"250~300万",@"300~350万",@"350~400万",@"400~450万"];
    
    [dic setValue:array1 forKey:@"出租价格(元)"];
    [dic setValue:array2 forKey:@"出售价格(万)"];
    
    NSArray *arr2 = @[@"不限",@"推荐房源",@"72小时新增房",@"360度全景",@"独家",@"钥匙",@"实勘"];
    
    NSArray * dataArray = @[arr1,dic,arr2];
    
    return dataArray;
}

- (void)initData
{
    _selectSortStr = @"默认排序";
}

#pragma mark - Button Click

/// 点击语音搜索
- (void)clickVoiceSearch
{
    
}

/// 点击文本框搜索
- (void)clickTextSearch
{
    
}

/// 点击导航栏右边更多按钮
- (void)clickRightBtnItem:(UIButton *)button
{
    [[APMenuListView alloc] showMenuWithRalyonView:button menuItemType:DefaultMenuItemType];
}

/// 房源排序
- (IBAction)sortEstateClick:(id)sender
{
    APSortView *sortView = [[APSortView alloc] initWithFrame:MainScreenBounds];
    NSArray * sortArray = @[@"默认排序",@"售价从大到小",@"售价从小到大",@"租价从大到小",@"租价从小到大"];
    [sortView showSortViewWithSortDataArr:sortArray andSelectData:_selectSortStr andCompleteBlock:^(NSString *sortStr) {
        
        _selectSortStr = sortStr;
        NSLog(@"%@",_selectSortStr);
    }];
}

/// 返回顶部
- (IBAction)backTopClick:(id)sender
{
    [_mainTableView setContentOffset:CGPointZero animated:YES];
}

#pragma mark - <UITableViewDelegate/UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 141;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EstateListCell *estateListCell = [EstateListCell cellWithTableView:tableView];
    [estateListCell setCellData];
    return estateListCell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2 && indexPath.row == 2)
    {
        // 查看更多跟进
    }

    if (indexPath.section == 4 && indexPath.row == 2)
    {
        // 查看更多带看历史
    }
}

#pragma mark - 显示或隐藏置顶按钮  - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGPoint scrollEndPoint = scrollView.contentOffset;
    if (scrollEndPoint.y == 0)
    {
        [self.view constraintAnimateWithConstraint:_backTopBtnConstraint andConstant:11.0];
        [self.view constraintAnimateWithConstraint:_sortBtnConstraint andConstant:67.0];
    }
    else if (scrollEndPoint.y > 120)
    {
        [self.view constraintAnimateWithConstraint:_backTopBtnConstraint andConstant:67.0];
        [self.view constraintAnimateWithConstraint:_sortBtnConstraint andConstant:115.0];
    }
}

@end
