//
//  KKBaseViewModel.m
//  OCQT
//
//  Created by KING_KE on 2016/11/7.
//  Copyright © 2016年 kk. All rights reserved.
//

#import "KKBaseViewModel.h"

#import "KKURLSessionManager+Home.h"

@implementation KKBaseViewModel

- (void)subAndSendRequestingFrom:(id<KKSingle>)obj
{
    [obj subRequesting:^(BOOL requsting) {
        self.isRequesting = requsting;
        [self sendRequesting:requsting];
    }];
}

- (void)subAndSendDataFrom:(id<KKSingle>)obj
{
    [obj subData:^(id value) {
        self.sourceData = value;
        [self sendData:value];
    }];
}

@end
