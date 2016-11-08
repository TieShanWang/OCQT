//
//  KKURLCodeModel.m
//  OCQT
//
//  Created by KING_KE on 2016/11/8.
//  Copyright © 2016年 kk. All rights reserved.
//

#import "KKURLCodeModel.h"

@implementation KKURLCodeModel

+ (instancetype)defaultNetWorkErrorModel
{
    KKURLCodeModel * model = [[KKURLCodeModel alloc]init];
    model.code = KKURLSessionNetWorkUnuseCode;
    model.showMessage = KKURLSessionNetWorkUnuseMessage;
    return model;
}

+ (instancetype)defaultKeyPathErrorModel
{
    KKURLCodeModel * model = [[KKURLCodeModel alloc]init];
    model.code = KKURLSessionErrorKeyPathCode;
    return model;
}

@end
