//
//  WSRootTabBarController.m
//  OCQT
//
//  Created by KING_KE on 2016/11/8.
//  Copyright © 2016年 kk. All rights reserved.
//

#import "WSRootTabBarController.h"

@interface WSRootTabBarController ()

@end

@implementation WSRootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end


@implementation WSRootNavigationView

+ (instancetype)defaultSelectedIndex:(NSUInteger)index
{
    
}

- (instancetype)initWithFrame:(CGRect)frame defSelectedIndex:(NSUInteger)index
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)commitInitViewWithIndex:(NSUInteger)index
{
    for (int i = 0; i < 3; i ++) {
        UIButton * btn = [self defaultBtn];
        btn.tag = i + 10;
    }
}

- (void)selectedItem:(UIButton*)sender
{
    
}

- (UIButton *)defaultBtn
{
    UIButton * btn = [KKFactory createButtonFrame:CGRectZero targat:self sel:@selector(selectedItem:)];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn setTitleColor:RGBACOLOR(1, 1, 1, 0.5) forState:UIControlStateNormal];
    return btn;
}

@end