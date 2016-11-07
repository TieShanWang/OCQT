//
//  KKBaseModel.h
//  KKQT
//
//  Created by KING on 2016/10/7.
//  Copyright © 2016年 King. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface KKBaseModel : NSObject

/**
 *  根据 data 生成模型
 *
 *  @param data can be NSArray,NSData,NSString,NSDictionary
 *
 *  @return can be instance, NSArray
 */
+ (id)modelWithData:(id)data;

@end
