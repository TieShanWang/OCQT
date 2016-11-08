//
//  KKSingle.m
//  OCQT
//
//  Created by KING_KE on 2016/11/8.
//  Copyright © 2016年 kk. All rights reserved.
//

#import "KKSingle.h"

@interface KKSingle()

@property(nonatomic, copy)void (^errors)(id errors);

@property(nonatomic, copy)void (^requesting)(BOOL requesging);

@property(nonatomic, copy)void (^subData)(id value);

@end

@implementation KKSingle

- (void)subErrors:(void (^)(id<KKURLCodeProtocol>))subErrors
{
    self.errors = subErrors;
}

- (void)subRequesting:(void (^)(BOOL))subReqeust
{
    self.requesting = subReqeust;
}

- (void)subData:(void (^)(id))subData
{
    self.subData = subData;
}

- (void)sendErrors:(id)errors
{
    if (self.errors) {
        self.errors(errors);
    }
}

- (void)sendRequesting:(BOOL)isRequesting
{
    if (self.requesting) {
        self.requesting(isRequesting);
    }
}

- (void)sendData:(id)data{
    if (self.subData) {
        self.subData(data);
    }
}

@end
