//
//  FilterMoreDetailView.h
//  APlusFilterView
//
//  Created by 张旺 on 2017/10/25.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APFilterView.h"

@interface FilterMoreDetailView : UIView

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *buttonBottomConstant;      // 适配iPhone X

- (void)setDataSourceArray:(NSMutableArray *)dataSourceArray
      estateFilterListType:(FilterType)estateFilterListType;

@end
