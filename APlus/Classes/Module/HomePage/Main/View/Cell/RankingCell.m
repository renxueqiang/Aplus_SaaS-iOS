//
//  LeftTopCell.m
//  APlus
//
//  Created by 李慧娟 on 2017/10/17.
//  Copyright © 2017年 CentaLine. All rights reserved.
//

#import "RankingCell.h"
#import "DDProgressView.h"

@implementation RankingCell {

    __weak IBOutlet UIButton *_rankLabel;
    __weak IBOutlet UILabel *_agencyName;

    __weak IBOutlet DDProgressView *_performView;

    __weak IBOutlet UILabel *_money;
    

}

- (void)awakeFromNib {
    [super awakeFromNib];

    _performView.progress = 0.5;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

- (void)fillDataWithArray:(NSArray *)dataArr AndRow:(NSInteger)row {
    NSArray *imgArr = @[@"1",@"2",@"3"];
    if (row < 4)
    {
        [_rankLabel setImage:[UIImage imageNamed:imgArr[row - 1]] forState:UIControlStateNormal];
        [_rankLabel setTitle:nil forState:UIControlStateNormal];
    }
    else
    {
        NSString *rowStr = [NSString stringWithFormat:@"%ld",row];
        [_rankLabel setTitle:rowStr forState:UIControlStateNormal];
        [_rankLabel setImage:nil forState:UIControlStateNormal];
    }
}

@end
