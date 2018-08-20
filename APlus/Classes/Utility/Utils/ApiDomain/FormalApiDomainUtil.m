//
//  FormalApiDomainUtil.m
//  APlus
//
//  Created by 中原管家 on 2017/7/28.
//  Copyright © 2017年 中原集团. All rights reserved.
//

#import "FormalApiDomainUtil.h"

@implementation FormalApiDomainUtil

static NSString *APlusDomain;
static NSString *ImageServerUrl;

- (NSString *)getHouseKeeperUrl
{
    return @"http://zygj.centanet.com/api/api/";       //正式环境
}

#pragma mark - 后台可配置Url
// A＋ url
- (NSString *)getAPlusDomainUrl
{
    return [super getAPlusDomainUrl];
}

#pragma mark - 非后台可配置Url

/// 获得北京TQtoken
- (NSString *)getTQTOKEN
{
    return TQ_TOKEN;
}

@end
