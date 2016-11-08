//
//  KKBaseViewModel.h
//  OCQT
//
//  Created by KING_KE on 2016/11/7.
//  Copyright © 2016年 kk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KKSingle.h"

/**
 *  viewModel's parent class
 */
@interface KKBaseViewModel : KKSingle

/**
 *  标记是否正在网络请求
 */
@property(nonatomic, assign)BOOL isRequesting;

/**
 *  数据源
 */
@property(nonatomic, strong)NSArray * sourceData;

@end
