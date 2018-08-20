//
//  UserGuideVC.m
//  APlus
//
//  Created by 李慧娟 on 2017/11/10.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "UserGuideVC.h"
@interface UserGuideVC ()
{
    NSMutableArray *_arrayGuideImage;
    UIScrollView *_scrollGuideContent;
}
@end

@implementation UserGuideVC

/*!
 *  图片引导初始化
 *
 *  @param arrayGuideImage 图片数组
 *
 *  @return 初始化UserGuideViewController对象
 */
- (id)initWithArrayGuideImage:(NSMutableArray *)arrayGuideImage {
    self = [super init];
    if (self) {
        // Initialize self.
        //图片数组赋值
        _arrayGuideImage = arrayGuideImage;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    //新手教程内容
    _scrollGuideContent = [[UIScrollView alloc] initWithFrame:self.view.frame];
    [_scrollGuideContent setBackgroundColor:[UIColor whiteColor]];
    _scrollGuideContent.pagingEnabled = YES;
    _scrollGuideContent.showsHorizontalScrollIndicator = NO;
    _scrollGuideContent.showsVerticalScrollIndicator = NO;
    _scrollGuideContent.bounces = NO;
    _scrollGuideContent.contentSize = CGSizeMake(self.view.frame.size.width*[_arrayGuideImage count], self.view.frame.size.height);
    for (int i = 0; i < [_arrayGuideImage count]; i++) {
        UIImageView *imageGuide = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width * i, 0, self.view.frame.size.width, _scrollGuideContent.frame.size.height)];
        imageGuide.image = [UIImage imageNamed:[_arrayGuideImage objectAtIndex:i]];

        //跳过按钮
        UIButton *buttonSkip = [UIButton buttonWithType:UIButtonTypeSystem];
        buttonSkip.frame = CGRectMake(self.view.frame.size.width * ( i + 1) - 60, 0, 60, 60);
        [buttonSkip setBackgroundColor:[UIColor clearColor]];
        [buttonSkip addTarget:self action:@selector(actionMoveOut) forControlEvents:UIControlEventTouchUpInside];
        [_scrollGuideContent addSubview:imageGuide];
        [_scrollGuideContent addSubview:buttonSkip];
    }

    //退出按钮
    UIButton *buttonMoveOut = [UIButton buttonWithType:UIButtonTypeCustom];
    buttonMoveOut.frame = CGRectMake(self.view.frame.size.width * ([_arrayGuideImage count] - 1), self.view.frame.size.height / 2, self.view.frame.size.width, self.view.frame.size.height);
    buttonMoveOut.backgroundColor = [UIColor clearColor];
    [buttonMoveOut addTarget:self action:@selector(actionMoveOut) forControlEvents:UIControlEventTouchUpInside];

    [_scrollGuideContent addSubview:buttonMoveOut];
    [self.view addSubview:_scrollGuideContent];

}


#pragma mark - SelfMethods
/*!
 *  退出新手教程
 */
- (void)actionMoveOut {
    __weak typeof(self) weakSelf = self;

    [UIView animateWithDuration:1.0 animations:^{

        [CommonMethod setUserdefaultWithValue:[NSNumber numberWithBool:YES]
                                       forKey:ShowWelcomePage];
        weakSelf.view.transform = CGAffineTransformScale(weakSelf.view.transform, 2.0, 2.0);
        weakSelf.view.window.alpha = 0;

    } completion:^(BOOL finished){

        [weakSelf.view.window removeFromSuperview];
    }];
}

@end
