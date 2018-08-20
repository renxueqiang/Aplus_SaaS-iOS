//
//  ComBaseCell.h
//  FangYouQuan
//
//  Created by sujp on 2017/9/1.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ComActionClickDelegate.h"

@interface ComBaseCell : UITableViewCell

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, assign) id <ComActionClickDelegate> delegate;


///设置cell上的值
- (void)showObject:(NSDictionary *)vObj;

@end
