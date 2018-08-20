//
//  AlertInputPwdView.m
//  PanKeTong
//
//  Created by 燕文强 on 16/3/29.
//  Copyright © 2016年 苏军朋. All rights reserved.
//

#import "AlertInputPwdView.h"
#import "CommonMethod.h"
#import "HKCommonApi.h"
//#import "ServiceHelper.h"

#define WaitMinute              60  // 等待多少分
#define WaitSecond              60  // 等待多少秒
#define APlusPwdErrorTime       @"APlusPwdErrorTime"


@implementation AlertInputPwdView
{
    HKLoginApi *_loginApi;
    RequestManager *_manager;
    
    NSInteger _count;
    BOOL isLoginStatus;
    
//    Error *_error;

}

- (void)awakeFromNib
{
    [super awakeFromNib];

    isLoginStatus = NO;
    _manager = [RequestManager defaultManager:self];
    [_manager setInterceptorForSuc:[[DataConvertInterceptor alloc] init]];

    // 禁止边缘滑动
    _scrollView.scrollEnabled = NO;
    
    _isShowPwd = 0;
    _pwdTextField.secureTextEntry = YES;
    _errorLimit = 5;
    _count = WaitMinute * WaitSecond;
    
    _pwdTextField.tag = 10;
    _pwdTextField.delegate = self;
    [_pwdTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    
    // 获取已错误次数
    _errorCount = 0;
    NSString *lastErrorTimes = [CommonMethod getUserdefaultWithKey:ErrorTimes];
    if(lastErrorTimes)
    {
        _errorCount = [lastErrorTimes intValue];
    }
    
    // 检查错误时间
    NSDate *date = [CommonMethod getUserdefaultWithKey:APlusPwdErrorTime];
    if(!date)
    {
        [CommonMethod setUserdefaultWithValue:[NSDate dateWithTimeIntervalSince1970:0] forKey:APlusPwdErrorTime];
    }
    
    
    // 检查是否达到一小时,是否还需要继续锁定状态
    BOOL forceLock = [AlertInputPwdView isForceLock];
    if(forceLock)
    {
        NSTimeInterval timeInterval = [AlertInputPwdView getTimeIntervalForLastErrorTime];
        NSInteger timerNumber = WaitSecond * WaitMinute - (-timeInterval)/1;
        _count = timerNumber;
        _resultLabel.text = [NSString stringWithFormat:@"为了保护您的帐号安全，请于%ld:%.2ld分钟后重试！",_count/60,_count%60];
        [self startThread];
    }
}

- (void)validLoginWithPwd:(NSString *)pwd
{
    NSString *account = [CommonMethod getUserdefaultWithKey:Account];
    
    _loginApi = [HKLoginApi new];
    _loginApi.account = account;
    _loginApi.pwd = pwd;
    [_manager sendRequest:_loginApi];
}

- (IBAction)okClick:(id)sender
{
    [self okClickEvent];
}

- (void)okClickEvent
{
    if(isLoginStatus)
    {
        return;
    }
    isLoginStatus = YES;
    NSLog(@"======登录=====");
    
    BOOL forceLock = [AlertInputPwdView isForceLock];
    if(forceLock)
    {
        return;
    }
	
    if(_errorCount > _errorLimit)
    {
        
        isLoginStatus = NO;
        if(self.delegate)
        {
            [self.delegate locked];
        }

        // 保存错误后强制锁定时间
        [CommonMethod setUserdefaultWithValue:[NSDate date] forKey:APlusPwdErrorTime];
        
        NSDate *date = [CommonMethod getUserdefaultWithKey:APlusPwdErrorTime];
        
        NSTimeInterval  timeInterval = [date timeIntervalSinceNow];
        if(timeInterval > -60 * 60)
        {
            [self startThread];
        }
        return;
    }
    
    [self validLoginWithPwd:_pwdTextField.text];
}

- (IBAction)closeBtnClick:(id)sender
{
    
    [self removeWindow];
}

- (void)removeWindow
{
    [self removeFromSuperview];

    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelegate.window makeKeyAndVisible];
    
}

- (void)showClose:(BOOL)isShow
{
    if(isShow)
    {
        _closeBtn.hidden = NO;
    }
    else
    {
        _closeBtn.hidden = YES;
    }
}

- (IBAction)switchPwdStatus:(id)sender
{
    switch (_isShowPwd)
    {
        case 0:
        {
            [self endEditing:YES];
            _isShowPwd = 1;
            _pwdTextField.secureTextEntry = NO;
            [_swithPwdBtn setBackgroundImage:[UIImage imageNamed:@"pop_btn_eye_open"] forState:UIControlStateNormal];
        }
            break;

        case 1:
        {
            [self endEditing:YES];
            _isShowPwd = 0;
            _pwdTextField.secureTextEntry = YES;
            [_swithPwdBtn setBackgroundImage:[UIImage imageNamed:@"pop_btn_eye_close"] forState:UIControlStateNormal];
            
        }
            break;
            
        default:
            break;
    }
}

- (void)startThread
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        BOOL loop = YES;
        while (loop) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                // 更新界面
                _resultLabel.text = [NSString stringWithFormat:@"为了保护您%d帐号安全，请于%ld:%.2ld分钟后重试！",_count/60,_count%60];
            });
            
            [NSThread sleepForTimeInterval:1];
            
            _count--;
            
            if(_count <= 0)
            {
                loop = NO;
            }
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            // 更新界面
            _resultLabel.text = @"";
            [self reset];
        });
    });
}

#pragma mark - <textFieldDelegate>

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self okClickEvent];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSInteger tag = textField.tag;
    
    if (tag==10)
    {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > PwdInputLength)
        {
            return NO;
        }
    }
    
    return YES;
}

- (void)textFieldDidChange:(UITextField *)textField
{
    if (textField.tag == 10)
    {
        if (textField.text.length > PwdInputLength)
        {
            textField.text = [textField.text substringToIndex:PwdInputLength];
        }
    }
}

+ (NSTimeInterval)getTimeIntervalForLastErrorTime
{
    NSDate *date = [CommonMethod getUserdefaultWithKey:APlusPwdErrorTime];
    NSTimeInterval  timeInterval = 0;
    if (!date)
    {
      timeInterval = -[[NSDate date] timeIntervalSince1970];
    }
    else
    {
      timeInterval = [date timeIntervalSinceNow];
    }
    return timeInterval;
}

+ (BOOL)isForceLock
{
    NSTimeInterval  timeInterval = [self getTimeIntervalForLastErrorTime];
    if(timeInterval > -WaitSecond * WaitMinute)
    {
        return YES;
    }
    return NO;
}

- (void)reset
{
    _errorCount = 0;

    // 重置错误次数
    [AlertInputPwdView resetErrorTimes];
    _count = WaitMinute;
}

+ (void)resetErrorTimes
{
    [CommonMethod setUserdefaultWithValue:0 forKey:ErrorTimes];
}

#pragma mark - <ResponseDelegate>

- (void)respSuc:(CentaResponse *)resData
{
    Class modelClass = [resData.api getRespClass];
    if ([modelClass isEqual:[LoginEntity class]])
    {
        LoginEntity *loginEntity = resData.data;
        LoginResultEntity *result=loginEntity.result;
        NSString *userName = [NSString nilToEmptyWithStr:result.loginDomainUser.cnName];
        [CommonMethod setUserdefaultWithValue:userName
                                       forKey:UserName];

        NSString *userStaffNumber = [NSString nilToEmptyWithStr:result.loginDomainUser.staffNo];
        [CommonMethod setUserdefaultWithValue:userStaffNumber
                                       forKey:UserStaffNumber];

        NSString *houseKeeperSession = [NSString nilToEmptyWithStr:result.session];
        [CommonMethod setUserdefaultWithValue:houseKeeperSession
                                       forKey:HouseKeeperSession];

        NSString *cityCode = [NSString nilToEmptyWithStr:result.loginDomainUser.cityCode];
        [CommonMethod setUserdefaultWithValue:cityCode
                                       forKey:CityCode];

        NSString *userStaffMobile = [NSString nilToEmptyWithStr:result.loginDomainUser.mobile];
        [CommonMethod setUserdefaultWithValue:userStaffMobile
                                       forKey:UserStaffMobile];

        NSString *userDeptName = [NSString nilToEmptyWithStr:result.loginDomainUser.deptName];
        [CommonMethod setUserdefaultWithValue:userDeptName
                                       forKey:UserDeptName];

        [self removeWindow];
        [self reset];

        if(self.delegate)
        {
            [self.delegate validSuc];
        }
    }
}

- (void)respFail:(CentaResponse *)error
{
    NSString *errorMsg = error.msg;

    if (errorMsg.length  >0 )
    {
        if ([errorMsg isEqualToString:@"数据为空"])
        {
            [CustomAlertMessage showAlertMessage:@"没有找到符合条件的信息\n\n"
                                 andButtomHeight:APP_SCREEN_HEIGHT/2];
        }
        else
        {
            _errorCount++;
            // 保存错误次数
            [CommonMethod setUserdefaultWithValue:[NSString stringWithFormat:@"%d",_errorCount] forKey:ErrorTimes];

            int elseTime = _errorLimit - _errorCount;

            if(elseTime <= 0)
            {
                isLoginStatus = NO;
                if(self.delegate)
                {
                    [self.delegate locked];
                }

                // 保存错误后强制锁定时间
                [CommonMethod setUserdefaultWithValue:[NSDate date] forKey:APlusPwdErrorTime];

                NSDate *date = [CommonMethod getUserdefaultWithKey:APlusPwdErrorTime];

                NSTimeInterval  timeInterval = [date timeIntervalSinceNow];
                if(timeInterval > -60*60)
                {
                    [self startThread];
                }
            }
            else
            {
                _resultLabel.text = [NSString stringWithFormat:@"登录密码错误，你还可以输入%d次",_errorLimit-_errorCount];
            }
        }

    }
}


@end
