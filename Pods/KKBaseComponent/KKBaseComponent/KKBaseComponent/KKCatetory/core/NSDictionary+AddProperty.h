//
//  NSDictionary+AddProperty.h
//  KK
//
//  Created by MR.KING on 16/3/1.
//  Copyright © 2016年 KK. All righUI reserved.
//


#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface NSDictionary (AddProperty)

@property(nonatomic,strong)NSString * sendTime;

@property(nonatomic,strong)NSString * rspCode;

@property(nonatomic,strong)NSString * rspMsg;

@property(nonatomic,strong)NSDictionary * data;

@property(nonatomic,strong)NSString * role;

@property(nonatomic,strong)NSArray * roleAcc;

@property(nonatomic,strong)NSString * signType;

@property(nonatomic,strong)NSString * sign;

@property(nonatomic,copy,readonly)NSString * serKey;

@property(nonatomic,assign,readonly)BOOL serKeyUseful;

@property(nonatomic,strong,readonly)NSArray * list;

@end


@interface NSDictionary (KKKey)
- (CGFloat)floatForKey:(NSString *)key;
- (NSNumber *)opacityForKey:(NSString *)key;
- (UIColor *)strokeColorForKey:(NSString *)key;
- (UIColor *)fillColorForKey:(NSString *)key;
- (CGFloat)strokeWeightForKey:(NSString *)key;
- (NSArray *)dashArrayForKey:(NSString *)key;
- (CGLineJoin)lineJoinForKey:(NSString *)key;
- (CGLineCap)lineCapForKey:(NSString *)key;
- (CGFloat)miterLimitForKey:(NSString *)key;
@end