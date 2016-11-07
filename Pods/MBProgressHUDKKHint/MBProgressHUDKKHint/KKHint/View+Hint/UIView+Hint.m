//
//  UIView+Hint.m
//  HudDemo
//
//  Created by MR.KING on 16/4/4.
//  Copyright © 2016年 Matej Bukovinski. All rights reserved.
//

#import "UIView+Hint.h"

#import "MBHudHelper.h"

#import "MBProgressHUD.h"

#import <objc/runtime.h>

#define HintKscreenWidth [UIScreen mainScreen].bounds.size.width
#define HintKscreenHeight [UIScreen mainScreen].bounds.size.height



@interface MBProgressHUD (KK_view_Identity)
@property(nonatomic,copy)NSString * kk_view_identity;//标记身份
@end

@implementation MBProgressHUD (KK_view_Identity)

-(void)setKk_view_identity:(NSString *)kk_view_identity{
    objc_setAssociatedObject(self, @"kk_view_identity", kk_view_identity, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)kk_view_identity{
    return objc_getAssociatedObject(self, @"kk_view_identity");
}

@end

@implementation UIView (Hint)



/*********************活动指示器 指示*********************/

/**
 *  展示指示器
 *  默认不可穿透点击
 */
-(void)makeActivity{
    [self makeActivityWithTitle:nil];
}


/**
 *  展示指示器
 *  默认不可穿透点击
 *  自定义 展示时间
 *  @param title title
 */
-(void)makeActivityWithTitle:(NSString*)title{
    [self makeActivityWithTitle:title tapIn:NO];
}



/**
 *  展示指示器
 *  自定义 展示时间
 *  默认 自定义 穿透点击
 *  @param title title
 */
-(void)makeActivityWithTitle:(NSString*)title tapIn:(BOOL)tapIn{
    [MBHudHelper makeActivityWithTitle:title view:self tapIn:tapIn];
}

-(void)hiddenActivity{
    [MBProgressHUD hideHUDForView:self animated:YES];
}







/*********************blow navibar*********************/

-(void)makeHintBlowNavigationBarWithTitle:(NSString *)title{
    [self makeHintBlowNavigationBarWithTitle:title durtion:1.7f];
}

-(void)makeHintBlowNavigationBarWithTitle:(NSString*)title durtion:(NSTimeInterval)durtion{
    CGFloat kscreenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat viewHeight = [UIView iphoneIs4:33 is5:40 is6:44 isPlus:44];
    CGFloat padToSide = 10;
    
    // 最下面的view
    UIView * baseView = [[UIView alloc]init];
    baseView.layer.masksToBounds = YES;
    baseView.frame = CGRectMake(0, (self.bounds.size.height == HintKscreenHeight)?64:0, HintKscreenWidth, viewHeight);
    
    
    // 放置 文字的 底层view
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(padToSide,-viewHeight, kscreenWidth - 2 *padToSide, viewHeight)];
    view.tag = 999;
    view.backgroundColor = [UIColor blackColor];
    view.layer.masksToBounds = YES;
    view.layer.cornerRadius = 2;
    CGFloat rgb = 0.05;
    view.backgroundColor = [UIColor colorWithRed:rgb green:rgb blue:rgb alpha:0.7];
    
    // 文字
    UILabel* lable = [[UILabel alloc]init];
    lable.bounds = CGRectMake(0, 0, view.bounds.size.width, view.bounds.size.height);
    lable.center = CGPointMake(view.bounds.size.width / 2.0, view.bounds.size.height / 2.0);
    lable.textAlignment = NSTextAlignmentCenter;
    lable.text = title;
    
    lable.font = [UIFont systemFontOfSize:12.5];
    lable.textColor = [UIColor whiteColor];
    [view addSubview:lable];
    
    [baseView addSubview:view];
    
    [self addSubview:baseView];
    
    [UIView animateWithDuration:0.4f animations:^{
        view.frame = CGRectMake(padToSide, 0, kscreenWidth - 2 * padToSide, viewHeight);
    } completion:^(BOOL finished) {
        [self performSelector:@selector(hidden:) withObject:baseView afterDelay:durtion];
    }];
}


-(void)hidden:(UIView*)baseView{
    __block UIView * blockBaseView = baseView;
    UIView * view = [baseView viewWithTag:999];
    [UIView animateWithDuration:0.25f animations:^{
        view.frame = CGRectMake(view.frame.origin.x,-view.bounds.size.height, HintKscreenWidth - 2 *view.frame.origin.x, view.bounds.size.height);
    } completion:^(BOOL finished) {
        [baseView removeFromSuperview];
        blockBaseView = nil;
    }];
}




/********************* text *********************/

-(void)hiddenHUD:(MBProgressHUD*)hud animation:(BOOL)animation{
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES];
}

-(void)hiddenAllHint{
    [MBProgressHUD hideAllHUDsForView:self animated:YES];
}

-(void)hiddenAllHintanimated:(BOOL)animation{
    [MBHudHelper hiddenAllHintForView:self animated:animation];
}


-(void)hiddenHintIdentity:(NSString*)identity{
    [MBHudHelper hiddenHintIdentity:identity ForView:self animated:YES];
}

-(void)hiddenAllHintIdentity:(NSString*)identity animated:(BOOL)animation{
    for (MBProgressHUD * hud in [MBProgressHUD allHUDsForView:self]) {
        if ([hud.kk_view_identity isEqualToString:identity]) {
            [self hiddenHUD:hud animation:animation];
            return;
        }
    }
}


// continue

-(void)makeCTHintWithTitle:(NSString *)title
                  identity:(NSString*)identity{
    [MBHudHelper makeCTHintWithTitle:title identity:identity view:self tapIn:NO];
}

-(void)makeCTHintWithTitle:(NSString *)title
                  identity:(NSString*)identity
                  superBot:(CGFloat)superBot{
    [MBHudHelper makeCTHintWithTitle:title identity:identity view:self superBot:superBot];
}

-(void)makeCTHintWithTitle:(NSString *)title
                  identity:(NSString*)identity
                  superTop:(CGFloat)superTop{
    [MBHudHelper makeCTHintWithTitle:title identity:identity view:self superTop:superTop];
}

-(void)makeCTHintWithTitle:(NSString *)title
                  identity:(NSString*)identity
                     tapIn:(BOOL)tapIn{
    [MBHudHelper makeCTHintWithTitle:title identity:identity view:self tapIn:tapIn];
}

-(void)makeCTHintWithTitle:(NSString *)title
                  identity:(NSString*)identity
                     tapIn:(BOOL)tapIn
                  superTop:(CGFloat)superTop{
    [MBHudHelper makeCTHintWithTitle:title identity:identity view:self tapIn:tapIn superTop:superTop];
}

-(void)makeCTHintWithTitle:(NSString *)title
                  identity:(NSString*)identity
                     tapIn:(BOOL)tapIn
                  superBot:(CGFloat)superBot{
    [MBHudHelper makeCTHintWithTitle:title identity:identity view:self tapIn:tapIn superBot:superBot];
}


// hint

-(void)makeHintWithTitle:(NSString *)title{
    [MBHudHelper makeHintWithTitle:title view:self];
}

-(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                superBot:(CGFloat)superBot{
    [MBHudHelper makeHintWithTitle:title identity:identity view:self durtion:KKMBDurationDefault tapIn:NO superTop:KKMBSuperTopInvalid superBot:superBot];
}


-(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                superTop:(CGFloat)superTop{
    [MBHudHelper makeHintWithTitle:title identity:identity view:self durtion:KKMBDurationDefault tapIn:NO superTop:superTop superBot:KKMBSuperBottomInvalid];
}

-(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                   tapIn:(BOOL)tapIn{
    [MBHudHelper makeHintWithTitle:title identity:identity view:self durtion:KKMBDurationDefault tapIn:tapIn superTop:KKMBSuperTopInvalid superBot:KKMBSuperBottomInvalid];
}

-(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                   tapIn:(BOOL)tapIn
                superBot:(CGFloat)superBot{
    [MBHudHelper makeHintWithTitle:title identity:identity view:self durtion:KKMBDurationDefault tapIn:tapIn superTop:KKMBSuperTopInvalid superBot:superBot];
}


-(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                   tapIn:(BOOL)tapIn
                superTop:(CGFloat)superTop{
    [MBHudHelper makeHintWithTitle:title identity:identity view:self durtion:KKMBDurationDefault tapIn:tapIn superTop:superTop superBot:KKMBSuperBottomInvalid];
}


-(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                 durtion:(NSTimeInterval)durtion
                   tapIn:(BOOL)tapIn
                superBot:(CGFloat)superBot {
    [MBHudHelper makeHintWithTitle:title identity:identity view:self durtion:durtion tapIn:tapIn superTop:KKMBSuperTopInvalid superBot:superBot];
}


-(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                 durtion:(NSTimeInterval)durtion
                   tapIn:(BOOL)tapIn{
    [MBHudHelper makeHintWithTitle:title identity:identity view:self durtion:durtion tapIn:tapIn superTop:KKMBSuperTopInvalid superBot:KKMBSuperBottomInvalid];
}


-(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                 durtion:(NSTimeInterval)durtion
                   tapIn:(BOOL)tapIn
                superTop:(CGFloat)superTop {
    [MBHudHelper makeHintWithTitle:title identity:identity view:self durtion:durtion tapIn:tapIn superTop:superTop superBot:KKMBSuperBottomInvalid];
}


-(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                 durtion:(NSTimeInterval)durtion
                   tapIn:(BOOL)tapIn
                superTop:(CGFloat)superTop
                superBot:(CGFloat)superBot{
    [MBHudHelper makeHintWithTitle:title identity:identity view:self durtion:durtion tapIn:tapIn superTop:superTop superBot:superBot];
}


+(id)iphoneIDIs4:(id)iphone4 is5:(id)iphone5 is6:(id)iphone6 isPlus:(id)plus{
    NSString * iphone = [self iphoneVersion];
    return [iphone containsString:@"4"]?iphone4:[iphone containsString:@"5"]?iphone5:[iphone containsString:@"6"]?iphone6:plus;
}

+(CGFloat)iphoneIs4:(CGFloat)iphone4 is5:(CGFloat)iphone5 is6:(CGFloat)iphone6 isPlus:(CGFloat)plus{
    NSString * iphone = [self iphoneVersion];
    return [iphone containsString:@"4"]?iphone4:[iphone containsString:@"5"]?iphone5:[iphone containsString:@"6"]?iphone6:plus;
}

+(NSString*)iphoneVersion{
    CGFloat KKScreenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat KKScreenHeight = [UIScreen mainScreen].bounds.size.height;
    if (KKScreenWidth == 320) {
        if (KKScreenHeight == 480) {
            return @"4/4s";
        }else{
            return @"5/5s";
        }
    }else if (KKScreenWidth == 375){
        return @"6/6s";
    }else if (KKScreenWidth >= 414){
        return @"plus/plus";
    }
    return @"UNKnow";
}


@end
