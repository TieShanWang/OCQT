//
//  MBHudHelper.m
//  HudDemo
//
//  Created by MR.KING on 16/4/4.
//  Copyright © 2016年 Matej Bukovinski. All rights reserved.
//

#import "MBHudHelper.h"
#import <objc/runtime.h>

#import "MBProgressHUD.h"

#import "UIView+KKMethod.h"



@interface MBProgressHUD (KKIdentity)
@property(nonatomic,copy)NSString * identity;//标记身份
@end

@implementation MBProgressHUD (KKIdentity)

-(void)setIdentity:(NSString *)identity{
    objc_setAssociatedObject(self, @"identity", identity, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)identity{
    return objc_getAssociatedObject(self, @"identity");
}

@end


NSString * const KKMBWindowDefaultKey = @"KKMBWindowDefaultKey";
NSString * const KKMBIdentityNilKey = nil;

KKMBDuration    const KKMBDurationDefault = 2.0f;
KKMBDuration    const KKMBDurationForever = -1;

KKMBSuperBottom const KKMBSuperBottomInvalid = -1;

KKMBSuperTop    const KKMBSuperTopInvalid = -1;


@interface MBHudHelper()<MBProgressHUDDelegate>

@end

@implementation MBHudHelper



/********************* activity *********************/
+(void)makeActivityWithTitle:(NSString*)title view:(UIView*)view
{
    [self makeActivityWithTitle:title view:view  tapIn:NO];
}


+(void)makeActivityWithTitle:(NSString*)title view:(UIView*)view tapIn:(BOOL)tapIn{
    
    
    // 移除原来的 所有的 展示
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
    
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:view];
    
    HUD.mode = MBProgressHUDModeIndeterminate;
    HUD.margin = 10;
    HUD.labelFont = [UIFont systemFontOfSize:14];
    if (title) {
        HUD.labelText = title;
    }
    HUD.cornerRadius = 3;
    HUD.userInteractionEnabled = !tapIn;
    
    HUD.square = YES;
    
    [view addSubview:HUD];
    
    HUD.delegate = [self shareHelper];
    
    [HUD show:YES];
}

+(void)hiddenActivityInView:(UIView*)view{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

+(void)hiddenActivityForView:(UIView*)view{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

+(void)hiddenActivityForView:(UIView*)view Animated:(BOOL)animation{
    [MBProgressHUD hideAllHUDsForView:view animated:animation];
}


/********************* window text *********************/

+(void)makeVerCodeSendHintOnWindow{
    [self makeHintOnWindowWithTitle:@"验证码已发送到手机 请注意查看" tapIn:YES];
}

+(void)makeHintOnWindowWithTitle:(NSString*)title
{
    [self makeHintOnWindowWithTitle:title durtion:2.0f tapIn:NO];
}

+(void)makeHintOnWindowWithTitle:(NSString*)title tapIn:(BOOL)tapIn{
    [self makeHintOnWindowWithTitle:title durtion:2.0f tapIn:tapIn];
}

+(void)makeHintOnWindowWithTitle:(NSString*)title durtion:(NSTimeInterval)durtion
{
    [self makeHintWithTitle:title identity:KKMBWindowDefaultKey view:[UIApplication sharedApplication].keyWindow durtion:durtion tapIn:NO];
}

+(void)makeHintOnWindowWithTitle:(NSString*)title durtion:(NSTimeInterval)durtion tapIn:(BOOL)tapIn{
    [self makeHintWithTitle:title identity:KKMBWindowDefaultKey view:[UIApplication sharedApplication].keyWindow durtion:durtion tapIn:tapIn superTop:KKMBSuperTopInvalid];
}

+(void)hiddenHUDOnWindow{
    [self hiddenOnWindowAnimated:YES];
}

+(void)hiddenOnWindowAnimated:(BOOL)animation{
    [self hiddenAllHintForView:[UIApplication sharedApplication].keyWindow];
}

/********************* window activity *********************/

+(void)makeActivityOnWindow{
    [self makeActivityWithTitle:nil view:[UIApplication sharedApplication].keyWindow tapIn:NO];
}

+(void)makeActivityOnWindowWithTitle:(NSString*)title{
    [self makeActivityWithTitle:title view:[UIApplication sharedApplication].keyWindow tapIn:NO];
}

+(void)makeActivityOnWindowWithTitle:(NSString*)title tapIn:(BOOL)tapIn{
    [self makeActivityWithTitle:title view:[UIApplication sharedApplication].keyWindow tapIn:tapIn];
}

+(void)hiddenOnWidowActivity{
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:YES];
}

+(void)hiddenOnWindowActivityAnimated:(BOOL)animation{
    [MBProgressHUD hideAllHUDsForView:[UIApplication sharedApplication].keyWindow animated:animation];
}



/********************* text *********************/

+(void)hiddenHUD:(MBProgressHUD*)hud animation:(BOOL)animation{
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES];
}

+(void)hiddenAllHintForView:(UIView*)view{
    [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

+(void)hiddenAllHintForView:(UIView*)view animated:(BOOL)animation{
    [MBProgressHUD hideAllHUDsForView:view animated:animation];
}


+(void)hiddenHintIdentity:(NSString*)identity ForView:(UIView*)view{
    [self hiddenHintIdentity:identity ForView:view animated:YES];
}

+(void)hiddenHintIdentity:(NSString*)identity ForView:(UIView*)view animated:(BOOL)animation{
    for (MBProgressHUD * hud in [MBProgressHUD allHUDsForView:view]) {
        if ([hud.identity isEqualToString:identity]) {
            [self hiddenHUD:hud animation:animation];
            return;
        }
    }
}

+(void)makeCTHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                superBot:(CGFloat)superBot{
    [self makeHintWithTitle:title identity:identity view:view durtion:KKMBDurationForever tapIn:NO superTop:KKMBSuperTopInvalid superBot:superBot];
}


+(void)makeCTHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                superTop:(CGFloat)superTop{
    [self makeHintWithTitle:title identity:identity view:view durtion:KKMBDurationForever tapIn:NO superTop:superTop superBot:KKMBSuperBottomInvalid];
}

+(void)makeCTHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                   tapIn:(BOOL)tapIn{
    [self makeHintWithTitle:title identity:identity view:view durtion:KKMBDurationForever tapIn:tapIn superTop:KKMBSuperTopInvalid superBot:KKMBSuperBottomInvalid];
}

+(void)makeCTHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                   tapIn:(BOOL)tapIn
                superBot:(CGFloat)superBot{
    [self makeHintWithTitle:title identity:identity view:view durtion:KKMBDurationForever tapIn:tapIn superTop:KKMBSuperTopInvalid superBot:superBot];
}


+(void)makeCTHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                   tapIn:(BOOL)tapIn
                superTop:(CGFloat)superTop{
    [self makeHintWithTitle:title identity:identity view:view durtion:KKMBDurationForever tapIn:tapIn superTop:superTop superBot:KKMBSuperBottomInvalid];
}

+(void)makeHintWithTitle:(NSString*)title view:(UIView*)view{
    [self makeHintWithTitle:title identity:KKMBIdentityNilKey view:view durtion:KKMBDurationDefault tapIn:NO superTop:KKMBSuperTopInvalid superBot:KKMBSuperBottomInvalid];
}

// hint
+(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                superBot:(CGFloat)superBot{
    [self makeHintWithTitle:title identity:identity view:view durtion:KKMBDurationDefault tapIn:NO superTop:KKMBSuperTopInvalid superBot:superBot];
}


+(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                superTop:(CGFloat)superTop{
    [self makeHintWithTitle:title identity:identity view:view durtion:KKMBDurationDefault tapIn:NO superTop:superTop superBot:KKMBSuperBottomInvalid];
}

+(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                   tapIn:(BOOL)tapIn{
    [self makeHintWithTitle:title identity:identity view:view durtion:KKMBDurationDefault tapIn:tapIn superTop:KKMBSuperTopInvalid superBot:KKMBSuperBottomInvalid];
}

+(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                   tapIn:(BOOL)tapIn
                superBot:(CGFloat)superBot{
    [self makeHintWithTitle:title identity:identity view:view durtion:KKMBDurationDefault tapIn:tapIn superTop:KKMBSuperTopInvalid superBot:superBot];
}


+(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                   tapIn:(BOOL)tapIn
                superTop:(CGFloat)superTop{
    [self makeHintWithTitle:title identity:identity view:view durtion:KKMBDurationDefault tapIn:tapIn superTop:superTop superBot:KKMBSuperBottomInvalid];
}


+(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                 durtion:(NSTimeInterval)durtion
                   tapIn:(BOOL)tapIn
                superBot:(CGFloat)superBot {
    [self makeHintWithTitle:title identity:identity view:view durtion:durtion tapIn:tapIn superTop:KKMBSuperTopInvalid superBot:superBot];
}


+(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                 durtion:(NSTimeInterval)durtion
                   tapIn:(BOOL)tapIn{
    [self makeHintWithTitle:title identity:identity view:view durtion:durtion tapIn:tapIn superTop:KKMBSuperTopInvalid superBot:KKMBSuperBottomInvalid];
}


+(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                 durtion:(NSTimeInterval)durtion
                   tapIn:(BOOL)tapIn
                superTop:(CGFloat)superTop {
    [self makeHintWithTitle:title identity:identity view:view durtion:durtion tapIn:tapIn superTop:superTop superBot:KKMBSuperBottomInvalid];
}


+(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                 durtion:(NSTimeInterval)durtion
                   tapIn:(BOOL)tapIn
                superTop:(CGFloat)superTop
                superBot:(CGFloat)superBot{
    
    if (!title || ([title length] == 0)) {
        return;
    }
    if (identity) {
        for (MBProgressHUD * hud in [MBProgressHUD allHUDsForView:view]) {
            if ([hud.identity isEqualToString:identity]) {
                hud.removeFromSuperViewOnHide = YES;
                [hud hide:YES];
                break;
            }
        }
    }
    
    
    MBProgressHUD * HUD = [[MBProgressHUD alloc] initWithView:view];
    
    HUD.removeFromSuperViewOnHide = YES;
    
    HUD.mode = MBProgressHUDModeText;
    
    HUD.margin = 10;
    
    HUD.labelFont = [UIFont systemFontOfSize:14];
    
    HUD.identity = identity;
    
    if (title) {
        HUD.labelText = title;
    }
    HUD.cornerRadius = 3;
    
    HUD.userInteractionEnabled = !tapIn;
    
    [view addSubview:HUD];
    
    if (superTop != KKMBSuperTopInvalid) {
        HUD.yOffset = [self setOffSetForTop:superTop viewHeight:view.kk_height];
    }else if (superBot != KKMBSuperBottomInvalid){
        HUD.yOffset = [self setOffSetForBot:superBot viewHeight:view.kk_height];
    }
    
    HUD.delegate = [self shareHelper];
    
    [HUD show:YES];
    
    if (durtion != KKMBDurationForever) {
        [HUD hide:YES afterDelay:durtion];
    }
    
    
}

+(CGFloat)setOffSetForTop:(CGFloat)top viewHeight:(CGFloat)height{
    CGFloat defaultH = 16.7;
    CGFloat realCenteerY = defaultH / 2.0 + top;
    return realCenteerY - height / 2.0;
}

+(CGFloat)setOffSetForBot:(CGFloat)bot viewHeight:(CGFloat)height{
    CGFloat defaultH = 16.7;
    CGFloat realCenteerY = height - defaultH / 2.0 - bot;
    return realCenteerY - height / 2.0;
}



+(instancetype)shareHelper{
    static MBHudHelper * helper;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!helper) {
            helper = [[self alloc]init];
        }
    });
    return helper;
}


@end
