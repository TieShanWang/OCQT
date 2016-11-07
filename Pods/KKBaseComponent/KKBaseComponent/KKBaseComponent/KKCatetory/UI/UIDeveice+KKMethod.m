//
//  KKDevice.m
//  KKTool
//
//  Created by KING on 2016/10/8.
//  Copyright © 2016年 com.KK. All rights reserved.
//

#import "UIDeveice+KKMethod.h"

#import "KKMacro.h"

NSString * const UIDeviceModel4 = @"UIDeviceModel_4/4s";
NSString * const UIDeviceModel5 = @"UIDeviceModel_5/5s/SE";
NSString * const UIDeviceModel6 = @"UIDeviceModel_6/6s";
NSString * const UIDeviceModelPlus = @"UIDeviceModel_plus";
NSString * const UIDeviceModelUNKnow = @"UIDeviceModel_UN_Know";

@implementation UIDevice (KKMethod)

+(id)deviceIs4:(id)I4 Is5:(id)I5 Is6:(id)I6 IsPlus:(id)plus{
    NSString * iphone = [self deviceModel];
    return [iphone isEqualToString:UIDeviceModel4]?I4:
    [iphone isEqualToString:UIDeviceModel5]?I5:
    [iphone isEqualToString:UIDeviceModel6]?I6:
    UIDeviceModelPlus;
}

+(CGFloat)fDeviceIs4:(CGFloat)I4 Is5:(CGFloat)I5 Is6:(CGFloat)I6 IsPlus:(CGFloat)plus{
    NSString * iphone = [self deviceModel];
    return [iphone isEqualToString:UIDeviceModel4]?I4:
    [iphone isEqualToString:UIDeviceModel5]?I5:
    [iphone isEqualToString:UIDeviceModel6]?I6:
    0.0f;
}

+(NSString*)deviceModel{
    if (KScreenWidth == 320) {
        if (KScreenHeight == 480) {
            return UIDeviceModel4;
        }else{
            return UIDeviceModel5;
        }
    }else if (KScreenWidth == 375){
        return UIDeviceModel6;
    }else if (KScreenWidth >= 414){
        return UIDeviceModelPlus;
    }
#ifdef DEBUG
    NSException * exception = [NSException exceptionWithName:@"com.KK.Exception" reason:@"please check UIDevice+KKMethod -> deviceModel" userInfo:nil];
    [exception raise];
#else
    return UIDeviceModelUNKnow;
#endif
    return UIDeviceModelUNKnow;
}



/*
 *获取iOS版本号系统版本号
 */
+ (double)getSystemVersion {
    return [[[UIDevice currentDevice] systemVersion] doubleValue];
}

//获取系统名字
+ (NSString *)GetSystemName
{
    return [UIDevice currentDevice].systemName ;
}
@end
