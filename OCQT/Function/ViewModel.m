//
//  ViewModel.m
//  OCQT
//
//  Created by KING_KE on 2016/11/8.
//  Copyright © 2016年 kk. All rights reserved.
//

#import "ViewModel.h"

#import "KKURLSessionManager+Home.h"

@implementation ViewModel

/**
 *  获取网络数据
 */
- (void)getData
{
    [KKURLSessionManager requestHomeList:^(id<KKSingle>task) {
        [self subAndSendRequestingFrom:task];
        [self subAndSendErrorsFrom:task];
        [self subAndSendDataFrom:task];
    }];
}

@end
