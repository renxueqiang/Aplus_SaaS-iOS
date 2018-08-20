//
//  NetworkInterceptor.m
//  APlus
//
//  Created by 燕文强 on 2017/9/20.
//  Copyright © 2017年 燕文强. All rights reserved.
//

#import "InterceptorForRespSuc.h"

@implementation InterceptorForRespSuc

- (CentaResponse *)intercept:(id)task andRespData:(id)respData andApi:(AbsApi<ApiDelegate> *)api
{
    CentaResponse *resp =  [self checkData:[self convertData:task andRespData:respData andApi:api]];
    return resp;
}

- (CentaResponse *)convertData:(id)task andRespData:(id)respData andApi:(AbsApi<ApiDelegate> *)api
{
    id dic = [NSJSONSerialization JSONObjectWithData:respData
                                                        options:NSJSONReadingMutableContainers
                                                          error:nil];
    CentaResponse *resp = [self createResponse];
    resp.data = dic;
    resp.api = (BaseApi *)api;
    NSString *path = [api getPath];
    NSLog(@"********[%@返回数据：%@",path,dic);
    
    NSURLSessionDataTask *urlTask = task;
    NSHTTPURLResponse *urlresp = (NSHTTPURLResponse *)urlTask.response;
    resp.code = urlresp.statusCode;
    
    return resp;
}

- (CentaResponse *)checkData:(CentaResponse *)resp
{
    NSString *msg = [resp.api checkRespData:resp.data];
    if(msg)
    {
        resp.suc = NO;
        resp.msg = msg;
    }
    return resp;
}

- (CentaResponse *)createResponse
{
    CentaResponse *resp = [CentaResponse new];
    resp.suc = YES;
    resp.code = 200;
    resp.msg = @"";
    
    return resp;
}

@end
