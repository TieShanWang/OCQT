//
//  KKSessionManager.h
//  OCQT
//
//  Created by KING_KE on 2016/11/8.
//  Copyright © 2016年 kk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KKSingle.h"

typedef void(^KKConfigureTask)(id<KKSingle>);

/// 网络不可用时的 code
NSString * const KKURLSessionNetWorkUnuseCode;

/// 网络不可用时的提示信息
NSString * const KKURLSessionNetWorkUnuseMessage;

/// 网络请求设置的解析数据路径错误 code
NSString * const KKURLSessionErrorKeyPathCode;

/// GET
NSString * const KKURLSessionMethodGET;

/// POST
NSString * const KKURLSessionMethodPOST;

/**
 *  网络请求的基类
 */
@interface KKURLSessionManager : NSObject

/**
 *  网络请求
 *
 *  @param path       URL path
 *  @param parameters request parameters
 *  @param method     GET or POST
 *  @param keyPath    返回数据解析的路径
 *  @param className  返回数据解析的类
 *  @param configure  配置此次请求任务
 */
+ (void)requestPath:(NSString *)path
         parameters:(NSDictionary *)parameters
             method:(NSString *)method
            keyPath:(NSString *)keyPath
    resultClassName:(NSString *)className
      configureTask:(KKConfigureTask)configure;

@end


@interface KKURLSessionTask : KKSingle

@end