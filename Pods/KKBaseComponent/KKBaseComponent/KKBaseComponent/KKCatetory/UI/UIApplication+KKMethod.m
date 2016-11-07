//
//  UIApplication+KKMethod.m
//  KKTool
//
//  Created by KING on 2016/10/8.
//  Copyright © 2016年 com.KK. All rights reserved.
//

#import "UIApplication+KKMethod.h"

#import "NSString+KKMethod.h"

#import "NSString+KKCheckValid.h"

@implementation UIApplication (KKMethod)


+(BOOL)openSystemWebBrowserWithURL:(NSString *)URL{
    if (!URL || ([URL isKk_Empty])) {
        return NO;
    }
    NSURL * url = [NSURL URLWithString:URL];
    return [[self sharedApplication]openURL:url];
}


/***=====================================
 ===               value              ===
 ***===================================*/
+ (id)appRunDebug:(id)debug release:(id)release{
#ifdef DEBUG
    return debug;
#else
    return release;
#endif
}

+ (CGFloat)fAppRunDebug:(CGFloat)debug release:(CGFloat)release{
#ifdef DEBUG
    return debug;
#else
    return release;
#endif
}



/***=====================================
 ===          app version             ===
 ***===================================*/
// 是否是更新版本之后做的事情
+ (BOOL)isAfterUpdataVersion{
    
    NSString *key = (NSString *)kCFBundleVersionKey;
    
    // 1.从Info.plist中取出版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    
    // 2.从沙盒中取出上次存储的版本号
    NSString *saveVersion = [self valueForKey:key];
    
    if ([version isEqualToString:saveVersion]) {
        
        return NO;
        
    }else{// 版本号不一样：第一次使用新版本
        [self saveCurrentSystemVersion];
        return YES;
    }
}

+ (void)saveCurrentSystemVersion{
    NSString *key = (NSString *)kCFBundleVersionKey;
    
    // 1.从Info.plist中取出版本号
    NSString *version = [NSBundle mainBundle].infoDictionary[key];
    
    // 存储当前最新版本号
    [self setValue:version forKey:key];
}

/*获取程序版本号*/
+ (NSString *)getAppVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
}



/***=====================================
 ===              language            ===
 ***===================================*/
+ (NSArray *)appSupportLanguages{
    NSUserDefaults *defaults = [ NSUserDefaults standardUserDefaults ];
    // 取得 iPhone 支持的所有语言设置
    return [defaults objectForKey : @"AppleLanguages" ];
}

+ (NSString *)appLanguage{
    NSArray *languages = [NSLocale preferredLanguages];
    return [languages objectAtIndex:0];
}

+ (BOOL)languageCH{
    return [[self appLanguage] kk_ctStr:@"CH"];
}


@end
