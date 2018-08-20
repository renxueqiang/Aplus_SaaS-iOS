//
//  LoginBasePresenter.m
//  APlus
//
//  Created by 中原管家 on 2017/5/11.
//  Copyright © 2017年 中原集团. All rights reserved.
//

#import "LoginBasePresenter.h"
#import "DascomUtil.h"

@implementation LoginBasePresenter

- (instancetype)initWithDelegate:(id<LoginViewProtocol>)delegate
{
    self = [super init];
    if (self) {
        _selfView = delegate;
    }
    return self;
}

/// 获取虚拟号配置
- (void)getMsisdnMethod
{
    [DascomUtil shareDascomUtil].fromeVC = @"login";
    [[DascomUtil shareDascomUtil] requestMsisdn:^{
        
        
    }];
}

@end
