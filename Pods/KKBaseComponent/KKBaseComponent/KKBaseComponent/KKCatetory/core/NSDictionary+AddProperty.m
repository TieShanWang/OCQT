//
//  NSDictionary+AddProperty.m
//  KK
//
//  Created by MR.KING on 16/3/1.
//  Copyright © 2016年 KK. All righUI reserved.
//


#import "NSDictionary+AddProperty.h"
#import <objc/runtime.h>

#import "UIColor+KKMethod.h"

@implementation NSDictionary (AddProperty)

@dynamic  sendTime;
@dynamic  rspCode;
@dynamic  rspMsg;
@dynamic  data;
@dynamic  role;
@dynamic  signType;
@dynamic  sign;
@dynamic roleAcc;

-(NSString *)sendTime{
    return  [self objectForKey:@"sendTime"];
}

-(NSString *)rspCode{
    return  [self objectForKey:@"rspCode"];
}

-(NSString *)rspMsg{
    if ([[self objectForKey:@"rspMsg"] length] == 0) {
           return @"未知错误";
    }else{
        return [self objectForKey:@"rspMsg"];
    }
}

-(NSArray*)list{
    NSArray * arr = [self objectForKey:@"list"];
    return arr;
}

-(NSDictionary *)data{
    NSData * data = [[self objectForKey:@"data"] dataUsingEncoding:NSUTF8StringEncoding];
    if ([data isKindOfClass:[NSData class]]) {
        return [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    }else if ([data isKindOfClass:[NSDictionary class]]){
        return (NSDictionary*)data;
    }
    return (NSDictionary*)data;
}

-(BOOL)serKeyUseful{
    NSAssert(1, @"需要重写serKeyUserful");
    return NO;
}

-(NSString * )serKey{
    return [self objectForKey:@"serKey"];
}

-(NSString *)role{
    return  [self objectForKey:@"role"];
}

-(NSString *)signType{
    return  [self objectForKey:@"signType"];;
}

-(NSString *)sign{
    return  [self objectForKey:@"sign"];
}

-(NSString *)roleAcc{
    return  [self objectForKey:@"roleAcc"];;
}


@end


@implementation NSDictionary (KKKey)


- (CGFloat)floatForKey:(NSString *)key;
{
    return self[key] ? [self[key] floatValue] : 0.f;
}

- (NSNumber *)opacityForKey:(NSString *)key
{
    return self[key] ? @([self[key] floatValue]) : nil;
}

- (UIColor *)strokeColorForKey:(NSString *)key;
{
    return [UIColor kk_colorFromHexString:self[key]];
}

- (UIColor *)fillColorForKey:(NSString *)key;
{
    return [UIColor kk_colorFromHexString:self[key] ?: @"#000000"];
}

- (NSArray *)dashArrayForKey:(NSString *)key;
{
    NSMutableArray *floatValues = NSMutableArray.new;
    for (NSString *value in [self[key] componentsSeparatedByString:@","]) {
        [floatValues addObject:@(value.floatValue)];
    }
    return floatValues.count == 0 ? nil : floatValues.copy;
}

- (CGFloat)strokeWeightForKey:(NSString *)key;
{
    return self[key] ? [self[key] floatValue] : 1.f;
}

- (CGLineJoin)lineJoinForKey:(NSString *)key;
{
    return [self[key] isEqualToString:@"round"] ? kCGLineJoinRound : [self[key] isEqualToString:@"square"] ? kCGLineJoinBevel : kCGLineJoinMiter;
}

- (CGLineCap)lineCapForKey:(NSString *)key;
{
    return [self[key] isEqualToString:@"round"] ? kCGLineCapRound : [self[key] isEqualToString:@"square"] ? kCGLineCapSquare : kCGLineCapButt;
}

- (CGFloat)miterLimitForKey:(NSString *)key;
{
    return self[key] ? [self[key] floatValue] : 10.f;
}

@end
