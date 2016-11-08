//
//  ViewController.m
//  OCQT
//
//  Created by KING_KE on 2016/11/7.
//  Copyright © 2016年 kk. All rights reserved.
//

#import "ViewController.h"

#import "ViewModel.h"

#import "ViewControllerView.h"

@interface ViewController ()

@property(nonatomic, strong)ViewModel * viewModel;

@property(nonatomic, strong)ViewControllerView * viewControllerView;// 名字自定义即可

@end

@implementation ViewController

/// 如果需要参数，如下
+ (instancetype)homeViewControllerWithID:(NSNumber *)ID
{
    // 如果有参数。另行赋值，只供参考
    ViewController * vc = [[ViewController alloc]init];
    vc.viewModel = [[ViewModel alloc]init];
    return vc;
}

- (void)loadView
{
    self.view = self.viewControllerView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self bindViewModel];
}

- (void)commitInitView
{
    
}

- (void)bindViewModel
{
    [self.viewModel subRequesting:^(BOOL requsting) {
        if (requsting) {
            NSLog(@"开始转圈");
        }else{
            NSLog(@"停止转圈");
        }
    }];
    
    [self.viewModel subData:^(id value) {
        // 这里的数据可用 value 或者 self.viewModel.sourceData
        NSLog(@"刷新数据");
    }];
}

-(ViewControllerView *)viewControllerView
{
    if (!_viewControllerView) {
        _viewControllerView = [[ViewControllerView alloc]init];
    }
    return _viewControllerView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
