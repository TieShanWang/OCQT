//
//  KKDevice.h
//  KKTool
//
//  Created by KING on 2016/10/8.
//  Copyright © 2016年 com.KK. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

extern NSString * const UIDeviceModel4;
extern NSString * const UIDeviceModel5;
extern NSString * const UIDeviceModel6;
extern NSString * const UIDeviceModelPlus;
extern NSString * const UIDeviceModelUNKnow;

@interface UIDevice(KKMethod)

/**
 *  根据设备型号设置不同值 / According to equipment model set different values
 *
 *  @param I4   iphone 4 or 4s
 *  @param I5   iphone 5 or 5s or SE
 *  @param I6   iphone 6 or 6s
 *  @param plus iphone *plus
 *
 *  @return id
 */
+(nullable id)deviceIs4:(id)I4 Is5:(id)I5 Is6:(id)I6 IsPlus:(id)plus;

/**
 *  根据设备型号设置不同值 / According to equipment model set different values
 *
 *  @param I4   iphone 4 or 4s
 *  @param I5   iphone 5 or 5s or SE
 *  @param I6   iphone 6 or 6s
 *  @param plus iphone *plus
 *
 *  @return CGFloat
 */
+(CGFloat)fDeviceIs4:(CGFloat)I4 Is5:(CGFloat)I5 Is6:(CGFloat)I6 IsPlus:(CGFloat)plus;

/**
 *  返回当前设备的型号 / Returns the current device models
 *
 *  @return device model
 */
+(NSString*)deviceModel;


/*
 * 获取手机系统版本号
 */
+ (double)getSystemVersion;


/**
 *  获取系统名称
 *
 *  @return system name eg : ios
 */
+ (NSString *)GetSystemName;
@end

NS_ASSUME_NONNULL_END