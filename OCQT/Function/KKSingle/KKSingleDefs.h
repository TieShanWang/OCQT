//
//  KKSingleDefs.h
//  OCQT
//
//  Created by KING_KE on 2016/11/8.
//  Copyright © 2016年 kk. All rights reserved.
//

#ifndef KKSingleDefs_h
#define KKSingleDefs_h


@protocol KKSingle

/**
 *  订阅是否在请求网络
 *
 *  @param subReqeust 请求状态发生变化的回调
 */
- (void)subRequesting:(void(^)(BOOL requsting))subReqeust;

/**
 *  订阅错误
 *
 *  @param subErrors 错误的回调
 */
- (void)subErrors:(void(^)(id<KKURLCodeProtocol> errors))subErrors;

/**
 *  订阅数据
 *
 *  @param subData 数据
 */
- (void)subData:(void(^)(id value))subData;

/**
 *  发送是否在请求网络
 *
 *  @param isRequesting 是否在请求网络
 */
- (void)sendRequesting:(BOOL)isRequesting;

/**
 *  发送网络请求错误
 *
 *  @param errors errors
 */
- (void)sendErrors:(id <KKURLCodeProtocol>)errors;

/**
 *  发送网络数据
 *
 *  @param data <#data description#>
 */
- (void)sendData:(id)data;

@end

#endif /* KKSingleDefs_h */
