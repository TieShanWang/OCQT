//
//  MBHudHelper.h
//  HudDemo
//
//  Created by MR.KING on 16/4/4.
//  Copyright © 2016年 Matej Bukovinski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class MBProgressHUD;

typedef double KKMBDuration;
typedef double KKMBSuperBottom;
typedef double KKMBSuperTop;

extern KKMBDuration    const KKMBDurationDefault;
extern KKMBDuration    const KKMBDurationForever;

extern KKMBSuperBottom const KKMBSuperBottomInvalid;
extern KKMBSuperTop    const KKMBSuperTopInvalid;




@interface MBHudHelper : NSObject


/********************* activity *********************/
+(void)makeActivityWithTitle:(NSString*)title view:(UIView*)view;

+(void)makeActivityWithTitle:(NSString*)title view:(UIView*)view tapIn:(BOOL)tapIn;

+(void)hiddenActivityInView:(UIView*)view;

+(void)hiddenActivityForView:(UIView*)view;

+(void)hiddenActivityForView:(UIView*)view Animated:(BOOL)animation;


/********************* window text *********************/

+(void)makeVerCodeSendHintOnWindow;

+(void)makeHintOnWindowWithTitle:(NSString*)title;

+(void)makeHintOnWindowWithTitle:(NSString*)title tapIn:(BOOL)tapIn;

+(void)makeHintOnWindowWithTitle:(NSString*)title durtion:(NSTimeInterval)durtion;

+(void)makeHintOnWindowWithTitle:(NSString*)title durtion:(NSTimeInterval)durtion tapIn:(BOOL)tapIn;

+(void)hiddenHUDOnWindow;

+(void)hiddenOnWindowAnimated:(BOOL)animation;


/********************* window activity *********************/

+(void)makeActivityOnWindow;

+(void)makeActivityOnWindowWithTitle:(NSString*)title;

+(void)makeActivityOnWindowWithTitle:(NSString*)title tapIn:(BOOL)tapIn;

+(void)hiddenOnWidowActivity;

+(void)hiddenOnWindowActivityAnimated:(BOOL)animation;


/***=====================================
 ===            text                 ===
 ***===================================*/

// continue


+(void)makeCTHintWithTitle:(NSString *)title
                  identity:(NSString*)identity
                      view:(UIView*)view
                  superBot:(CGFloat)superBot;

+(void)makeCTHintWithTitle:(NSString *)title
                  identity:(NSString*)identity
                      view:(UIView*)view
                  superTop:(CGFloat)superTop;

+(void)makeCTHintWithTitle:(NSString *)title
                  identity:(NSString*)identity
                      view:(UIView*)view
                     tapIn:(BOOL)tapIn;

+(void)makeCTHintWithTitle:(NSString *)title
                  identity:(NSString*)identity
                      view:(UIView*)view
                     tapIn:(BOOL)tapIn
                  superBot:(CGFloat)superBot;


+(void)makeCTHintWithTitle:(NSString *)title
                  identity:(NSString*)identity
                      view:(UIView*)view
                     tapIn:(BOOL)tapIn
                  superTop:(CGFloat)superTop;

// hidden

+(void)hiddenHUD:(MBProgressHUD*)hud animation:(BOOL)animation;

+(void)hiddenAllHintForView:(UIView*)view;

+(void)hiddenAllHintForView:(UIView*)view animated:(BOOL)animation;

+(void)hiddenHintIdentity:(NSString*)identity ForView:(UIView*)view;

+(void)hiddenHintIdentity:(NSString*)identity ForView:(UIView*)view animated:(BOOL)animation;

// hint

+(void)makeHintWithTitle:(NSString*)title view:(UIView*)view;

+(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                superBot:(CGFloat)superBot;


+(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                superTop:(CGFloat)superTop;

+(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                   tapIn:(BOOL)tapIn;

+(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                   tapIn:(BOOL)tapIn
                superBot:(CGFloat)superBot;


+(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                   tapIn:(BOOL)tapIn
                superTop:(CGFloat)superTop;
    

+(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                 durtion:(NSTimeInterval)durtion
                   tapIn:(BOOL)tapIn
                superBot:(CGFloat)superBot;


+(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                 durtion:(NSTimeInterval)durtion
                   tapIn:(BOOL)tapIn;


+(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                 durtion:(NSTimeInterval)durtion
                   tapIn:(BOOL)tapIn
                superTop:(CGFloat)superTop;


+(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                    view:(UIView*)view
                 durtion:(NSTimeInterval)durtion
                   tapIn:(BOOL)tapIn
                superTop:(CGFloat)superTop
                superBot:(CGFloat)superBot;

@end
