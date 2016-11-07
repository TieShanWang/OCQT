//
//  UIView+Hint.h
//  HudDemo
//
//  Created by MR.KING on 16/4/4.
//  Copyright © 2016年 Matej Bukovinski. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MBProgressHUD;

@interface UIView (Hint)

-(void)makeHintBlowNavigationBarWithTitle:(NSString *)title;
-(void)makeHintBlowNavigationBarWithTitle:(NSString*)title durtion:(NSTimeInterval)durtion;

/*********************活动指示器 指示*********************/


/**
 *  展示指示器
 *  默认不可穿透点击
 */
-(void)makeActivity;
/**
 *  展示指示器
 *  默认不可穿透点击
 *  @param title title
 */
-(void)makeActivityWithTitle:(NSString*)title;


/**
 *  展示指示器
 *  默认 自定义 穿透点击
 *  @param title title
 */
-(void)makeActivityWithTitle:(NSString*)title tapIn:(BOOL)tapIn;


-(void)hiddenActivity;


/***=====================================
 ===            text                 ===
 ***===================================*/


// continue


-(void)makeCTHintWithTitle:(NSString *)title
                  identity:(NSString*)identity;


-(void)makeCTHintWithTitle:(NSString *)title
                  identity:(NSString*)identity
                  superBot:(CGFloat)superBot;

-(void)makeCTHintWithTitle:(NSString *)title
                  identity:(NSString*)identity
                  superTop:(CGFloat)superTop;

-(void)makeCTHintWithTitle:(NSString *)title
                  identity:(NSString*)identity
                     tapIn:(BOOL)tapIn;

-(void)makeCTHintWithTitle:(NSString *)title
                  identity:(NSString*)identity
                     tapIn:(BOOL)tapIn
                  superTop:(CGFloat)superTop;

-(void)makeCTHintWithTitle:(NSString *)title
                  identity:(NSString*)identity
                     tapIn:(BOOL)tapIn
                  superBot:(CGFloat)superBot;

// hidden

-(void)makeHintWithTitle:(NSString *)title;

-(void)hiddenHUD:(MBProgressHUD*)hud animation:(BOOL)animation;

-(void)hiddenAllHint;

-(void)hiddenAllHintanimated:(BOOL)animation;

-(void)hiddenHintIdentity:(NSString*)identity;

-(void)hiddenAllHintIdentity:(NSString*)identity animated:(BOOL)animation;

// hint

-(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                superBot:(CGFloat)superBot;


-(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                superTop:(CGFloat)superTop;

-(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                   tapIn:(BOOL)tapIn;

-(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                   tapIn:(BOOL)tapIn
                superBot:(CGFloat)superBot;


-(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                   tapIn:(BOOL)tapIn
                superTop:(CGFloat)superTop;


-(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                 durtion:(NSTimeInterval)durtion
                   tapIn:(BOOL)tapIn
                superBot:(CGFloat)superBot;


-(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                 durtion:(NSTimeInterval)durtion
                   tapIn:(BOOL)tapIn;


-(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                 durtion:(NSTimeInterval)durtion
                   tapIn:(BOOL)tapIn
                superTop:(CGFloat)superTop;


-(void)makeHintWithTitle:(NSString *)title
                identity:(NSString*)identity
                 durtion:(NSTimeInterval)durtion
                   tapIn:(BOOL)tapIn
                superTop:(CGFloat)superTop
                superBot:(CGFloat)superBot;
@end
