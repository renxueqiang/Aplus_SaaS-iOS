//
//  APMenuListView.m
//  APlus
//
//  Created by 张旺 on 2017/11/7.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "APMenuListView.h"
#import "APMenuListCell.h"
#import "HomePageVC.h"
#import "NewsVC.h"
#import "WorkVC.h"

#define MENU_CELL_HEIGHT 38.f

#define MENU_VIEW_WIDTH 140.f

#define MENU_ARROW_HEIGHT 5.f

#define MENU_ARROW_rightEdge 18.f

#define MENU_ARROW_WIDTH 8.f

#define K_Main_Window [UIApplication sharedApplication].keyWindow

@interface APMenuListView()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView     *_menuTabelView;
    UIView          *_mainView;             // 主视图
    UIView          *_bgView;               // 背景视图
    UIView          *_relayView;            // 依赖视图
    UIImageView     *_arrowImageView;       // Arrow
    
    NSArray         *_titlesArray;          // 标题
    NSArray         *_iconsArray;           // 图标
    
    CGFloat         _cornerRadius;          // 圆角
    CGFloat         _arrowCenterLeft;       // 三角中心左边距
}

/// 依赖的ViewController
@property (strong, nonatomic) UIViewController *ralyonViewController;

@end

@implementation APMenuListView

#pragma mark ----------------------- Init -------------------------

- (instancetype)initWithRalyonView:(UIView *)view titles:(NSArray<NSString *> *)titles iconNames:(NSArray<NSString *> *)iconNames
{
    self = [super init];
    if (self)
    {
        CGRect ralyonViewRect = [view convertRect:view.bounds toView:K_Main_Window];
        _titlesArray = titles;
        _iconsArray  = iconNames;
        self.top = CGRectGetMaxY(ralyonViewRect);
        self.left = APP_SCREEN_WIDTH - MENU_VIEW_WIDTH - 6.f;
        self.width = MENU_VIEW_WIDTH;
        self.height = MENU_CELL_HEIGHT * titles.count + MENU_ARROW_HEIGHT;
        _cornerRadius = 3.f;
        _arrowCenterLeft = self.width - MENU_ARROW_rightEdge;
        _relayView = view;
        
        if ([view.curViewController isKindOfClass:[CustomPanNavigationController class]])
        {
            self.ralyonViewController = [(CustomPanNavigationController*)view.curViewController currentShowVC];
        }
        else
        {
            self.ralyonViewController = view.curViewController;
        }
        
        self.alpha = 0;
        self.layer.shadowOpacity = 0.3;
        self.layer.shadowOffset = CGSizeMake(0, 0);
        self.layer.shadowRadius = 0.5;
        
        _mainView = [[UIView alloc] initWithFrame: self.bounds];
        _mainView.backgroundColor = [UIColor whiteColor];
        ViewRadius(_mainView, 2.f);
        
        _menuTabelView = [[UITableView alloc] initWithFrame:self.bounds style:UITableViewStylePlain];
        _menuTabelView.backgroundColor = [UIColor clearColor];
        _menuTabelView.delegate = self;
        _menuTabelView.dataSource= self;
        _menuTabelView.bounces = titles.count > 5 ? YES : NO;
        _menuTabelView.tableFooterView = [UIView new];
        _menuTabelView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _menuTabelView.centerY = _mainView.centerY + MENU_ARROW_HEIGHT;
        [_mainView addSubview: _menuTabelView];
        [self addSubview: _mainView];
        
        _bgView = [[UIView alloc] initWithFrame: [UIScreen mainScreen].bounds];
        _bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
        _bgView.alpha = 0;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget: self action: @selector(dismiss)];
        [_bgView addGestureRecognizer: tap];
    }
    
    return self;
}

#pragma mark ----------------------- Table DataSource -------------------------

/// Section Count
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

/// Cell Count
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _titlesArray.count;
}

/// Cell Height
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return MENU_CELL_HEIGHT;
}

/// Cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *const CELLID = @"APMenuListCell";
    APMenuListCell *menuCell = [tableView dequeueReusableCellWithIdentifier:CELLID];
    
    if (!menuCell)
    {
        menuCell = (APMenuListCell *)[[[NSBundle mainBundle] loadNibNamed:@"APMenuListCell" owner:self options:nil] firstObject];
        [menuCell setMenuContentWithTitle:[_titlesArray objectAtIndex:indexPath.row]
                            iconImageName:[_iconsArray objectAtIndex:indexPath.row]];
        if (indexPath.row == _titlesArray.count - 1)
        {
            [menuCell setSeperateLineShow:NO];
        }
    }
    
    return menuCell;
}

#pragma mark ----------------------- Tabel Delegate -------------------------

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        if (_newsMenuItemDidSelected) {
            _newsMenuItemDidSelected(self);
        }
        else{
            [self popToRootChageTabBarIndexWithIndexRow:indexPath.row];
        }
    }
    else if (indexPath.row == 1){
        if (_homeMenuItemDidSelected) {
            _homeMenuItemDidSelected(self);
        }
        else{
            [self popToRootChageTabBarIndexWithIndexRow:indexPath.row];
        }
    }
    else if (indexPath.row == 2){
        if (_workMenuItemDidSelected) {
            _workMenuItemDidSelected(self);
        }
        else{
            [self popToRootChageTabBarIndexWithIndexRow:indexPath.row];
        }
    }
    
    [self dismiss];
}

/// 跳转动态、首页、我的
- (void)popToRootChageTabBarIndexWithIndexRow:(NSInteger)indexRow
{
    BaseTabBarController *baseTabBar = [BaseTabBarController shareTabBarController];
    
    if (indexRow == 0) {
        if ([self isRootViewControllerOnCurrentTabBarIndex:[NewsVC class]]) {
            [self.ralyonViewController.navigationController popToRootViewControllerAnimated:YES];
        }
        else{
            [self.ralyonViewController.navigationController popToRootViewControllerAnimated:NO];
            [baseTabBar setCurrentSelectIndex:1];
        }
    }
    else if (indexRow == 1){
        if ([self isRootViewControllerOnCurrentTabBarIndex:[HomePageVC class]]) {
            [self.ralyonViewController.navigationController popToRootViewControllerAnimated:YES];
        }
        else {
            [self.ralyonViewController.navigationController popToRootViewControllerAnimated:NO];
            [baseTabBar setCurrentSelectIndex:0];
        }
    }
    else if (indexRow == 2){
        if ([self isRootViewControllerOnCurrentTabBarIndex:[WorkVC class]]) {
            [self.ralyonViewController.navigationController popToRootViewControllerAnimated:YES];
        }
        else {
            [self.ralyonViewController.navigationController popToRootViewControllerAnimated:NO];
            [baseTabBar setCurrentSelectIndex:3];
        }
    }
}

- (BOOL)isRootViewControllerOnCurrentTabBarIndex:(Class)rootClass{
    BOOL isRootClass = NO;
    
    for (UIViewController *temp in self.ralyonViewController.navigationController.viewControllers) {
        if ([temp isKindOfClass:rootClass]) {
            isRootClass = YES;
            break;
        }
    }
    
    return isRootClass;
}

#pragma mark ----------------------- Get Last Cell -------------------------

- (APMenuListCell *)getLastCell
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:(_titlesArray.count - 1) inSection:0];
    return [_menuTabelView cellForRowAtIndexPath:indexPath];
}

#pragma mark ----------------------- Show Dismiss -------------------------

- (instancetype)showMenuWithRalyonView:(UIView *)view menuItemType:(MenuItemType)menuItemType{
    NSMutableArray *titleArray = [NSMutableArray arrayWithObjects:@"消息",@"首页",@"工作",nil];
    NSMutableArray *iconNameArary = [NSMutableArray arrayWithObjects:@"estate_news",@"estate_homePage",@"estate_work", nil];

    
    APMenuListView *menuView = [self initWithRalyonView:view titles:titleArray iconNames:iconNameArary];
    [menuView show];
    return menuView;
}

- (void)show
{
    _mainView.layer.mask = [self resetMainViewShape];
    
    CGPoint selfPoint = self.layer.position;
    
    [K_Main_Window addSubview:_bgView];
    [K_Main_Window addSubview:self];
    APMenuListCell *cell = [self getLastCell];
    [cell setSeperateLineShow:NO];
    self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
    self.layer.position = CGPointMake(APP_SCREEN_WIDTH - 22.f, 64.f);
    [UIView animateWithDuration: 0.25 animations:^{
        self.layer.affineTransform = CGAffineTransformMakeScale(1.0, 1.0);
        self.alpha = 1;
        self.layer.position = selfPoint;
        _bgView.alpha = 0.1;
    }];
}

- (void)dismiss{
    [UIView animateWithDuration: 0.25 animations:^{
        self.layer.affineTransform = CGAffineTransformMakeScale(0.1, 0.1);
        self.layer.position = CGPointMake(APP_SCREEN_WIDTH - 22.f, 64.f);
        self.alpha = 0;
        _bgView.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [_bgView removeFromSuperview];
    }];
}

#pragma mark ----------------------- Triangle -------------------------

- (CAShapeLayer *)resetMainViewShape{
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = _mainView.bounds;
    
    /// 左上角圆心
    CGPoint topLeftCornerCenter = CGPointMake(_cornerRadius, _cornerRadius + MENU_ARROW_HEIGHT);
    /// 右上角圆心
    CGPoint topRightCornerCenter = CGPointMake(self.width - _cornerRadius, _cornerRadius + MENU_ARROW_HEIGHT);
    /// 左下角圆心
    CGPoint bottomLeftCornerCenter = CGPointMake(_cornerRadius, self.height - _cornerRadius);
    /// 右下角圆心
    CGPoint bottomRightCornerCenter = CGPointMake(self.width - _cornerRadius, self.height-_cornerRadius);
    
    /// 从左上角 圆角下方开始
    UIBezierPath *layerPath = [UIBezierPath bezierPath];
    [layerPath moveToPoint:CGPointMake(0.f, MENU_ARROW_HEIGHT + _cornerRadius)];
    
    /// 划线到左下角 画圆角
    [layerPath addLineToPoint:CGPointMake(0.f, self.height - _cornerRadius)];
    [layerPath addArcWithCenter:bottomLeftCornerCenter radius:_cornerRadius startAngle:-M_PI endAngle:(-M_PI-M_PI_2) clockwise:NO];
    
    /// 划线到右下角 画圆角
    [layerPath addLineToPoint:CGPointMake(bottomRightCornerCenter.x, self.height)];
    [layerPath addArcWithCenter:bottomRightCornerCenter radius:_cornerRadius startAngle:-(3/2)*(M_PI) endAngle:-2*(M_PI) clockwise:NO];
    
    /// 划线到右上角 画圆角
    [layerPath addLineToPoint:CGPointMake(self.width, topRightCornerCenter.y)];
    [layerPath addArcWithCenter:topRightCornerCenter radius:_cornerRadius startAngle:0 endAngle:-M_PI_2 clockwise:NO];
    
    /// 画三角形
    [layerPath addLineToPoint:CGPointMake(_arrowCenterLeft + MENU_ARROW_WIDTH/2, MENU_ARROW_HEIGHT)];
    [layerPath addLineToPoint:CGPointMake(_arrowCenterLeft, 0.f)];
    [layerPath addLineToPoint:CGPointMake(_arrowCenterLeft - MENU_ARROW_WIDTH/2, MENU_ARROW_HEIGHT)];
    
    /// 划线到左上角 画圆角 合并
    [layerPath addLineToPoint:CGPointMake(topLeftCornerCenter.x, MENU_ARROW_HEIGHT)];
    [layerPath addArcWithCenter:topLeftCornerCenter radius:_cornerRadius startAngle:-M_PI_2 endAngle:-M_PI clockwise:NO];
    [layerPath closePath];
    
    maskLayer.path = layerPath.CGPath;
    
    return maskLayer;
}

@end
