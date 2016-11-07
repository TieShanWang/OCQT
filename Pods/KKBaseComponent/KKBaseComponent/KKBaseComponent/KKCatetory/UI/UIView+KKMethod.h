//
//  UIView+KKMethod.h
//  KKBaseComponent
//
//  Created by KING on 2016/10/9.
//  Copyright © 2016年 King. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (KKMethod)

@end


@interface UIView (KKViewController)

@property(nullable, nonatomic, readonly)UIViewController * kk_firstViewController;

@end


@interface UIView (KKImage)

- (UIImage*)kk_getThumbnailImage;

- (UIImage*)kk_getThumbnailImageWithSize:(CGSize)size;

@end

NS_ASSUME_NONNULL_END




#ifndef UIView_KKFrame
#define UIView_KKFrame

@interface UIView (KKFrame)

@property (nonatomic, assign) CGFloat kk_x;

@property (nonatomic, assign) CGFloat kk_y;

@property (nonatomic, assign) CGFloat kk_left;

@property (nonatomic, assign, readonly) CGFloat kk_right;

@property (nonatomic, assign) CGFloat kk_top;

@property (nonatomic, assign, readonly) CGFloat kk_bottom;

@property (nonatomic, assign) CGFloat kk_centerX;

@property (nonatomic, assign) CGFloat kk_centerY;

@property (nonatomic, assign) CGFloat kk_width;

@property (nonatomic, assign) CGFloat kk_height;

@property (nonatomic, assign) CGSize  kk_size;

@property (nonatomic, assign) CGPoint kk_origin;

@end

#endif