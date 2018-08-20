//
//  MineViewController.m
//  APlus
//
//  Created by 李慧娟 on 17/11/3.
//  Copyright (c) 2017年 CentaLine. All rights reserved.
//

#import "MineVC.h"
#import "LoginVC.h"

#define TitleArr @[@[@"修改密码",@"我的收藏",@"消息提醒",@"客服帮助"],@[@"新功能演示",@"版本记录"]]
#define ImgArr   @[@[@"修改密码",@"收藏",@"消息提醒",@"客服"],@[@"演示",@"版本记录"]]

@interface MineVC ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_mainTableView;
    IBOutlet UIView *_headerView;
    __weak IBOutlet UIImageView *_userImgView;
    __weak IBOutlet UILabel *_userName;
    __weak IBOutlet UILabel *_userTitle;
    __weak IBOutlet UILabel *_userGroup;
    
}

@end

@implementation MineVC

- (void)viewDidLoad
{
    [super viewDidLoad];

    // 设置电池条为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];

    [self navBarNeedHidden:YES
              andAnimation:YES];

    [self setNavTitle:@"我的"
       leftButtonItem:nil
      rightButtonItem:nil];

    [self initView];
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    // 设置电池条为白色
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}


- (void)initView
{
    _mainTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT - APP_TAR_HEIGHT)
                                                  style:UITableViewStyleGrouped];

    _mainTableView.delegate = self;
    _mainTableView.dataSource = self;
    [self.view addSubview:_mainTableView];

    _headerView.frame = CGRectMake(0, 0, APP_SCREEN_WIDTH, 145);
    [_userImgView setLayerCornerRadius:35];
    _mainTableView.tableHeaderView = _headerView;


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

/// 设置
- (IBAction)settingClick:(UIButton *)sender {

}

/// 跳转个人信息
- (IBAction)turnMyInfoClick:(UIButton *)sender {
    LoginVC *loginVC = [[LoginVC alloc] init];
    [self.navigationController pushViewController:loginVC animated:YES];
}

#pragma mark - <UITableViewDelegate/UITableViewDataSource>

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 4;
    }
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"MineCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        UIImageView *leftImgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 20, 20)];
        leftImgView.tag = 100;
        [cell.contentView addSubview:leftImgView];

        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 100, 20)];
        textLabel.tag = 200;
        textLabel.textColor = [UIColor blackColor];
        textLabel.font = [UIFont systemFontOfSize:16];
        [cell.contentView addSubview:textLabel];
    }

    UIImageView *leftImgView = [cell.contentView viewWithTag:100];
    UILabel *textLabel = [cell.contentView viewWithTag:200];
    NSArray *subArr1 = TitleArr[indexPath.section];
    NSArray *subArr2 = ImgArr[indexPath.section];
    textLabel.text = subArr1[indexPath.row];
    leftImgView.image = [UIImage imageNamed:subArr2[indexPath.row]];
    return cell;
}



@end
