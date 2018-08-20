//
//  ComActionClickDelegate.h
//  FangYouQuan
//
//  Created by sujp on 2017/9/6.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol ComActionClickDelegate <NSObject>

///cell中点击回调的代理方法
- (void)actionClickFinished:(id)sender
               andIndexPath:(NSIndexPath *)indexPath
            andActionResult:(NSDictionary *)vComFields;

@end
