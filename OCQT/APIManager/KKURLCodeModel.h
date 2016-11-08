//
//  KKURLCodeModel.h
//  OCQT
//
//  Created by KING_KE on 2016/11/8.
//  Copyright © 2016年 kk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KKURLSessionDefs.h"

extern NSString * const KKURLSessionNetWorkUnuseCode;

extern NSString * const KKURLSessionNetWorkUnuseMessage;

extern NSString * const KKURLSessionErrorKeyPathCode;

@interface KKURLCodeModel : NSObject<KKURLCodeProtocol>

@property(nonatomic, copy)NSString * code;

@property(nonatomic, copy)NSString * showMessage;

+ (instancetype)defaultNetWorkErrorModel;

+ (instancetype)defaultKeyPathErrorModel;

@end
