//
//  EstateSelectTypeEnum.h
//  APlus
//
//  Created by 燕文强 on 16/8/20.
//  Copyright © 2016年 苏军朋. All rights reserved.
//

#ifndef EstateSelectTypeEnum_h
#define EstateSelectTypeEnum_h


/// 房源搜索的智能提示查询类型枚举值
enum EstateSelectTypeEnum
{
    /// 行政区 "1"
    EstateSelectTypeEnum_DISTRICTNAME = 1,
    /// 地理片区 "2"
    EstateSelectTypeEnum_REGIONNAME,
    /// 楼盘 "3"
    EstateSelectTypeEnum_ESTATENAME,
    /// 全部 "4"
    EstateSelectTypeEnum_ALLNAME,
    /// 楼栋 "5"
    EstateSelectTypeEnum_BUILDINGBELONG,
    
};

#endif /* EstateSelectTypeEnum_h */
