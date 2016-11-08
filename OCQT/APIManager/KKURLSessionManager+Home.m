//
//  KKURLSessionManager+Home.m
//  OCQT
//
//  Created by KING_KE on 2016/11/8.
//  Copyright © 2016年 kk. All rights reserved.
//

#import "KKURLSessionManager+Home.h"

@implementation KKURLSessionManager (Home)

+ (void)requestHomeList:(KKConfigureTask)configureTask
{
    [self requestPath:@"home/list" parameters:@{} method:KKURLSessionMethodGET keyPath:@"list" resultClassName:@"" configureTask:configureTask];
}

@end
