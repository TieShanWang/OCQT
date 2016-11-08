//
//  KKBaseViewController.m
//  OCQT
//
//  Created by KING_KE on 2016/11/7.
//  Copyright © 2016年 kk. All rights reserved.
//

#import "KKBaseViewController.h"

extern NSString * const KKURLSessionNetWorkUnuseCode;

extern NSString * const KKURLSessionNetWorkUnuseMessage;

extern NSString * const KKURLSessionErrorKeyPathCode;

@interface KKBaseViewController ()

@property(nonatomic, strong)KKBaseViewModel * viewModel;

@end

@implementation KKBaseViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.viewModel = [[KKBaseViewModel alloc]init];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSAssert(_viewModel, @"请在此方法前设置viewModel");
    [self bindErrors];
}

- (void)bindErrors
{
    [self.viewModel subErrors:^(id<KKURLCodeProtocol> errors) {
        if ([[errors code] isEqualToString:KKURLSessionNetWorkUnuseCode]) {
            [self.view makeHintWithTitle:KKURLSessionNetWorkUnuseMessage identity:KKURLSessionNetWorkUnuseMessage tapIn:YES];
        }else if ([[errors code] isEqualToString:KKURLSessionErrorKeyPathCode]){
            NSLog(@"%@",KKURLSessionErrorKeyPathCode);
        }else{
            [self.view makeHintWithTitle:[errors showMessage] identity:[errors showMessage] tapIn:YES];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
