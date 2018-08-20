//
//  EditorModuleView.h
//  APlus
//
//  Created by 李慧娟 on 2017/10/20.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomGrid.h"

#define MAX_COUNT   12  // 最大模块个数
#define EMPTY_ID    0   // 空格的ID

@protocol EditorModuleProtocal<NSObject>

- (void)finishedRemoveGrid;
- (void)finishedAddGrid;
- (void)finishedMoveGrid;

@end

@interface EditModuleView : UIView<CustomGridDelegate>

@property (nonatomic, weak) id <EditorModuleProtocal> delegate;

- (void)creatViewWithTitleArr:(NSMutableArray *)titleArr
                   WithImgArr:(NSMutableArray *)imgArr
                    WithIdArr:(NSMutableArray *)idArr;

- (void)addBoxActionWithIsEmpty:(BOOL)isEmpty
                    WithDataDic:(NSDictionary *)addGridDic;
@end
