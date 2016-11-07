//
//  UIButton+Indicator.h
//  KKBtnIndicator
//
//  Created by MR.KING on 16/5/15.
//  Copyright © 2016年 Tmp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSInteger {
    UIButtonIndicatorAnimationTypeDefault,
    UIButtonIndicatorAnimationTypeRound,
} UIButtonIndicatorAnimationType;

typedef enum : NSInteger {
    UIButtonIndicatorPositionRight, // default
    UIButtonIndicatorPositionCenter,
    UIButtonIndicatorPositionLeft
} UIButtonIndicatorPosition;

@interface UIButton (KKIndicator)

/// 可用 default round, 默认是系统的indicator，
@property(nonatomic,assign)UIButtonIndicatorAnimationType  kk_animationType;

/// 可用 right,center,left
@property(nonatomic,assign)UIButtonIndicatorPosition kk_position;

// 相对于titleLable 右侧/左侧偏移量 默认 10
@property(nonatomic,assign)CGFloat kk_xOffset;

/// 默认 0
@property(nonatomic,assign)CGFloat kk_yOffset;

/// 默认1
@property(nonatomic,assign)CGFloat kk_zoomScale;

/// 是否是正在动画
@property(nonatomic,assign)BOOL kk_animating;

/// 当使用默认的动画类型。动画图为 UIActivityIndicatorView
@property(nonatomic,strong,readonly)UIActivityIndicatorView * indicatorView;

-(void)startIndicatorAnimation;

-(void)stopIndicatorAnimation;

-(void)startIndicatorAnimation:(void(^)())didBegin;

-(void)stopIndicatorAnimationCompletion:(void(^)())completion;

@end




typedef NS_ENUM(NSInteger, CMImagePosition) {
    CMImagePositionLeft = 0,              //图片在左，文字在右，默认
    CMImagePositionRight = 1,             //图片在右，文字在左
    CMImagePositionTop = 2,               //图片在上，文字在下
    CMImagePositionBottom = 3,            //图片在下，文字在上
};

@interface UIButton (CMPosition)

/**
 *  设置Button图片和文字的位置关系
 *
 *  @param imagePosition imagePosition
 *  @param spacing       图片和文字的间距
 */
- (void)setImagePosition:(CMImagePosition)imagePosition spacing:(CGFloat)spacing;

/**
 *  title label 的点击事件
 *  default is nil, call setTitleLabelTapTarget:action:
 */
@property(nonatomic, strong, readonly)UITapGestureRecognizer * titleLabelTapGesture;


/**
 *  设置titlelabel点击事件的接收者和事件
 */
-(void)setTitleLabelTapTarget:(id)target action:(SEL)sel;

@end

