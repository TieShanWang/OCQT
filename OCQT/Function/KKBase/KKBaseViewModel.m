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

- (void)getData
{
    [KKURLSessionManager requestHomeList:^(id<KKSingle>task) {
        [self subAndSendErrorsFrom:task];
    }];
}

@end
