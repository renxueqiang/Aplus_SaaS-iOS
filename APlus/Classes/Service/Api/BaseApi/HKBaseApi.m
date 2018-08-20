//
//  HKLoginApi.m
//  APlus
//
//  Created by 燕文强 on 2017/9/22.
//  Copyright © 2017年 燕文强. All rights reserved.
//

#import "HKBaseApi.h"
#import "CENTANETKeyChain.h"

@implementation HKBaseApi

- (NSString *)getRootUrl
{
    return @"http://114.80.110.197/hkapi/api/";
}

- (NSMutableDictionary *)getBaseHeader
{
    NSMutableDictionary *headerDic = [NSMutableDictionary dictionary];

    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *deviceUDID = [CENTANETKeyChain getAppOnlyIdentifierOnDevice];
    NSString *session=[[NSUserDefaults standardUserDefaults]stringForKey:HouseKeeperSession];
    NSString *companyCode = [[NSUserDefaults standardUserDefaults]stringForKey:CityCode];

    [headerDic setValue:deviceUDID forKey:@"Udid"];
    [headerDic setValue:app_Version forKey:@"ClientVer"];
    [headerDic setValue:session forKey:@"HKSession"];
    [headerDic setValue:companyCode forKey:@"CompanyCode"];
    [headerDic setValue:@"none" forKey:@"Channel"];
    [headerDic setValue:@"iOS" forKey:@"platform"];
    [headerDic setValue:@"application/json" forKey:@"Accept"];
    [headerDic setValue:@"application/json" forKey:@"content-type"];
    [headerDic setValue:@"iPhone" forKey:@"User-Agent"];
    
    return headerDic;
}

- (NSMutableDictionary *)getBaseBody
{
    return [NSMutableDictionary new];
}

- (int)getTimeOut
{
    return 6;
}

- (NSString *)checkRespData:(id)data
{
    HKBaseEntity *hkentity = data;
    NSString *msg = hkentity.rMessage;
    if(hkentity.rCode == 400)
    {
        msg = hkentity.rMessage.length > 0 ? hkentity.rMessage : Default_Msg;
    }
    return msg;
}

@end
