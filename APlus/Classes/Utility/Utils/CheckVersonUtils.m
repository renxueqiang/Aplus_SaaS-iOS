//
//  CheckVersonUtils.m
//  APlus
//
//  Created by 中原管家 on 2016/10/9.
//  Copyright © 2016年 中原集团. All rights reserved.
//

#import "CheckVersonUtils.h"
#import "CheckVersonEntity.h"
//#import "ServiceHelper.h"

#define ForceUpdateAlertTag         1000    //强制版本更新提示框
#define NormalUpdateAlertTag        2000    //正常版本更新提示框

@implementation CheckVersonUtils

static CheckVersonUtils *checkVersonUtils;


+ (CheckVersonUtils *)shareCheckVersonUtils
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        checkVersonUtils = [[self alloc] init];
        checkVersonUtils.isShowErrorAlert = NO;
        checkVersonUtils.manager = [RequestManager defaultManager:checkVersonUtils];
        [checkVersonUtils.manager setInterceptorForSuc:[[DataConvertInterceptor alloc] init]];
    });
//    if(checkVersonUtils)
//    {
//        return checkVersonUtils;
//    }
//
//
//    checkVersonUtils = [[self alloc] init];
//    checkVersonUtils.isShowErrorAlert = NO;

    
    return checkVersonUtils;
}

/**
 *  检查服务端版本号，看是否需要更新版本
 */
- (void)checkAppVerson
{
//    [checkVersonUtils hasManager];

    CheckAppVersonApi *checkAppVersonApi = [[CheckAppVersonApi alloc] init];
    [checkVersonUtils.manager sendRequest:checkAppVersonApi];

}

//- (void)hasManager
//{
//    if (!checkVersonUtils.manager)
//    {
//        checkVersonUtils.manager = [RequestManager defaultManager:self];
//        [_manager setInterceptorForSuc:[[DataConvertInterceptor alloc] init]];
//    }
//}


- (void)setIsShowErrorAlert:(BOOL)isShowErrorAlert
{
    if (_isShowErrorAlert != isShowErrorAlert)
    {
        _isShowErrorAlert = isShowErrorAlert;
    }
}

#pragma mark - <UIAlertViewDelegate>

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    // 版本更新地址、更新内容
    NSString *updateUrl = [[NSUserDefaults standardUserDefaults]stringForKey:UpdateVersionUrl];
//    NSString *udpateContent = [[NSUserDefaults standardUserDefaults]stringForKey:UpdateContent];

    switch (alertView.tag)
    {
        case ForceUpdateAlertTag:
        {
            // 强制更新alert
//            UIAlertView *forceUpdateAlert = [[UIAlertView alloc]initWithTitle:@"有版本更新"
//                                                                      message:udpateContent
//                                                                     delegate:self
//                                                            cancelButtonTitle:nil
//                                                            otherButtonTitles:@"更新", nil];
//            forceUpdateAlert.tag = ForceUpdateAlertTag;
//
//            [forceUpdateAlert show];

            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateUrl]];
            
            exit(0);
        }
            break;
        case NormalUpdateAlertTag:
        {
            // 正常更新alert
            if (buttonIndex == 1)
            {
                // 去更新
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:updateUrl]];

                exit(0);
            }
        }
            break;

        default:
            break;
    }
}

#pragma mark - <ResponseDelegate>

- (void)respSuc:(CentaResponse *)resData
{
    Class modelClass = [resData.api getRespClass];

    if ([modelClass isEqual:[CheckVersonEntity class]])
    {
        if (self.delegate && [self.delegate respondsToSelector:@selector(requestSuccess)])
        {
            [self.delegate requestSuccess];
        }

        CheckVersonEntity *entity = resData.data;

        // 获取服务端版本号成功，使用build verson更新
        CheckVersonResultEntity *versonDetailEntity = entity.result;
        // 保存更新地址、更新内容
        [CommonMethod setUserdefaultWithValue:versonDetailEntity.updateUrl
                                       forKey:UpdateVersionUrl];
        [CommonMethod setUserdefaultWithValue:versonDetailEntity.updateContent
                                       forKey:UpdateContent];

        NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
        NSString *app_Version = [infoDictionary objectForKey:@"CFBundleVersion"];
        if (versonDetailEntity.forceUpdate == 1)
        {
            // 服务端设置强制更新
            if ([versonDetailEntity.clientVer integerValue] > [app_Version integerValue])
            {
                UIAlertView *forceUpdateAlert = [[UIAlertView alloc]initWithTitle:@"有版本更新"
                                                                          message:versonDetailEntity.updateContent
                                                                         delegate:self
                                                                cancelButtonTitle:nil
                                                                otherButtonTitles:@"更新", nil];
                forceUpdateAlert.tag = ForceUpdateAlertTag;
                [forceUpdateAlert show];
            }
            else
            {
                if (_isShowErrorAlert)
                {
                    showMsg(@"当前已是最新版本！");
                    _isShowErrorAlert = NO;
                }
            }
        }
        else
        {
            if ([versonDetailEntity.clientVer integerValue] > [app_Version integerValue])
            {
                // 服务端有版本更新，不要求强制更新
                UIAlertView *normalAlertView = [[UIAlertView alloc]initWithTitle:@"有版本更新"
                                                                         message:versonDetailEntity.updateContent
                                                                        delegate:self
                                                               cancelButtonTitle:@"取消"
                                                               otherButtonTitles:@"更新", nil];
                normalAlertView.tag = NormalUpdateAlertTag;
                [normalAlertView show];
            }
            else
            {
                if (_isShowErrorAlert)
                {
                    showMsg(@"当前已是最新版本！");
                    _isShowErrorAlert = NO;
                }
            }
        }
    }

}

- (void)respFail:(CentaResponse *)error {

}




@end
