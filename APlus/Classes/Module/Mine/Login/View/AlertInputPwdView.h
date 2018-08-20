//
//  AlertInputPwdView.h
//  PanKeTong
//
//  Created by 燕文强 on 16/3/29.
//  Copyright © 2016年 苏军朋. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LoginEntity.h"
#import "RequestManager.h"


@protocol AlertInputPwdViewDelegate <NSObject>

- (void)validSuc;
- (void)locked;

@end

@interface AlertInputPwdView : UIView<UITextFieldDelegate,ResponseDelegate>
{
    int _isShowPwd;
    int _errorCount;
    int _errorLimit;
}

@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *swithPwdBtn;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;

- (IBAction)closeBtnClick:(id)sender;
- (IBAction)okClick:(id)sender;
- (IBAction)switchPwdStatus:(id)sender;

@property (nonatomic,strong) id <AlertInputPwdViewDelegate> delegate;

- (void)removeWindow;
- (void)showClose:(BOOL)isShow;

/*
 *  获取与上次错误时间间隔
 */
+ (NSTimeInterval)getTimeIntervalForLastErrorTime;

/*
 *  是否需要继续保持等待倒计时解锁状态
 */
+ (BOOL)isForceLock;

/**
 *  重设errorTime
 */
+ (void)resetErrorTimes;

@end
