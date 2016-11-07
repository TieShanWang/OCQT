//
//  NSBundle+KKMethod.h
//  KKBaseComponent
//
//  Created by KING on 2016/10/9.
//  Copyright © 2016年 King. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSBundle (KKMethod)

/**
 *  get bundle by name
 *
 *  @param name bundle name
 *
 *  @return NSBundle
 */
+ (nullable NSBundle *)bundleWithName:(NSString *)name;

/**
 *  get plist path by bundleName and file name
 *
 *  @param bundleName bundle name
 *
 *  @param name       plist file name
 *
 *  @return plist path
 */
+ (nullable NSString*)plistPathWithBundleName:(NSString *)bundleName byName:(NSString *)name;

/**
 *  get plist path in mainBundle
 *
 *  @param name plist file name
 *
 *  @return plist path
 */
+ (nullable NSString*)plistPathInMainBundleByName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END