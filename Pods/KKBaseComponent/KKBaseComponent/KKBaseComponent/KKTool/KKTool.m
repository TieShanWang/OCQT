//
//  TSTool.m
//  PZJ
//
//  Created by MR.KING on 16/5/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import "KKTool.h"

@implementation KKTool
// 将时间差 转换为分秒
+(NSString*)transTimeIntervalString:(NSTimeInterval)timeInterval{
    NSInteger minutes = timeInterval/60;
    NSInteger seconds = (NSInteger)timeInterval%60;
    return [NSString stringWithFormat:@"距离可以解锁时间还有%2.2ld分 %2.2ld秒",minutes,seconds];
}


@end
