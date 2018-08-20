//
//  ApiDomainUtil.m
//  APlus
//
//  Created by 燕文强 on 16/4/14.
//  Copyright © 2016年 苏军朋. All rights reserved.
//

#import "ApiDomainUtil.h"

@implementation ApiDomainUtil

static NSString *APlusDomain;
static NSString *ImageServerUrl;

/// 管家url (决定环境)
- (NSString *)getHouseKeeperUrl
{
    return @"http://114.80.110.197/hkapi/api/";         // 从测试环境读取域名配置信息
}

#pragma mark - 后台可配置Url
/// A＋ url
- (NSString *)getAPlusDomainUrl
{
    return [super getAPlusDomainUrl];
}

- (NSString *)getTQTOKEN
{
    return TQ_TEST_TOKEN;
}

@end
