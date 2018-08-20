//
//  APFilterView.m
//  APlusFilterView
//
//  Created by 张旺 on 2017/10/23.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "APFilterView.h"
#import "ItemView.h"
#import "APFilterEntity.h"
#import "FilterEstateDetailView.h"
#import "FilterMoreDetailView.h"

@interface APFilterView()
{
    ItemView *_itemView;
    FilterEstateDetailView *_filterEstateDetailView;        // 筛选房源类型View
    FilterMoreDetailView *_filterMoreDetailView;            // 筛选更多View
    UIView *_shadowBackView;                                // 半透明阴影view
    
    FilterCompleteBlock _filterCompleteBlock;               // 选择筛选项后回调的block
    
    FilterType _filterType;                                 // 筛选类型
    APFilterEntity * _filterEntity;                         // 筛选实体
    NSMutableArray *_itemTitleArray;                        // 标题数组
    NSMutableArray *_dataSourceArray;                       // 数据源
    CGRect _tempFilterViewRect;                             // 记录FilterView位置
    NSInteger _lastSelectIndex;                             // 上次选择的筛选项index
    BOOL _isShowFilterView;                                 // 当前是否显示筛选列表
}

@end

@implementation APFilterView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        _isShowFilterView = NO;
        _tempFilterViewRect = self.frame;
        [self setBackgroundColor:[UIColor clearColor]];
    }
    
    return self;
}

/// 创建筛选view
- (UIView *)createFiterViewWithItemTitleArray:(NSArray *)itemTitleArray
                           andDataSourceArray:(NSArray *)dataSourceArray
                                 andFiterType:(FilterType)filterType
                                     andBlock:(FilterCompleteBlock)block
{
    _filterType = filterType;
    _itemTitleArray = [itemTitleArray mutableCopy];
    _filterEntity = [[APFilterEntity alloc] init];
    _dataSourceArray = [dataSourceArray mutableCopy];
    _filterCompleteBlock = block;
    
    // 创建筛选itemView
    _itemView = [[ItemView alloc] initWithFrame:CGRectMake(0, 0, APP_SCREEN_WIDTH, FilterViewHeight)];
    [_itemView setItemTitleArray:itemTitleArray];
    
    WS(weakSelf);
    // 点击item按钮回调
    _itemView.btnClickBlock = ^(UIButton *button)
    {
        [weakSelf itemBtnClickWithBtn:button];
    };

    // 阴影View
    _shadowBackView = [[UIView alloc]initWithFrame:CGRectMake(0,
                                                              0,
                                                              APP_SCREEN_WIDTH,
                                                              0)];
    [_shadowBackView setBackgroundColor:UIColorFromHex(0x000000,0.4)];
    
    UITapGestureRecognizer *tapHideGesture = [[UITapGestureRecognizer alloc]initWithTarget:self
                                                                                    action:@selector(removeShadowAndListView)];
    tapHideGesture.numberOfTapsRequired = 1;
    tapHideGesture.numberOfTouchesRequired = 1;
    [_shadowBackView addGestureRecognizer:tapHideGesture];
    
    [self addSubview:_itemView];
    [self addSubview:_shadowBackView];
    
    return self;
}

#pragma mark Item Button Click

/// item按钮点击事件
- (void)itemBtnClickWithBtn:(UIButton *)clickBtn
{
    // 当前选择筛选项的箭头图标
    NSInteger selectArrowImgTag = ArrowImageBaseTag + clickBtn.tag - ItemButtonBaseTag;
    UIImageView *selectArrowImg = (UIImageView *)[self viewWithTag:selectArrowImgTag];
    
    if (_isShowFilterView)
    {
        // 当前有显示筛选列表
        if (clickBtn.tag == _lastSelectIndex)
        {
            // 两次点击Item上的按钮一样  移除筛选列表跟阴影
            [self removeShadowAndListView];
        }
        else
        {
            // 点击的是其它筛选列表    先移除之前的视图，再显示或创建
            [self removeLastLastTableView];
            [self createTableViewWithButton:clickBtn];
            
            // 设置本次点击的箭头颜色
            [selectArrowImg setImage:[UIImage imageNamed:ArrowDownRedImgName]];
            
            // 设置上次点击的箭头颜色
            [self setLastArrowColor];
        }
    }
    else
    {
        // 当前没显示筛选列表则创建
        [self showShadowView];
        [self createTableViewWithButton:clickBtn];
        
        _isShowFilterView = YES;
        [selectArrowImg setImage:[UIImage imageNamed:ArrowDownRedImgName]];
    }
    
    _lastSelectIndex = clickBtn.tag;
}

/// TableView点击cell回调
- (void)selectCellBlockWithCellTextStr:(NSString *)cellTextStr
{
    // 移除阴影View跟列表
    [self removeShadowAndListView];
    
    // 传值给控制器
    _filterCompleteBlock(cellTextStr);
}

#pragma mark createClickView

/// 创建列表
- (void)createTableViewWithButton:(UIButton *)button
{
    [self endEditing:YES];
    
    NSInteger selectIndex = button.tag - ItemButtonBaseTag;
    
    // createTableView
    if (selectIndex == 3 && _filterType != FilterClient)
    {
        // 更多View
        if (!_filterMoreDetailView)
        {
            _filterMoreDetailView = [[FilterMoreDetailView alloc] initWithFrame:CGRectMake(0, FilterViewHeight, APP_SCREEN_WIDTH, APP_SCREEN_HEIGHT  - FilterViewHeight - APP_NAV_HEIGHT)];
            
            // 数据模拟
            NSArray *roomArray = @[@"一居",@"两居一居一居",@"三居",@"四居",@"五居",@"五居以上"];
            NSDictionary *roomDic = [NSDictionary dictionaryWithObject:roomArray forKey:@"房型"];
            NSDictionary *areaDic = [NSDictionary dictionaryWithObject:@[] forKey:@"建筑面积（平米)"];
            NSArray *estateStateArray = @[@"有效",@"暂缓",@"已售",@"已租",@"无效",@"空置",@"预定"];
            NSDictionary *estateStateDic = [NSDictionary dictionaryWithObject:estateStateArray forKey:@"房源状态"];
            NSArray *estateStateQuoArray = @[@"空房",@"业主住",@"租客住",@"朋友住",@"中介已收购"];
            NSDictionary *estateStateQuoDic = [NSDictionary dictionaryWithObject:estateStateQuoArray forKey:@"房源现状"];
            NSArray *estateFaceArray = @[@"东",@"南",@"西",@"北",@"东南",@"西南",@"东北",@"西北",@"南北",@"东西",@"东南",@"西南",@"金角",@"银角",@"铜角",@"铁角",@"阴面",@"阳面"];
            NSDictionary *estateFaceDic = [NSDictionary dictionaryWithObject:estateFaceArray forKey:@"朝向"];
            NSArray *estateLabelArray = @[@"独家",@"有抵押",@"无抵押",@"电梯",@"置换",@"行家独家",@"有二套",@"货代已清",@"家具",@"家电",@"空房",@"满二年",@"唯一",@"委托房源",@"未满二年",@"满五年",@"货代未清",@"急售房",@"验证",@"签约",@"委托已审",@"底墒"];
            NSDictionary *estateLabelDic = [NSDictionary dictionaryWithObject:estateLabelArray forKey:@"房源标签"];
            NSArray *buildingTypeArray = @[@"双拼别墅",@"平层",@"错层",@"Loft",@"跃复一层",@"联排别墅",@"独家别墅",@"叠层别墅",@"高层",@"多层复式",@"高层复式",@"多层跃式",@"高层跃式",@"小高层",@"多层"];
            NSDictionary *buildingTypeDic = [NSDictionary dictionaryWithObject:buildingTypeArray forKey:@"建筑类型"];
            NSMutableArray * dataArray = [NSMutableArray arrayWithObjects:roomDic,areaDic,estateStateDic,estateStateQuoDic,estateFaceDic,estateLabelDic,buildingTypeDic, nil];
            [_filterMoreDetailView setDataSourceArray:dataArray estateFilterListType:1];
            [self addSubview:_filterMoreDetailView];
        }
        _filterMoreDetailView.hidden = NO;
    }
    else
    {
        // 房源筛选详情VIew
        _filterEstateDetailView = [[FilterEstateDetailView alloc] initWithFrame:CGRectMake(0, FilterViewHeight, APP_SCREEN_WIDTH, TableViewCellHeight)];
        [self addSubview:_filterEstateDetailView];
        
        [_filterEstateDetailView setDataSourceWithDataArray:_dataSourceArray
                                          andItemTitleArray:_itemTitleArray
                                             andSelectIndex:selectIndex
                                            andFilterEntity:_filterEntity];
        // tableView数量
        NSInteger tableViewNumber = 1;      // 默认1个, 价格有2个tableView
        
        if ([_itemTitleArray[selectIndex] isEqualToString:@"价格"])
        {
            tableViewNumber = 2;
            _filterEstateDetailView.height = 9 * TableViewCellHeight;
        }
        _filterEstateDetailView.tableViewNumber = tableViewNumber;
        _filterEstateDetailView.height = [_dataSourceArray[selectIndex] count] * TableViewCellHeight;
        
        __weak __typeof(&*self)weakSelf = self;
        // 点击cell回调
        _filterEstateDetailView.block = ^(NSString *cellTextStr)
        {
            [weakSelf selectCellBlockWithCellTextStr:cellTextStr];
        };
    }
}

#pragma mark ShadowView State

/// 显示阴影
- (void)showShadowView
{
    [self setFrame:CGRectMake(0,
                              _tempFilterViewRect.origin.y,
                              APP_SCREEN_WIDTH,
                              APP_SCREEN_HEIGHT - APP_NAV_HEIGHT)];
    
    [_shadowBackView setFrame:CGRectMake(0,
                                         FilterViewHeight,
                                         APP_SCREEN_WIDTH,
                                         APP_SCREEN_HEIGHT - FilterViewHeight - APP_NAV_HEIGHT)];
    
    [UIView animateWithDuration:0.1 animations:^{
        
        _shadowBackView.alpha = 1.0;
    }];
}


/// 移除筛选列表和阴影
- (void)removeShadowAndListView
{
    [_filterMoreDetailView removeFromSuperview];
    [_filterEstateDetailView removeFromSuperview];
    _filterMoreDetailView = nil;
    _filterEstateDetailView = nil;
    
    _isShowFilterView = NO;
    
    // 上一次选择箭头的置为未选择
    if (_lastSelectIndex != 0)
    {
        [self setLastArrowColor];
    }
    
    _shadowBackView.alpha = 0;
    
    [self setFrame:CGRectMake(0,
                              _tempFilterViewRect.origin.y,
                              APP_SCREEN_WIDTH,
                              FilterViewHeight)];
    
    [_shadowBackView setFrame:CGRectMake(0,
                                         FilterViewHeight,
                                         APP_SCREEN_WIDTH,
                                         0)];
}

/// 移除上次点击的的视图
- (void)removeLastLastTableView
{
    [_filterEstateDetailView removeFromSuperview];
    _filterMoreDetailView.hidden = YES;
}

/// 设置上次选中的颜色
- (void)setLastArrowColor
{
    NSInteger lastSelectArrowImgTag = ArrowImageBaseTag + (_lastSelectIndex - ItemButtonBaseTag);
    NSInteger lastSelectLabelTag = ItemTitleBaseTag + (_lastSelectIndex - ItemButtonBaseTag);
    
    UIImageView *lastSelectArrowImg = (UIImageView *)[self viewWithTag:lastSelectArrowImgTag];
    UILabel *lastSelectLabel = (UILabel *)[self viewWithTag:lastSelectLabelTag];
    
    if (CGColorEqualToColor(lastSelectLabel.textColor.CGColor, UIColorFromHex(0xff3333,1.0).CGColor))
    {
        [lastSelectArrowImg setImage:[UIImage imageNamed:ArrowDownRedImgName]];
    }
    else
    {
        [lastSelectArrowImg setImage:[UIImage imageNamed:ArrowDownGrayImgName]];
    }
}

@end
