//
//  TrustTypeEnum.h
//  APlus
//
//  Created by 李慧娟 on 16/8/26.
//  Copyright © 2016年 中原集团. All rights reserved.
//

#ifndef TrustTypeEnum_h
#define TrustTypeEnum_h

/// 房源租售状态
enum TrustTypeEnum{
    SALE = 1,//出售
    RENT = 2,//出租
    BOTH = 3,//租售
    RENTBOTH = 4,//出租 租售
    SALEBOTH = 5,//出售 租售
    ALLBOTH = 6,//全部
};

/// 委托审批状态
enum EntrustStateEnum{
    NOENTRUST = -1,      // 无委托信息
    AUDIT = 0,          // 待审核
    AUDITED = 1,        // 审核通过
    AUDITREJECT = 2,    // 审核拒绝
};

#endif /* TrustTypeEnum_h */
