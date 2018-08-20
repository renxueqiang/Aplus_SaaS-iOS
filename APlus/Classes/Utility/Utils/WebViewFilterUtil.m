//
//  WebViewFilterUtil.m
//  APlus
//
//  Created by 燕文强 on 16/12/20.
//  Copyright © 2016年 中原集团. All rights reserved.
//

#import "WebViewFilterUtil.h"
#import "NSString+MD5Additions.h"
//#import "GetEstAgentQuotaApi.h"
//#import "AgentQuotaEntity.h"

@implementation WebViewFilterUtil

+ (AbsWebViewFilter *)instantiation;
{
    WebViewFilterUtil *webviewFilter = [[WebViewFilterUtil alloc]init];
    webviewFilter.WEBURL_QUANTIZATION_FILTER = @"我的量化";             // 我的量化h5关键字
    webviewFilter.WEBURL_ADVERT_MANAGER_FILTER = @"广告管理";           // 广告管理
    webviewFilter.WEBURL_PUBLISH_PROPERTY_FILTER = @"发布房源";         // 发布房源
    webviewFilter.WEBURL_EDIT_PROPERTY_FILTER = @"编辑房源";            // 编辑房源
    webviewFilter.WEBURL_TRANSACTION_RECORD_FILTER = @"成交进度查询";    // 成交进度查询
    webviewFilter.TITLE_OPERATION_DATA_CENTER = @"数据看板";            // 数据看板
    webviewFilter.WEBSITE_WITH_PROTOCOL = @"WebSiteWithProtocol";       // 拥有协议的网页
    
    return webviewFilter;
}

- (BOOL)havePermissionAccess:(NSDictionary *)urlConfig
{
    NSString *mdescription = [urlConfig objectForKey:@"Description"];
    if ([mdescription isEqualToString:self.WEBURL_QUANTIZATION_FILTER]
        || [mdescription isEqualToString:self.WEBSITE_WITH_PROTOCOL])
    {
        // 我的量化
        return true;
    }
    else if ([mdescription isEqualToString:self.WEBURL_ADVERT_MANAGER_FILTER])
    {
        // 广告管理
        return true;
    }
    else if ([mdescription isEqualToString:self.WEBURL_PUBLISH_PROPERTY_FILTER])
    {
        // 发布房源
        return true;
    }
    else if ([mdescription isEqualToString:self.WEBURL_EDIT_PROPERTY_FILTER])
    {
        // 编辑房源
        return true;
    }
    else if ([mdescription isEqualToString:self.WEBURL_TRANSACTION_RECORD_FILTER])
    {
        // 成交进度查询
        return true;
    }
    return true;
}

//- (NSString *)getFullUrl:(NSDictionary *)urlConfig;
//{
//    NSString *title = [urlConfig objectForKey:@"Title"];
//    NSString *mdescription = [urlConfig objectForKey:@"Description"];
//    NSDictionary *jumpContent = [urlConfig objectForKey:@"JumpContent"];
//    NSString *httpUrl = [jumpContent objectForKey:@"HttpUrl"];
//    
//    // 我的量化
//    if([mdescription isEqualToString:self.WEBURL_QUANTIZATION_FILTER]
//       || [mdescription isEqualToString:self.WEBSITE_WITH_PROTOCOL])
//    {
//        NSString *userKeyId = [AgencyUserPermisstionUtil getIdentify].uId;
//        NSString *userNo = [AgencyUserPermisstionUtil getIdentify].userNo;
//        NSString *departmentKeyId = [AgencyUserPermisstionUtil getIdentify].departId;
//        //时间戳
//        NSDate *nowDate = [NSDate date];
//        NSTimeInterval timestamp = [nowDate timeIntervalSince1970];
//        long unixTimeLong = (long)timestamp;
//        NSString *unixTimeStr = [NSString stringWithFormat:@"%@",@(unixTimeLong)];
//        // md5加密
//        NSString *md5Str = [NSString  stringWithFormat:@"ODC%@%ld",userKeyId,unixTimeLong - 555];
//        md5Str = md5Str.md5;
//        
//        NSMutableDictionary *dic = [NSMutableDictionary new];
//        [dic setValue:userKeyId forKey:@"userKeyId"];
//        [dic setValue:userNo forKey:@"userNo"];
//        [dic setValue:departmentKeyId forKey:@"departmentKeyId"];
//        [dic setValue:unixTimeStr forKey:@"checkTime"];
//        [dic setValue:md5Str forKey:@"secretKey"];
//        [dic setValue:@2 forKey:@"sourceType"];
//        [dic setValue:@"ios" forKey:@"platform"];
//        
//        // 数据看板
//        if ([title isEqualToString:self.TITLE_OPERATION_DATA_CENTER])
//        {
//            if ([CommonMethod isNeedAddCityCodeParama])
//            {
//                NSString *cityCode = [CityCodeVersion getCurrentCityCode];
//                [dic setValue:cityCode forKey:@"cityCode"];
//            }
//        }
//        
//        NSString *paramJson = [dic JSONString];
//        httpUrl = [NSString stringWithFormat:@"%@?urlParams=%@",httpUrl,paramJson];
//        httpUrl = [httpUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//    }
//    
//    // 广告管理
//    if ([mdescription isEqualToString:self.WEBURL_ADVERT_MANAGER_FILTER])
//    {
//
//    }
//    
//    return httpUrl;
//}



@end
