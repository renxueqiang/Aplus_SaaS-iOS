//
//  SimApiDomainUtil.m
//  APlus
//
//  Created by 中原管家 on 2016/12/16.
//  Copyright © 2016年 中原集团. All rights reserved.
//

#import "SimApiDomainUtil.h"

@implementation SimApiDomainUtil

static NSString *APlusDomain;
static NSString *ImageServerUrl;

/// 管家url (决定环境)
- (NSString *)getHouseKeeperUrl
{
//    return @"http://zygj.centanet.com/api/api/";      //正式环境
        return @"http://114.80.110.197/hkapi/api/";         //从测试环境读取域名配置信息
}

#pragma mark - 后台可配置Url
/// A＋ url
- (NSString *)getAPlusDomainUrl
{
    return @"http://10.5.9.54:8080";
}

/// A+图片服务地址
- (NSString *)getImageServerUrl
{
    return @"https://bjstatic.centaline.com.cn:442/image/upload2/";
}

- (NSString *)getTQTOKEN
{
    return TQ_TEST_TOKEN;
}

@end
