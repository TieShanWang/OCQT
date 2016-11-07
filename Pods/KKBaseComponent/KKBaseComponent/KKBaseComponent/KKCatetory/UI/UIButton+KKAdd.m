//
//  UIButton+Indicator.m
//  KKBtnIndicator
//
//  Created by MR.KING on 16/5/15.
//  Copyright © 2016年 Tmp. All rights reserved.
//

#import "UIButton+KKAdd.h"
#import <objc/runtime.h>

#import "UIView+KKMethod.h"

//static NSString * lastTitle;
//static UIControlState lastState;

@implementation UIButton (KKIndicator)

-(void)startIndicatorAnimation{
    [self startIndicatorAnimation:nil];
}

-(void)startIndicatorAnimation:(void(^)())didBegin{
    if (self.kk_animating) {
        if (didBegin) {
            didBegin();
        }
        return;
    }
    [self initData];
    if (self.kk_animationType == UIButtonIndicatorAnimationTypeDefault) {
        if (self.indicatorView) {
            self.indicatorView.transform = CGAffineTransformIdentity;
            CGSize indiSize = self.indicatorView.bounds.size;
            CGRect titleFrame = self.titleLabel.frame;
            self.indicatorView.transform = CGAffineTransformMakeScale(self.kk_zoomScale, self.kk_zoomScale);
            CGSize size = CGSizeMake(indiSize.width, indiSize.height);
            
            CGPoint newCenter;
            
            if (self.kk_position == UIButtonIndicatorPositionRight) {
                newCenter = CGPointMake(CGRectGetMaxX(titleFrame) + self.kk_xOffset + size.width / 2.0,
                                        CGRectGetMidY(self.bounds) + self.kk_yOffset);
            }else if (self.kk_position == UIButtonIndicatorPositionCenter){
                newCenter = CGPointMake(CGRectGetMidX(self.bounds) + self.kk_xOffset,
                                        CGRectGetMidY(self.bounds) + self.kk_yOffset);
            }else{
                newCenter = CGPointMake(CGRectGetMinX(titleFrame) + self.kk_xOffset - size.width / 2.0,
                                        CGRectGetMidY(self.bounds) + self.kk_yOffset);
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                if (![self.subviews containsObject:self.indicatorView]) {
                    [self addSubview:self.indicatorView];
                }
                self.indicatorView.bounds = CGRectMake(0, 0, size.width, size.height);
                self.indicatorView.center = newCenter;
                
            });
            self.kk_animating = YES;
            [self.indicatorView startAnimating];
            if (didBegin) {
                didBegin();
            }
        }
    }
}


-(void)initData{

    switch (self.kk_position) {
        case UIButtonIndicatorPositionLeft:
            self.kk_xOffset = (self.kk_xOffset)?self.kk_xOffset:-10;
            break;
        case UIButtonIndicatorPositionRight:
            self.kk_xOffset = (self.kk_xOffset)?self.kk_xOffset:10;
            break;
        default:
            self.kk_xOffset = (self.kk_xOffset)?self.kk_xOffset:0;
            break;
    }
    if (self.kk_zoomScale == 0) {
        self.kk_zoomScale = 1;
    }
}


-(void)stopIndicatorAnimation{
    [self stopIndicatorAnimationCompletion:nil];
}

-(void)stopIndicatorAnimationCompletion:(void(^)())completion{
    if (!self.kk_animating) {
        return;
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        if (self.kk_animationType == UIButtonIndicatorAnimationTypeDefault  && self.indicatorView) {
            [self.indicatorView stopAnimating];
        }
        if (completion) {
            completion();
        }
        self.kk_animating = NO;
    });
}


-(UIActivityIndicatorView *)indicatorView{
    if (!objc_getAssociatedObject(self, @"indicatorView")) {
        UIActivityIndicatorView * indicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        indicator.hidesWhenStopped = YES;
        objc_setAssociatedObject(self, @"indicatorView", indicator, OBJC_ASSOCIATION_RETAIN);
    }
    return objc_getAssociatedObject(self, @"indicatorView");
}

-(void)setKk_animationType:(UIButtonIndicatorAnimationType)kk_animationType{
    objc_setAssociatedObject(self, @"kk_animationType", @(kk_animationType), OBJC_ASSOCIATION_COPY);
}

-(UIButtonIndicatorAnimationType)kk_animationType{
    return [objc_getAssociatedObject(self, @"kk_animationType") integerValue];
}

-(void)setKk_position:(UIButtonIndicatorPosition)kk_position{
    objc_setAssociatedObject(self, @"kk_position", @(kk_position), OBJC_ASSOCIATION_COPY);
}

-(UIButtonIndicatorPosition)kk_position{
    return [objc_getAssociatedObject(self, @"kk_position") integerValue];
}


-(void)setKk_xOffset:(CGFloat)kk_xOffset{
    objc_setAssociatedObject(self, @"kk_xOffset", @(kk_xOffset), OBJC_ASSOCIATION_COPY);
}

-(CGFloat)kk_xOffset{
    NSNumber * num = objc_getAssociatedObject(self, @"kk_xOffset");
    return (num)?[num doubleValue]:0;
}


-(void)setKk_yOffset:(CGFloat)kk_yOffset{
    objc_setAssociatedObject(self, @"kk_yOffset", @(kk_yOffset), OBJC_ASSOCIATION_COPY);
}

-(CGFloat)kk_yOffset{
    return [objc_getAssociatedObject(self, @"kk_yOffset") doubleValue];
}

-(void)setKk_zoomScale:(CGFloat)kk_zoomScale{
    objc_setAssociatedObject(self, @"kk_zoomScale", @(kk_zoomScale), OBJC_ASSOCIATION_COPY);
}

-(CGFloat)kk_zoomScale{
    NSNumber * num = objc_getAssociatedObject(self, @"kk_zoomScale");
    return (num)?[num doubleValue]:0.0f;
}

-(void)setKk_animating:(BOOL)kk_animating{
    objc_setAssociatedObject(self, @"kk_animating", @(kk_animating), OBJC_ASSOCIATION_COPY);
}

-(BOOL)kk_animating{
    return [objc_getAssociatedObject(self, @"kk_animating") boolValue];
}


@end



@implementation UIButton (CMPosition)

-(void)setTitleLabelTapTarget:(id)target action:(SEL)sel{
    if (target && sel) {
        self.titleLabel.userInteractionEnabled = YES;
        UITapGestureRecognizer * tap = self.titleLabelTapGesture;
        if (!tap) {
            tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:sel];
            [self.titleLabel addGestureRecognizer:tap];
        }else{
            [tap addTarget:target action:sel];
        }
    }
    
}

-(UITapGestureRecognizer *)titleLabelTapGesture{
    return objc_getAssociatedObject(self, "titleLabelTapGesture");
}

- (void)setImagePosition:(CMImagePosition)imagePosition spacing:(CGFloat)spacing
{
    [self setTitle:self.currentTitle forState:UIControlStateNormal];
    [self setImage:self.currentImage forState:UIControlStateNormal];
    CGFloat imageWidth = CGImageGetWidth(self.imageView.image.CGImage);
    CGFloat imageHeight = CGImageGetHeight(self.imageView.image.CGImage);
    CGSize size = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
    CGFloat labelWidth = size.width;
    CGFloat labelHeight = size.height;
    CGFloat imageOffsetX = (imageWidth + labelWidth) / 2 - imageWidth / 2;
    CGFloat imageOffsetY = imageHeight / 2 + spacing / 2;
    CGFloat labelOffsetX = (imageWidth + labelWidth / 2) - (imageWidth + labelWidth) / 2;
    CGFloat labelOffsetY = labelHeight / 2 + spacing / 2;
    CGFloat tempWidth = MAX(labelWidth, imageWidth);
    CGFloat changedWidth = labelWidth + imageWidth - tempWidth;
    CGFloat tempHeight = MAX(labelHeight, imageHeight);
    CGFloat changedHeight = labelHeight + imageHeight + spacing - tempHeight;
    switch (imagePosition) {
        case CMImagePositionLeft:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, -spacing/2, 0, spacing/2);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, -spacing/2);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
        case CMImagePositionRight:
            self.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, (labelWidth + spacing/2));
            self.titleEdgeInsets = UIEdgeInsetsMake(0, (imageWidth + spacing/2), 0, 0);
            self.contentEdgeInsets = UIEdgeInsetsMake(0, spacing/2, 0, spacing/2);
            break;
        case CMImagePositionTop:
            self.imageEdgeInsets = UIEdgeInsetsMake(-imageOffsetY, imageOffsetX, imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, 0, -labelOffsetY, labelOffsetX);
            //            self.titleEdgeInsets = UIEdgeInsetsMake(labelOffsetY, -labelOffsetX, -labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(imageOffsetY, -changedWidth/2, changedHeight-imageOffsetY, -changedWidth/2);
            break;
        case CMImagePositionBottom:
            self.imageEdgeInsets = UIEdgeInsetsMake(imageOffsetY, imageOffsetX, -imageOffsetY, -imageOffsetX);
            self.titleEdgeInsets = UIEdgeInsetsMake(-labelOffsetY, -labelOffsetX, labelOffsetY, labelOffsetX);
            self.contentEdgeInsets = UIEdgeInsetsMake(changedHeight-imageOffsetY, -changedWidth/2, imageOffsetY, -changedWidth/2);
            break;
        default:
            break;
    }
}

@end
