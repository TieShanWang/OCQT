//
//  KKSingle.h
//  OCQT
//
//  Created by KING_KE on 2016/11/8.
//  Copyright © 2016年 kk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KKURLSessionDefs.h"

#import "KKSingleDefs.h"

@interface KKSingle : NSObject<KKSingle>

- (void)subAndSendErrorsFrom:(id<KKSingle>)obj;

- (void)subAndSendRequestingFrom:(id<KKSingle>)obj;

- (void)subAndSendDataFrom:(id<KKSingle>)obj;

@end
