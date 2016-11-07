//
//  UIApplication+KKMethod.h
//  KKTool
//
//  Created by KING on 2016/10/8.
//  Copyright © 2016年 com.KK. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (KKMethod)


/*====================================================
 ==                                                 ==
 ==                open other app                   ==
 ==                                                 ==
 ===================================================*/


/**
 *  open system web browser : 打开系统的浏览器
 *
 *  @param URL URL
 *
 *  @return can open URL
 */
+ (BOOL)openSystemWebBrowserWithURL:(nonnull NSString*)URL;

/*====================================================
 ==                                                 ==
 ==                      value                      ==
 ==                                                 ==
 ===================================================*/

/**
 *  According app run state to set values
 *
 *  @param debug    debug
 *  @param release release
 *
 *  @return id
 */
+ (nullable id)appRunDebug:(nullable id)debug release:(nullable id)release;


/**
 *  According app run state to set values
 *
 *  @param debug    debug
 *  @param release release
 *
 *  @return CGFloat
 */
+ (CGFloat)fAppRunDebug:(CGFloat)debug release:(CGFloat)release;



/*====================================================
 ==                                                 ==
 ==                      version                    ==
 ==                                                 ==
 ===================================================*/
/**
 *  To judge whether an updated version Now / 判断是否更新版本后第一次调用此方法
 *
 *  @return new version
 */
+ (BOOL)isAfterUpdataVersion;

/**
 *  save current version to sandbox / 保存当前版本号到沙盒
 */
+(void)saveCurrentSystemVersion;

/**
 *  get current app version
 *
 *  @return app version
 */
+ (nonnull NSString *)getAppVersion;


/*====================================================
 ==                                                 ==
 ==                      languag                    ==
 ==                                                 ==
 ===================================================*/
/**
 *  app 支持的所有语言
 */
+(nonnull NSArray*)appSupportLanguages;

/**
 *  app 当前的额语言
 */
+(nonnull NSString*)appLanguage;

/**
 *  is chinese / 是否是汉语
 *
 *  @return isChinese
 */
+ (BOOL)languageCH;
@end
