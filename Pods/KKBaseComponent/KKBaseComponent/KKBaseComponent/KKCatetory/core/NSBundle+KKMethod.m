//
//  NSBundle+KKMethod.m
//  KKBaseComponent
//
//  Created by KING on 2016/10/9.
//  Copyright © 2016年 King. All rights reserved.
//

#import "NSBundle+KKMethod.h"

@implementation NSBundle (KKMethod)


+ (nullable NSBundle *)bundleWithName:(NSString *)name{
    if (!name) {
        return nil;
    }
    NSString * path = [[NSBundle mainBundle] pathForResource:name ofType:@"bundle"];
    NSBundle * bundle = [NSBundle bundleWithPath:path];
    if (bundle && bundle.isLoaded) {
        return bundle;
    }
    return nil;
}


+(nullable NSString*)plistPathWithBundleName:(NSString *)bundleName byName:(NSString *)name{
    if (!bundleName || !name) {
        return nil;
    }
    return [[self bundleWithName:bundleName] pathForResource:name ofType:@"plist"];
}

+(NSString*)plistPathInMainBundleByName:(NSString *)name{
    return [[NSBundle mainBundle]pathForResource:name ofType:@"plist"];
}

@end
