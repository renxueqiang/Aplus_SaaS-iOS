//
//  CommonWebView.m
//  APlus
//
//  Created by 苏军朋 on 15/11/9.
//  Copyright (c) 2015年 苏军朋. All rights reserved.
//

#import "CommonWebView.h"

@interface CommonWebView ()
{
    
    __weak IBOutlet UIWebView *_webViewPage;
    
}


@end

@implementation CommonWebView

- (void)viewDidLoad
{
    [super viewDidLoad];
        
    NSString *title = @"帮助中心";
    
    [self setNavTitle:title
       leftButtonItem:[self customBarItemButton:nil
                                backgroundImage:nil
                                     foreground:@"back"
                                            sel:@selector(back)]
      rightButtonItem:nil];
    
    [self initView];
}

- (void)initView
{
    _pageSourceUrl = [_pageSourceUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:_pageSourceUrl]
                                             cachePolicy:NSURLRequestReloadIgnoringCacheData
                                         timeoutInterval:10];
    
    [_webViewPage loadRequest:request];
    [_webViewPage setScalesPageToFit:YES];
    
}

#pragma  mark - <UIWebViewDelegate>

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request
 navigationType:(UIWebViewNavigationType)navigationType
{
    
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideLoadingView];
    
    NSString *errorDesc = [error.userInfo objectForKey:@"NSLocalizedDescription"];
    if (errorDesc && ![errorDesc isEqualToString:@""])
    {
        showMsg(errorDesc);
    }
}

- (void)dealloc
{
    _webViewPage = nil;
}

@end
