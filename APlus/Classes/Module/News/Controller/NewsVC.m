//
//  NewsViewController.m
//  APlus
//
//  Created by sujp on 2017/9/18.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "NewsVC.h"

@interface NewsVC (){
    
}

@end

@implementation NewsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
    
}

-(void)initView
{
    
    [self setNavTitle:@"消息"
       leftButtonItem:nil
      rightButtonItem:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
