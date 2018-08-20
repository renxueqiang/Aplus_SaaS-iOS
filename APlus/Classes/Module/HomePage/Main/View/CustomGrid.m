//
//  CustomGrid.m
//  MoveGrid
//
//  Created by fuzheng on 16-5-26.
//  Copyright © 2016年 付正. All rights reserved.
//

#import "CustomGrid.h"

@implementation CustomGrid
{
    BOOL _isEmpty;  // 是否为最后一个占位格子
}
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
    }
    return self;
}

//创建格子
- (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
        normalImage:(UIImage *)normalImage
   highlightedImage:(UIImage *)highlightedImage
             gridId:(NSInteger)gridId
            atIndex:(NSInteger)index
        isAddDelete:(BOOL)isAddDelete
         deleteIcon:(UIImage *)deleteIcon
      withIconImage:(NSString *)imageString
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _isEmpty = !isAddDelete;
        // 计算每个格子的X坐标
        CGFloat pointX = (index % PerRowGridCount) * (GridWidth + PaddingX) + PaddingX;
        // 计算每个格子的Y坐标
        CGFloat pointY = (index / PerRowGridCount) * (GridHeight + PaddingY) + PaddingY;
        
        [self setFrame:CGRectMake(pointX, pointY, GridWidth+1, GridHeight+1)];
        self.backgroundColor = AppBackgroundColor;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        [self addTarget:self action:@selector(gridClick:) forControlEvents:UIControlEventTouchUpInside];
        
        // 图片icon
        UIImageView *imageIcon = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-18, self.frame.size.height / 2 - 18 - 10, 40, 40)];
        imageIcon.image = [UIImage imageNamed:imageString];
        imageIcon.tag = self.gridId;
        [self addSubview:imageIcon];
        
        // 标题
        UILabel * title_label = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2-42, imageIcon.bottom + 5, 84, 20)];
        title_label.text = title;
        title_label.textAlignment = NSTextAlignmentCenter;
        title_label.font = [UIFont systemFontOfSize:14];
        title_label.backgroundColor = [UIColor clearColor];
        title_label.textColor = MainGrayFontColor;
        [self addSubview:title_label];
        
        // 设置属性
        [self setGridId:gridId];
        [self setGridImageString:imageString];
        [self setGridTitle:title];
        [self setGridIndex:index];
        [self setGridCenterPoint:self.center];
        
        // 判断是否要添加删除图标
        if (isAddDelete)
        {
            // 当长按时添加删除按钮图标
            UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [deleteBtn setFrame:CGRectMake(imageIcon.right, 10, 20, 20)];
            [deleteBtn setBackgroundColor:[UIColor clearColor]];
            [deleteBtn setBackgroundImage:deleteIcon forState:UIControlStateNormal];
            [deleteBtn addTarget:self action:@selector(deleteGrid:) forControlEvents:UIControlEventTouchUpInside];
            [deleteBtn setHidden:NO];
            
            /////////////
            [deleteBtn setTag:gridId];
            [self addSubview:deleteBtn];
            
            // 添加长按手势
            UILongPressGestureRecognizer *longPressGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(gridLongPress:)];
            [self addGestureRecognizer:longPressGesture];
             longPressGesture = nil;
        }
        else
        {
            //最后一个占位格子
            self.backgroundColor = [UIColor whiteColor];
            CAShapeLayer *borderLayer = [CAShapeLayer layer];
            borderLayer.bounds = CGRectMake(0, 0, GridWidth, GridHeight);
            borderLayer.position = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));

            borderLayer.path = [UIBezierPath bezierPathWithRect:borderLayer.bounds].CGPath;
            borderLayer.lineWidth = 1.5;
            // 虚线边框
            borderLayer.lineDashPattern = @[@7, @7];
            borderLayer.fillColor = [UIColor clearColor].CGColor;
            borderLayer.strokeColor = RGBColor(230, 230, 230).CGColor;
            [self.layer addSublayer:borderLayer];

            for (UIView *subView in self.subviews)
            {
                [subView removeFromSuperview];
            }
        }
    }
    return self;
}


// 响应格子点击事件
- (void)gridClick:(CustomGrid *)clickItem
{
    [self.delegate gridItemDidClicked:clickItem];
}

// 响应格子删除事件
- (void)deleteGrid:(UIButton *)deleteButton
{
    [self.delegate gridItemDidDeleteClicked:deleteButton];
}

// 响应格子的长安手势事件
- (void)gridLongPress:(UILongPressGestureRecognizer *)longPressGesture
{
    switch (longPressGesture.state)
    {
        case UIGestureRecognizerStateBegan:
        {
            [self.delegate pressGestureStateBegan:longPressGesture withGridItem:self];
            break;
        }
        case UIGestureRecognizerStateChanged:
        {
            // 应用移动后的新坐标
            CGPoint newPoint = [longPressGesture locationInView:longPressGesture.view];
            [self.delegate pressGestureStateChangedWithPoint:newPoint gridItem:self];
            break;
        }
        case UIGestureRecognizerStateEnded:
        {
            [self.delegate pressGestureStateEnded:self];
            break;
        }
        default:
            break;
    }
}

// 根据格子的坐标计算格子的索引位置
+ (NSInteger)indexOfPoint:(CGPoint)point
               withButton:(UIButton *)btn
                gridArray:(NSMutableArray *)gridListArray
{
    for (NSInteger i = 0;i< gridListArray.count;i++)
    {
        UIButton *appButton = gridListArray[i];
        if (appButton != btn)
        {
            if (CGRectContainsPoint(appButton.frame, point))
            {
                return i;
            }
        }
    }
    return -1;
}

// 添加格子后调用
- (void)addGridAction
{
    if (_isEmpty)
    {
        // 计算占位格子的X坐标
        CGFloat pointX;
        // 计算占位格子的Y坐标
        CGFloat pointY;
        if (self.gridIndex % PerRowGridCount == 0) {
            NSLog(@"第一个");
            // 最后一列 要换行
            pointX = PaddingX;
            pointY = (self.gridIndex / PerRowGridCount) * (GridHeight + PaddingY) + PaddingY;
        }
        else
        {
            pointX = (self.gridIndex % PerRowGridCount) * (GridWidth + PaddingX) + PaddingX;
            pointY = (self.gridIndex / PerRowGridCount) * (GridHeight + PaddingY) + PaddingY;
        }
        [UIView animateWithDuration:0.3 animations:^{
            [self setFrame:CGRectMake(pointX, pointY, GridWidth+1, GridHeight+1)];
        }];
    }
}

@end
