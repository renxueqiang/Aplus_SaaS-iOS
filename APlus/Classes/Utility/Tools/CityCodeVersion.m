//
//  CityCodeVersion.m
//  APlus
//
//  Created by 燕文强 on 16/4/12.
//  Copyright © 2016年 苏军朋. All rights reserved.
//

#import "CityCodeVersion.h"

@interface CityCodeVersion ()

@property (nonatomic, copy) NSString *TianJin;
@property (nonatomic, copy) NSString *ShenZhen;
@property (nonatomic, copy) NSString *BeiJing;
@property (nonatomic, copy) NSString *NanJing;
@property (nonatomic, copy) NSString *AoMenHengQin;
@property (nonatomic, copy) NSString *GuangZhou;
@property (nonatomic, copy) NSString *ChongQing;
@property (nonatomic, copy) NSString *ChangSha;
@property (nonatomic, copy) NSString *HangZhou;
@property (nonatomic, copy) NSString *DongGuan;
@property (nonatomic, copy) NSString *HuiZhou;
@property (nonatomic, copy) NSString *WuHan;

@property (nonatomic,strong)NSMutableDictionary *cityDic;

@end


@implementation CityCodeVersion

static CityCodeVersion *_cityCodeVersion;

+ (CityCodeVersion *)lazyLoad
{
    if(!_cityCodeVersion)
    {
        _cityCodeVersion = [[CityCodeVersion alloc]init];
        
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CityCode" ofType:@"plist"];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        
        _cityCodeVersion.cityDic = [dic mutableCopy];
        
        NSArray *arr = [dic allKeys];
        NSInteger count = arr.count;
        for (int i = 0; i < count; i++)
        {
            NSString *itemKey = arr[i];
            [_cityCodeVersion setValue:dic[itemKey] forKeyPath:itemKey];
        }
        
        NSLog(@"******%@*****",_cityCodeVersion.TianJin);
        NSLog(@"******%@*****",_cityCodeVersion.ShenZhen);
        NSLog(@"******%@*****",_cityCodeVersion.BeiJing);
        NSLog(@"******%@*****",_cityCodeVersion.NanJing);
        NSLog(@"******%@*****",_cityCodeVersion.AoMenHengQin);
        NSLog(@"******%@*****",_cityCodeVersion.GuangZhou);
        NSLog(@"******%@*****",_cityCodeVersion.ChongQing);
        NSLog(@"******%@*****",_cityCodeVersion.ChangSha);
        NSLog(@"******%@*****",_cityCodeVersion.HangZhou);
    }
    
    return _cityCodeVersion;
}

+ (BOOL)isTianJin
{
    NSString *cityCode = [self getCurrentCityCode];
    
    if ([[self lazyLoad].TianJin isEqualToString:cityCode])
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isShenZhen
{
    NSString *cityCode = [self getCurrentCityCode];
    
    if ([[self lazyLoad].ShenZhen isEqualToString:cityCode])
    {
        return YES;
    }
    return NO;
}


+ (BOOL)isBeiJing
{
    NSString *cityCode = [self getCurrentCityCode];
    
    if ([[self lazyLoad].BeiJing isEqualToString:cityCode])
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isNanJing
{
    NSString *cityCode = [self getCurrentCityCode];
    
    if ([[self lazyLoad].NanJing isEqualToString:cityCode])
    {
        return YES;
    }
    return NO;
}


+ (BOOL)isAoMenHengQin
{
    
    NSString *cityCode = [self getCurrentCityCode];
    
    if ([[self lazyLoad].AoMenHengQin isEqualToString:cityCode])
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isGuangZhou
{
    NSString *cityCode = [self getCurrentCityCode];
    
    if ([[self lazyLoad].GuangZhou isEqualToString:cityCode])
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isChongQing
{
    NSString *cityCode = [self getCurrentCityCode];
    
    if ([[self lazyLoad].ChongQing isEqualToString:cityCode]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isChangSha
{
    NSString *cityCode = [self getCurrentCityCode];
    
    if ([[self lazyLoad].ChangSha isEqualToString:cityCode])
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isHangZhou
{
    NSString *cityCode = [self getCurrentCityCode];

    if ([[self lazyLoad].HangZhou isEqualToString:cityCode])
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isDongGuan
{
    NSString *cityCode = [self getCurrentCityCode];
    
    if ([[self lazyLoad].DongGuan isEqualToString:cityCode])
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isHuiZhou
{
    NSString *cityCode = [self getCurrentCityCode];
    
    if ([[self lazyLoad].HuiZhou isEqualToString:cityCode])
    {
        return YES;
    }
    return NO;
}

+ (BOOL)isWuHan
{
    NSString *cityCode = [self getCurrentCityCode];

    if ([[self lazyLoad].WuHan isEqualToString:cityCode])
    {
        return YES;
    }

    return NO;
}

+ (NSString *)getCurrentCityCode
{
    NSString *cityCode = [[NSUserDefaults standardUserDefaults] objectForKey:CityCode];
    return cityCode;
}

+ (NSString *)getCurrentCityName
{
    NSString *cityName;
    NSString *cityCode = [[NSUserDefaults standardUserDefaults] objectForKey:CityCode];
    
    NSArray *arr = [[self lazyLoad].cityDic allKeys];
    NSInteger arrCount = arr.count;
    for (int i = 0; i < arrCount; i++)
    {
        NSString *itemKey = arr[i];
        NSString *itemValue = [self lazyLoad].cityDic[itemKey];
        if ([cityCode isEqualToString:itemValue])
        {
            cityName = itemKey;
            break;
        }
    }
    
    return cityName;
}

@end
