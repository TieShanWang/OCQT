//
//  WSRoute.h
//  OCQT
//
//  Created by KING_KE on 2016/11/8.
//  Copyright © 2016年 kk. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "KKBaseViewController.h"

@interface WSRoute : NSObject

/**
 *  获取 home VC
 *
 *  @param ID 参数
 *
 *  @return ViewController
 */
+ (KKBaseViewController *)homeViewControllerWithID:(NSNumber *)ID; // 参数是否需要根据情况而定

@end
