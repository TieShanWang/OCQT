//
//  KKBaseModel.m
//  KKQT
//
//  Created by KING on 2016/10/7.
//  Copyright © 2016年 King. All rights reserved.
//

#import "KKBaseModel.h"

#import "MJExtension.h"

@implementation KKBaseModel

#if DEBUG
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSAssert(1, @"KKError : set %@ for undefinedKey: %@",self,key);
}
#else
-(void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}
#endif


+ (id)modelWithData:(id)data{
    if ([data isKindOfClass:[NSString class]] || [data isKindOfClass:[NSData class]]) {
        return [self modelWithData:[data mj_JSONObject]];
    }else if ([data isKindOfClass:[NSArray class]]){
        return [[self class] mj_keyValuesArrayWithObjectArray:data];
    }else if ([data isKindOfClass:[NSDictionary class]]){
        return [[self class] mj_objectWithKeyValues:data];
    }
    return nil;
}

-(id)copy{
    return [self mutableCopy];
}

-(id)mutableCopy{
    NSMutableArray * tmpProperty = [[NSMutableArray alloc]init];
    id model = [[[self class] alloc]init];
    Class class ;
    for (class = [self class]; [class superclass] && ([class superclass] != [NSObject class]) ; class = [class superclass]) {
        [tmpProperty addObjectsFromArray:[self getPropertysWithClass:class]];
    }
    for (NSString * name in tmpProperty) {
        [model setValue:[self valueForKey:name] forKey:name];
    }
    
    return model;
}

-(NSArray*)getPropertysWithClass:(Class)className{
    NSMutableArray * tmpProperty = [[NSMutableArray alloc]init];
    unsigned int count,i;
    Ivar * propertys = class_copyIvarList(className, &count);
    for (i = 0; i < count; i++) {
        Ivar preperty = propertys[i];
        NSString * name = [[NSString alloc]initWithCString:ivar_getName(preperty) encoding:NSUTF8StringEncoding];
        [tmpProperty addObject:name];
    }
    free(propertys);
    return tmpProperty;
}


@end
