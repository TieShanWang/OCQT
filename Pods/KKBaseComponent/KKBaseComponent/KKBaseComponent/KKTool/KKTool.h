//
//  TSTool.h
//  PZJ
//
//  Created by MR.KING on 16/5/3.
//  Copyright © 2016年 KK. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface KKTool : NSObject
// 将时间差 转换为分秒
+(nonnull NSString*)transTimeIntervalString:(NSTimeInterval)timeInterval;

@end

NS_ASSUME_NONNULL_END
