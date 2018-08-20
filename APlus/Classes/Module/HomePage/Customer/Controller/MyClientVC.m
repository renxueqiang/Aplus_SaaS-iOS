//
//  MyClientVC.m
//  APlus
//
//  Created by 张旺 on 2017/11/13.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "MyClientVC.h"
#import "EstateListCell.h"
#import "MyClientCell.h"
#import "APFilterView.h"
#import "APMenuListView.h"
#import "APSortView.h"

@interface MyClientVC ()
{
    __weak IBOutlet UITableView *_mainTableView;
    __weak IBOutlet UIButton *_commonClientBtn;  // 普通客户
    __weak IBOutlet UIButton *_vipClientBtn;     // Vip客户
    
    
    UIButton *_searchRightBtn;                   // 搜索框右部语音按钮
    UIButton *_searchTextBtn;                    // 搜索框文字搜索按钮
    UIButton *_navRightBtn;                      // 导航栏右边按钮
    
    NSString *_selectSortStr;                    // 默认选中的排序
}

@end

@implementation MyClientVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
                                   andPlaceholder:@"按客户姓名或电话搜索"];
    
    // 默认选中普通客户
    _commonClientBtn.selected = YES;
//    if (IS_iPhone_X)
//    {
//        self.viewBottmConstant.constant = BOTTOM_SAFE_HEIGHT;
//    }
    
    [self setNavTitle:@"客户列表"
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
    
    [filterView createFiterViewWithItemTitleArray:@[@"交易类型",@"客户状态",@"价格",@"资料完整度"] andDataSourceArray:[self getDataArray] andFiterType:FilterClient andBlock:^(NSString *fiterStr) {
        
        NSLog(@"%@",fiterStr);
    }];
    [self.view addSubview:filterView];
}

- (NSArray *)getDataArray
{
    // 模拟数据
    NSArray *arr1 = @[@"不限",@"求租",@"求购",@"租购"];
    NSArray *arr2 = @[@"有效",@"暂缓",@"已租",@"已购",@"老客户",@"预定",@"无效"];
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    
    NSArray *array1 = @[@"不限",@"500以下",@"1000~1500元",@"1500~2000元",@"2000~2500元",@"2500~3000元",@"3000~3500元",@"3500~4000元",@"4000~4500元"];
    NSArray *array2 = @[@"不限",@"100万以下",@"100~150万",@"150~200万",@"200~250万",@"250~300万",@"300~350万",@"350~400万",@"400~450万"];
    [dic setValue:array1 forKey:@"出租价格(元)"];
    [dic setValue:array2 forKey:@"出售价格(万)"];
    
    NSArray *arr3 = @[@"不限",@"极地 30%以下",@"低 30%-50%",@"中 50%-80%",@"高 80%以上"];
    NSArray * dataArray = @[arr1,arr2,dic,arr3];
    
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

/// 点击客户排序
- (IBAction)sortClientClick:(id)sender
{
    APSortView *sortView = [[APSortView alloc] initWithFrame:MainScreenBounds];
    NSArray * sortArray = @[@"默认排序",@"按客户等级从高到低",@"按客户等级从低到高",@"按带看次数从高到底",@"按带看次数从低到高",@"按跟进日期正序",@"按跟进日期倒序",@"按客户姓名排序"];
    [sortView showSortViewWithSortDataArr:sortArray andSelectData:_selectSortStr andCompleteBlock:^(NSString *sortStr) {
        
        _selectSortStr = sortStr;
        NSLog(@"%@",_selectSortStr);
    }];
}

/// 点击普通客户
- (IBAction)commmonClientClick:(id)sender
{
    _commonClientBtn.selected = YES;
    _vipClientBtn.selected = NO;
    [_mainTableView reloadData];
}

/// 点击Vip客户
- (IBAction)vipClientClick:(id)sender
{
    _commonClientBtn.selected = NO;
    _vipClientBtn.selected = YES;
    [_mainTableView reloadData];
}

#pragma mark - <UITableViewDelegate/UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 110;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MyClientCell * myClient = [MyClientCell cellWithTableView:tableView];
    
    // 选中普通客户
    if (_commonClientBtn.selected)
    {
        myClient.clientNameLeft.constant = 10.f;
        myClient.vipClient.hidden = YES;
    }
    else
    {
        myClient.clientNameLeft.constant = 30.f;
        myClient.vipClient.hidden = NO;
    }
    
    [myClient setCellDataWithIndexPath:indexPath];
    return myClient;
}

@end
