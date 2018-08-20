//
//  LoginBasePresenter.h
//  APlus
//
//  Created by 中原管家 on 2017/5/11.
//  Copyright © 2017年 中原集团. All rights reserved.
//

#import "BasePresenter.h"
#import "LoginViewProtocol.h"

@interface LoginBasePresenter : BasePresenter

@property (assign, nonatomic) id<LoginViewProtocol>selfView;

- (instancetype)initWithDelegate:(id<LoginViewProtocol>)delegate;

/// 获取虚拟号配置
- (void)getMsisdnMethod;

@end
