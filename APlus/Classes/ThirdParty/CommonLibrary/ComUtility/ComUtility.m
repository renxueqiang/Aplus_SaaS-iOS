//
//  ComUtility.m
//  FangYouQuan
//
//  Created by sujp on 2017/9/6.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "ComUtility.h"

@implementation ComUtility

#pragma mark - 数据驱动

/// 获取当前list中所有有效的cell（去除隐藏的cell）
+ (NSMutableArray *)getAllValidCellWithData:(NSDictionary *)vObj
{
    // 所有返回的布局数据
    NSMutableArray *allFields = [NSMutableArray new];
    allFields = [[vObj objectForKey:@"content"] objectForKey:@"Fields"];
    
    // 所有有效的布局
    NSMutableArray *validFields = [NSMutableArray new];

    for (int i = 0; i < allFields.count; i++)
    {
        NSDictionary *fieldItem = allFields[i];
        
        NSString *dtValue = [fieldItem objectForKey:@"dt"];
        
        if (dtValue &&
            ![dtValue isEqualToString:@""] &&
            ![dtValue isEqualToString:@"hd"])
        {
            [validFields addObject:allFields[i]];
        }
    }
    
    return validFields;
}

+ (ComBaseCell*)getCommonCell:(UITableView*)tableView
                 andIndexPath:(NSIndexPath*)indexPath
                  andDelegate:(id)delegate
                andDataSource:(NSMutableArray*)dataSource
{
    NSString *cellIdentifier = nil;
    NSString *cellNibName = nil;
    NSString *dtValue = nil;
    
    NSDictionary *fieldObj = dataSource[indexPath.row];
    
    dtValue = [fieldObj objectForKey:@"dt"];
    
    if ([dtValue isEqualToString:@"gp"]) {
        //组
        
    }else if ([dtValue isEqualToString:@"gm"]){
        //组，可点击到下级页面
        
    }else if ([dtValue isEqualToString:@"gs"]){
        //分割线（v1为高度）
        
    }else if ([dtValue isEqualToString:@"l"]){
        //文本（不可编辑）
        
    }else if ([dtValue isEqualToString:@"lt"]){
        //可显示两列的文本
        
    }else if ([dtValue isEqualToString:@"pwd"]){
        //密码
        
    }else if ([dtValue isEqualToString:@"t"]){
        //可输入的文本
        
        cellIdentifier = @"comTextCell";
        cellNibName = @"ComTextCell";
        
    }else if ([dtValue isEqualToString:@"mt"]){
        //可输入的文本（多行）
        
    }else if ([dtValue isEqualToString:@"mt2"]){
        //可输入的文本（可自定义高度，fd2为高度）
        cellIdentifier = @"comSingleChoiceCell";
        cellNibName = @"ComSingleChoiceCell";
        
    }else if ([dtValue isEqualToString:@"i"]){
        //数字
        
    }else if ([dtValue isEqualToString:@"iTi"]){
        //数字区间
        
    }else if ([dtValue isEqualToString:@"d"]){
        //日期
        
    }else if ([dtValue isEqualToString:@"dt"]){
        //日期+时间
        
    }else if ([dtValue isEqualToString:@"dTd"]){
        //日期区间
        
    }else if ([dtValue isEqualToString:@"so"]){
        //单选
        
        cellIdentifier = @"comSingleChoiceCell";
        cellNibName = @"ComSingleChoiceCell";
        
    }else if ([dtValue isEqualToString:@"sos"]){
        //单选搜索
        
    }else if ([dtValue isEqualToString:@"soe"]){
        //单选可输入（比如：利率）
        
    }else if ([dtValue isEqualToString:@"sex"]){
        //性别
        
    }else if ([dtValue isEqualToString:@"yn"]){
        //是与否
        
    }else if ([dtValue isEqualToString:@"seg"]){
        //分段按钮
        
    }else if ([dtValue isEqualToString:@"btn"]){
        //按钮
        
    }else if ([dtValue isEqualToString:@"tags"]){
        //标签类型，可删除（v2为1的时候才能新增）
        
    }else if ([dtValue isEqualToString:@"photo"]){
        //附件图片
        cellIdentifier = @"comSingleChoiceCell";
        cellNibName = @"ComSingleChoiceCell";
        
    }else if ([dtValue isEqualToString:@"itb"]){
        //图片工具控件
        
    }
    
    ComBaseCell *fieldCell = (ComBaseCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!fieldCell) {
        
        [tableView registerNib:[UINib nibWithNibName:cellNibName
                                              bundle:nil]
        forCellReuseIdentifier:cellIdentifier];
        
        fieldCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
        
    }
    
    [fieldCell showObject:fieldObj];
    fieldCell.indexPath = indexPath;
    fieldCell.delegate = delegate;
    
    return fieldCell;
    
}


///获取fields中自定义cell的高度
+(CGFloat)getCommonCellHeightWithData:(NSMutableArray *)dataSource
                         andIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *dtValue = nil;
    CGFloat comCellHeight = 0;
    
    
    NSDictionary *fieldObj = dataSource[indexPath.row];
    
    dtValue = [fieldObj objectForKey:@"dt"];
    
    
    if ([dtValue isEqualToString:@"gp"]) {
        //组
        
    }else if ([dtValue isEqualToString:@"gm"]){
        //组，可点击到下级页面
        
    }else if ([dtValue isEqualToString:@"gs"]){
        //分割线（v1为高度）
        
    }else if ([dtValue isEqualToString:@"l"]){
        //文本（不可编辑）
        
    }else if ([dtValue isEqualToString:@"lt"]){
        //可显示两列的文本
        
    }else if ([dtValue isEqualToString:@"pwd"]){
        //密码
        
    }else if ([dtValue isEqualToString:@"t"]){
        //可输入的文本
        
    }else if ([dtValue isEqualToString:@"mt"]){
        //可输入的文本（多行）
        
    }else if ([dtValue isEqualToString:@"mt2"]){
        //可输入的文本（可自定义高度，fd2为高度）
        
        
        
    }else if ([dtValue isEqualToString:@"i"]){
        //数字
        
    }else if ([dtValue isEqualToString:@"iTi"]){
        //数字区间
        
    }else if ([dtValue isEqualToString:@"d"]){
        //日期
        
    }else if ([dtValue isEqualToString:@"dt"]){
        //日期+时间
        
    }else if ([dtValue isEqualToString:@"dTd"]){
        //日期区间
        
    }else if ([dtValue isEqualToString:@"so"]){
        //单选
        
    }else if ([dtValue isEqualToString:@"sos"]){
        //单选搜索
        
    }else if ([dtValue isEqualToString:@"soe"]){
        //单选可输入（比如：利率）
        
    }else if ([dtValue isEqualToString:@"sex"]){
        //性别
        
    }else if ([dtValue isEqualToString:@"yn"]){
        //是与否
        
    }else if ([dtValue isEqualToString:@"seg"]){
        //分段按钮
        
    }else if ([dtValue isEqualToString:@"btn"]){
        //按钮
        
    }else if ([dtValue isEqualToString:@"tags"]){
        //标签类型，可删除（v2为1的时候才能新增）
        
    }else if ([dtValue isEqualToString:@"photo"]){
        //附件图片
        
    }else if ([dtValue isEqualToString:@"itb"]){
        //图片工具控件
        
    }else{
        
        comCellHeight = 44.0;
    }

    
    
    return comCellHeight;
    
}



@end
