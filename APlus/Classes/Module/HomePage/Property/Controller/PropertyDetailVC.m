//
//  PropertyDetailVC.m
//  APlus
//
//  Created by 李慧娟 on 2017/11/21.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "PropertyDetailVC.h"
#import "PDHeaderView.h"

#import "PDPropNameCell.h"
#import "PDHeaderCell.h"
#import "PDFooterCell.h"
#import "PDOneCell.h"
#import "PropertyInfoView.h"
#import "PDFourCell.h"
#import "PDTakeSeeCell.h"
#import "PDPropFollowCell.h"
#import "EventView.h"

@interface PropertyDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,EventDelegate>
{
    PDHeaderView *_headerView;
    IBOutlet UIView *_bottomView;
    UITableView *_mainTableView;
    UIView *_shadowView;            // 阴影
    IBOutlet UIView *_shareView;    // 分享
    EventView *_eventView;

    BOOL _isHiddenNav;              // 当前导航栏是否显示
}

@end

@implementation PropertyDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];

    [self navBarNeedHidden:YES
              andAnimation:YES];
    _isHiddenNav = YES;

    [self setNavTitle:@"壹街区静的花园1号楼1门"
       leftButtonItem:[self customBarItemButton:nil
                                backgroundImage:nil
                                     foreground:@"back"
                                            sel:@selector(back)]
      rightButtonItem:[self customBarItemButton:nil
                                backgroundImage:nil
                                     foreground:@"更多_black"
                                            sel:@selector(moreAction:)]];


    [self initView];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    // 设置电池条为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}

- (void)initView
{
    // 头视图
    _headerView = [[PDHeaderView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, 230)];
    [_headerView.backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    [_headerView.moreBtn addTarget:self action:@selector(moreAction:) forControlEvents:UIControlEventTouchUpInside];

    // 表视图
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT - APP_TAR_HEIGHT)
                                                  style:UITableViewStylePlain];
    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    _mainTableView.tableHeaderView = _headerView;
    _mainTableView.showsVerticalScrollIndicator = NO;
    _mainTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _mainTableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_mainTableView];

    // 底部视图
    _bottomView.frame = CGRectMake(0, _mainTableView.bottom, APP_SCREEN_WIDTH, APP_TAR_HEIGHT);
    _bottomView.layer.shadowColor = [UIColor blackColor].CGColor;
    _bottomView.layer.shadowOpacity = 0.2;
    _bottomView.layer.shadowRadius = 2;
    UIButton *collectBtn = [_bottomView viewWithTag:1111];
    [collectBtn setImage:[UIImage imageNamed:@"收藏-ele"] forState:UIControlStateSelected];
    [collectBtn setTitle:@"  取消收藏" forState:UIControlStateSelected];
    collectBtn.selected = NO;
    [self.view addSubview:_bottomView];

    // 阴影视图
    _shadowView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT)];
    _shadowView.backgroundColor = [UIColor blackColor];
    _shadowView.alpha = 0.3;
    _shadowView.hidden = YES;
    UITapGestureRecognizer *shadowViewTap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                    action:@selector(shadowViewTapAction:)];
    [_shadowView addGestureRecognizer:shadowViewTap];
    [self.view addSubview:_shadowView];

    // 添加事件view并默认隐藏
    NSArray *titleArr = @[@"首页",@"消息",@"工作",@"上传实勘",@"新增委托备案",@"录音",@"周边"];
    _eventView = [[EventView alloc] initWithFrame:CGRectMake(APP_SCREEN_WIDTH - RowWidth - 15,
                                                             APP_TAR_HEIGHT,RowWidth,
                                                             RowHeight * titleArr.count + ArrowHeight)
                                   andIsHaveImage:YES];
    _eventView.titleArr = titleArr;
    _eventView.hidden = YES;
    _eventView.eventDelegate = self;
    [self.view addSubview:_eventView];

    // 分享视图默认隐藏
    _shareView.frame = CGRectMake(0,APP_SCREEN_HEIGHT - 190 , APP_SCREEN_WIDTH, 190);
    [self.view addSubview:_shareView];
    _shareView.hidden = YES;

    if (@available(iOS 11.0, *))
    {
        _mainTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else
    {
        [self setAutomaticallyAdjustsScrollViewInsets:NO];
    }

}

#pragma mark - BtnClick

/// 更多
- (void)moreAction:(UIButton *)btn
{
    if (_isHiddenNav == YES)
    {
        _eventView.top = STATUS_BAR_HEIGHT + 45;
    }
    else
    {
        _eventView.top = 0;
    }
    _shadowView.hidden = NO;
    _eventView.hidden = NO;
}

/// 查看房号
- (void)checkHouseNumAction:(UIButton *)btn
{

}

/// 实勘、钥匙、委托
- (void)operaAction:(UIButton *)btn
{
    if (btn.tag == 100)
    {
        // 实勘
    }
    else if (btn.tag == 101)
    {
        // 钥匙
    }
    else if (btn.tag == 102)
    {
        // 委托
    }
}

/// 分享
- (IBAction)shareClick:(UIButton *)sender
{
    [UIView animateWithDuration:0.2 animations:^{
        _shadowView.hidden = NO;
        _shareView.hidden = NO;
    }];
}


/// 收藏／取消收藏
- (IBAction)collectClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
}

/// 取消分享
- (IBAction)cancelShareAction:(UIButton *)sender
{
    _shadowView.hidden = YES;
    _shareView.hidden = YES;
}

/// 添加跟进
- (IBAction)addFollowClick:(UIButton *)sender
{

}

/// 打电话
- (IBAction)callClick:(UIButton *)sender
{

}

- (void)shadowViewTapAction:(UITapGestureRecognizer *)tapAction
{
    _shadowView.hidden = YES;
    if (_eventView.hidden == NO)
    {
        _eventView.hidden = YES;
    }
    else
    {
        _shareView.hidden = YES;
    }
}

#pragma mark - <EventDelegate>

- (void)eventClickWithBtnTitle:(NSString *)title
{
    _eventView.hidden = YES;
    _shadowView.hidden = YES;

    if ([title isEqualToString:@"首页"])
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else if ([title isEqualToString:@"消息"])
    {
    }
    else if ([title isEqualToString:@"工作"])
    {
    }
    else if ([title isEqualToString:@"上传实勘"])
    {
    }
    else if ([title isEqualToString:@"新增委托备案"])
    {
    }
    else if ([title isEqualToString:@"编辑委托备案"])
    {
    }
    else if ([title isEqualToString:@"录音"])
    {
    }
    else if ([title isEqualToString:@"周边"])
    {
    }
}

#pragma mark - <UITableViewDelegate/UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0 || section == 3)
    {
        return 1;
    }
    else if (section == 2 || section == 4)
    {
        // 房源跟进、房源带看量
        return 3;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        // 租价、售价、户型
        return 60;
    }
    else if (indexPath.section == 1 && indexPath.row == 0)
    {
        // 房源详细信息
       NSArray *titleArr = @[@"户型:",@"单价:",@"朝向",@"建筑面积:",@"房屋现状:",@"楼层:",@"产权:"];
       NSInteger rowCount = [self getRowNumWithSunCount:titleArr.count
                                          andEachRowNum:2];
        return 30 * rowCount + 5;;
    }
    else if (indexPath.section == 2 && indexPath.row == 1)
    {
        // 房源跟进->动态获取
        NSString *testStr = @"三大地方撒佛教萨发刷卡机开发是大家繁花似锦看见方式数据库的分红";
        CGFloat height = [testStr heightWithLabelFont:[UIFont systemFontOfSize:15.0]
                                       withLabelWidth:APP_SCREEN_WIDTH - 30];
        return 50 + height;
    }
    else if (indexPath.section == 4 && indexPath.row == 1)
    {
        // 房源带看量
        return 100;
    }
    else if (indexPath.section == 3)
    {
        // 实勘、钥匙、委托
        return 80;
    }

    return 50;
}

//section头部间距
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;//section头部高度
}
//section头部视图
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}
////section底部间距
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 4)
    {
        return 0;
    }
    return 10;
}
//section底部视图
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    view.backgroundColor = [UIColor clearColor];
    return view;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *commonCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                         reuseIdentifier:nil];

    PDHeaderCell *headerCell = (PDHeaderCell *)[tableView cellFromXib:@"PDHeaderCell"];
    PDFooterCell *footerCell = (PDFooterCell *)[tableView cellFromXib:@"PDFooterCell"];

    if (indexPath.section == 0)
    {
        /*****租售价、户型*****/
        NSString *identifier = @"PDFitstCell";
        PDOneCell *oneCell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (oneCell == nil)
        {
            oneCell = [[PDOneCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:identifier];
            oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        oneCell.trustType = BOTH;

        return oneCell;
    }
    else if (indexPath.section == 1)
    {
        /*****房源名称*****/
        if (indexPath.row == 0)
        {
            PropertyInfoView *propertyInfoView = [commonCell.contentView viewWithTag:1993];
            if (propertyInfoView == nil)
            {
                propertyInfoView = [[PropertyInfoView alloc] initWithFrame:CGRectMake(10, 1, APP_SCREEN_HEIGHT - 20, 130)];
                propertyInfoView.tag = 1993;
                [commonCell.contentView addSubview:propertyInfoView];
            }

            NSArray *titleArr = @[@"户型:",@"单价:",@"朝向",@"建筑面积:",@"房屋现状:",@"楼层:",@"产权:"];

            NSInteger rowCount = [self getRowNumWithSunCount:titleArr.count
                                               andEachRowNum:2];

            propertyInfoView.height = 30 * rowCount + 3;
            propertyInfoView.titleArr = titleArr;

            return commonCell;
        }

        PDPropNameCell *propNameCell = (PDPropNameCell *)[tableView cellFromXib:@"PDPropNameCell"];
        [propNameCell.checkHouseNum addTarget:self
                                       action:@selector(checkHouseNumAction:)
                             forControlEvents:UIControlEventTouchUpInside];
        return propNameCell;
    }
    else if (indexPath.section == 2)
    {
        /*****房源跟进*****/
        if (indexPath.row == 0)
        {
            headerCell.titleStr = @"房源跟进";
            headerCell.lastState.hidden = YES;
            return headerCell;
        }
        else if (indexPath.row == 1)
        {
            NSString *testStr = @"三大地方撒佛教萨发刷卡机开发是大家繁花似锦看见方式数据库的分红";
            PDPropFollowCell *propFollowCell = (PDPropFollowCell *)[tableView cellFromXib:@"PDPropFollowCell"];
            propFollowCell.followContent = testStr;
            return propFollowCell;
        }

        footerCell.content = @"查看更多跟进";
        return footerCell;

    }
    else if (indexPath.section == 3)
    {
        /*****实勘、钥匙、委托*****/
        PDFourCell *fourCell = (PDFourCell *)[tableView cellFromXib:@"PDFourCell"];

        for (int i = 0; i < 3; i++)
        {
            UIButton *btn = [fourCell.contentView viewWithTag:100 + i];
            [btn addTarget:self action:@selector(operaAction:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        return fourCell;
    }
    else if (indexPath.section == 4)
    {
        /*****房源带看量*****/
        if (indexPath.row == 0)
        {
            headerCell.titleStr = @"房源带看量";
            headerCell.lastState.hidden = NO;
            return headerCell;
        }
        else if (indexPath.row == 1)
        {
            PDTakeSeeCell *takeSeeCell = (PDTakeSeeCell *)[tableView cellFromXib:@"PDTakeSeeCell"];
            return takeSeeCell;
        }

        footerCell.content = @"查看更多历史";
        return footerCell;
    }

    return commonCell;

}

#pragma mark - <UIScrollViewDelegate>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UITableView class]])
    {
        CGFloat yOffSet = scrollView.contentOffset.y;
        if (yOffSet >= 200)
        {
            // 显示导航栏
            _isHiddenNav = NO;
        }
        else
        {
            // 隐藏导航栏
            _isHiddenNav = YES;

        }
        [self setSubViewsWithHiddenNav:_isHiddenNav];
    }
}

- (void)setSubViewsWithHiddenNav:(BOOL)isHiddenNav
{
    [self setNeedHiddenNavBar:isHiddenNav
                 andAnimation:NO];

    // 表视图高度
    CGFloat tableViewHeight;

    // 电池条颜色
    NSInteger statusBarStyle;

    // 分享视图top
    CGFloat shareViewBottom;

    if (isHiddenNav == YES)
    {
        // 隐藏导航栏

        tableViewHeight = APP_SCREEN_HEIGHT - APP_TAR_HEIGHT;

        statusBarStyle = UIStatusBarStyleLightContent;

        shareViewBottom = APP_SCREEN_HEIGHT;
    }
    else
    {
        // 显示导航栏

        tableViewHeight = APP_SCREEN_HEIGHT - APP_NAV_HEIGHT - APP_TAR_HEIGHT;

        statusBarStyle = UIStatusBarStyleDefault;

        shareViewBottom = APP_SCREEN_HEIGHT - APP_NAV_HEIGHT;
    }

    _mainTableView.height = tableViewHeight;
    _bottomView.top = _mainTableView.bottom;
    [[UIApplication sharedApplication] setStatusBarStyle:statusBarStyle animated:NO];
    _shareView.bottom = shareViewBottom;
}

- (NSInteger)getRowNumWithSunCount:(NSInteger)sumCount
                     andEachRowNum:(NSInteger)eachRowNum
{
    NSInteger result1 = sumCount % eachRowNum;
    NSInteger result2 = sumCount / eachRowNum;
    NSInteger rowCount = (result1 == 0 ) ? result2 : result2 + 1;

    return rowCount;
}

@end
