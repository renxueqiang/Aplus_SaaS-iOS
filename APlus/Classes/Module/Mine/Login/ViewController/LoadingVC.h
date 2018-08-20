//
//  LoadingVC。h
//  APlus
//
//  Created by 李慧娟 on 17/11/3.
//  Copyright (c) 2017年 CentaLine. All rights reserved.
//

#import "BaseViewController.h"
#import "AgencySysParamUtil.h"

@protocol LoadingDelegate <NSObject>

- (void)getSysParamSuccessed;
//- (void)getForceUnLockStatusDone;

@end

@interface LoadingVC : BaseViewController

@property (nonatomic,weak) id <LoadingDelegate> delegate;

@end
