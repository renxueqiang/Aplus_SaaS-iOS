//
//  LoadingVC.m
//  APlus
//
//  Created by 李慧娟 on 17/11/3.
//  Copyright (c) 2017年 CentaLine. All rights reserved.
//

#import "LoadingVC.h"
#import "LogOffUtil.h"
#import "PermissionApi.h"

@interface LoadingVC ()<MessageChangeDelegate>
{
    GetSystemParamApi *_systemParamApi;

    UIImageView *_adLoadingLogoImageView;          //APP的logo
    UIImageView *_adLoadingRedCircleImageView;     //红色的logo背景图
    UIImageView *_adLoadingWhiteBgImageView;       //白色镂空背景
    UIImageView *_adLoadingButtomEstateImageView;  //底部房子图片
    
    UILabel *_adLoadingButtomVersion;               //底部APP版本号
    
    __weak IBOutlet UIImageView *_adLoadingRedBgImageView;

    BOOL _loadAnimationSuccess;         //是否完成动画过程
    BOOL _isNowRequest;                 //是否正在请求系统参数
    BOOL _systemParamDone;              //是否完成获取系统参数
    BOOL _unlockInfoDone;               //是否完成获取解锁状态
}

@end

@implementation LoadingVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _unlockInfoDone = NO;
    _systemParamDone = NO;
    
    _loadAnimationSuccess = NO;
    [self sharedAppDelegate].messageChangeDelegate = self;

    [self initLoadView];

    //加载系统参数
    [self requestSystemPara];

}

#pragma mark － <加载启动动画>

- (void)initLoadView
{
    UIImage *appLogoImage = [UIImage imageNamed:@"login_img_logo"];
    UIImage *buttomEstateImage = [UIImage imageNamed:@"loadingBottom"];

    _adLoadingRedCircleImageView = [[UIImageView alloc]init];
    [_adLoadingRedCircleImageView setFrame:CGRectMake(APP_SCREEN_WIDTH/2-80,
                                                      152,
                                                      160,
                                                      160)];
    [self.view addSubview:_adLoadingRedCircleImageView];

    _adLoadingLogoImageView = [[UIImageView alloc]init];
    [_adLoadingLogoImageView setImage:appLogoImage];
    [_adLoadingLogoImageView setFrame:CGRectMake(APP_SCREEN_WIDTH/2-44,
                                                 44,
                                                 88,
                                                 77)];
    [self.view addSubview:_adLoadingLogoImageView];

    _adLoadingButtomEstateImageView = [[UIImageView alloc]init];
    [_adLoadingButtomEstateImageView setImage:buttomEstateImage];
    [_adLoadingButtomEstateImageView setFrame:CGRectMake(0,
                                                         APP_SCREEN_HEIGHT - 62.0,
                                                         APP_SCREEN_WIDTH/320.0*640,
                                                         62.0)];
    [self.view addSubview:_adLoadingButtomEstateImageView];

    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [NSString stringWithFormat:@"版本号：%@",
                             [infoDictionary objectForKey:@"CFBundleShortVersionString"]];

    _adLoadingButtomVersion = [[UILabel alloc]init];
    [_adLoadingButtomVersion setFont:[UIFont fontWithName:FontName
                                                     size:14.0]];
    [_adLoadingButtomVersion setFrame:CGRectMake(0,
                                                 APP_SCREEN_HEIGHT-28,
                                                 APP_SCREEN_WIDTH,
                                                 16)];
    [_adLoadingButtomVersion setTextAlignment:NSTextAlignmentCenter];
    [_adLoadingButtomVersion setBackgroundColor:[UIColor clearColor]];
    [_adLoadingButtomVersion setTextColor:RGBColor(51, 51, 51)];
    [_adLoadingButtomVersion setText:app_Version];

    [self.view addSubview:_adLoadingButtomVersion];

    [self performSelector:@selector(createAnimation)
               withObject:nil
               afterDelay:0.5];
}

#pragma mark - <获取系统参数>

- (void)requestSystemPara
{
     // 获取系统参数
    _isNowRequest = YES;

    NSString *sysParamNewUpdTime = [AgencySysParamUtil getSysParamNewUpdTime];
    NSLog(@"上次系统参数更新时间%@",sysParamNewUpdTime);

    NSString *staffNum = [CommonMethod getUserdefaultWithKey:UserStaffNumber];
    if (staffNum.length > 0)
    {
        _systemParamApi = [GetSystemParamApi new];
        _systemParamApi.updateTime = sysParamNewUpdTime;
        [_manager sendRequest:_systemParamApi];

    }
    else
    {
        _systemParamDone = YES;
    }

    NSString *session = [[NSUserDefaults standardUserDefaults]stringForKey:HouseKeeperSession];
    if (!session || [session isEqualToString:@""])
    {
        _unlockInfoDone = YES;
    }
    else
    {
        ManageLockStatusApi *manageLockStatusApi = [[ManageLockStatusApi alloc] init];
        manageLockStatusApi.ManageAccountLockStatusType = GetAccountLockStatus;
        [_manager sendRequest:manageLockStatusApi];
    }
}


#pragma mark - AnimationMethod

- (void)createAnimation
{
    
    __weak typeof (self)weakSelf = self;
    
    [UIView animateWithDuration:1.0 animations:^{

                         [weakSelf moveButtomEstImageMethod];

                     } completion:^(BOOL finished) {
                         
                         [UIView animateWithDuration:0.5 animations:^{
                                              
                                              [weakSelf changeLogoBgImageMethod];

                                          }completion:^(BOOL finished) {
                                              [UIView animateWithDuration:0.5
                                                               animations:^{
                                                                   [weakSelf checkSysParamMethod];
                                                               }];
                                          }];
                     }];
}

- (void)moveButtomEstImageMethod
{
    [_adLoadingButtomEstateImageView setFrame:CGRectMake(-320,
                                                         _adLoadingButtomEstateImageView.y,
                                                         _adLoadingButtomEstateImageView.width,
                                                         _adLoadingButtomEstateImageView.height)];
}

- (void)changeLogoBgImageMethod
{
    _adLoadingRedBgImageView.alpha = 1.0;
    _adLoadingRedCircleImageView.transform = CGAffineTransformMakeScale(10.0, 10.0);
    _adLoadingRedCircleImageView.alpha = 0;
}

- (void)moveAppIconImageMethod
{
    [_adLoadingLogoImageView setFrame:CGRectMake(_adLoadingLogoImageView.x,
                                                 100,
                                                 _adLoadingLogoImageView.width,
                                                 _adLoadingLogoImageView.height)];
}

#pragma mark - NetWorkDelegate

- (void)networkStatusChanged:(BOOL)isReachable
{
    SystemParamEntity *sysParamEntity = [AgencySysParamUtil getSystemParam];

    if (isReachable &&
        !_isNowRequest &&
        !sysParamEntity)
    {
        _isNowRequest = YES;

        NSString *staffNum = [CommonMethod getUserdefaultWithKey:UserStaffNumber];
        if (staffNum.length > 0)
        {
            NSString *sysParamNewUpdTime = [AgencySysParamUtil getSysParamNewUpdTime];
            _systemParamApi = [GetSystemParamApi new];
            _systemParamApi.updateTime = sysParamNewUpdTime;
            [_manager sendRequest:_systemParamApi];
        }
    }
}

#pragma mark - 做完动画后检查“系统参数”是否获取完成

- (void)checkSysParamMethod
{
    _loadAnimationSuccess = YES;
    
    if(_unlockInfoDone && _systemParamDone)
    {
        [self.delegate getSysParamSuccessed];
    }
    
}

#pragma mark - <ResponseDelegate>

- (void)dealData:(CentaResponse *)resData
{
    [super dealData:resData];

    Class modelClass = [resData.api getRespClass];

    if ([modelClass isEqual:[SystemParamEntity class]])
    {
        _isNowRequest = NO;
        _systemParamDone = YES;

        SystemParamEntity *systemParamEntity = resData.data;
        if(systemParamEntity.needUpdate)
        {
            [AgencySysParamUtil setSystemParam:systemParamEntity];
            NSLog(@"系统参数有更新");
            if (_loadAnimationSuccess)
            {
                [self checkSysParamMethod];
            }
        }
        else
        {
            NSLog(@"系统参数不需要更新");
        }
    }

    if ([modelClass isEqual:[LockStatusEntity class]])
    {
        _unlockInfoDone = YES;

        LockStatusEntity *lockStatusEntity = resData.data;
        NSInteger isUnLock = [lockStatusEntity.result integerValue];
        if (isUnLock == 1)
        {
            [self sharedAppDelegate].isForceUnLock = YES;
        }
        else
        {
            [self sharedAppDelegate].isForceUnLock = NO;
        }
        NSLog(@"是否要强制解锁＝＝＝%@",[self sharedAppDelegate].isForceUnLock?@"是":@"否");
        if (_loadAnimationSuccess)
        {
            [self checkSysParamMethod];
        }
        if ([lockStatusEntity.result integerValue] == 1)
        {
            //清空原来手势密码
            [CLLockVC clearCoreLockPWDKey];
        }
    }
}

- (void)respFail:(CentaResponse *)error
{
    [super respFail:error];

    Class modelClass = [error.api getRespClass];

    if([modelClass isEqual:[LockStatusEntity class]])
    {
        _unlockInfoDone = YES;
        /**
         *  跳到登录页，用户退出登录后清除用户信息
         */
        [LogOffUtil clearUserInfoFromLocal];

        [[self sharedAppDelegate] changeDiscoverRootVCIsLogin:YES];
    }

    _isNowRequest = NO;

    if (_loadAnimationSuccess)
    {
        [self checkSysParamMethod];
    }

}



@end
