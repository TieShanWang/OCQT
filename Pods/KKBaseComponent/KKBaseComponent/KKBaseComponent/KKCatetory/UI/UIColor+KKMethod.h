//
//  UIColor+KKMethod.h
//  KKBaseComponent
//
//  Created by KING on 2016/10/9.
//  Copyright © 2016年 King. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (KKImage)

/**
 *  Generate a pure color photos / 生成一个纯色图片
 *
 *  @param size image size / 要生成的图片的大小
 *
 *  @return image
 */
- (UIImage *)kk_createImageWithSize:(CGSize)size;


/**
 *  Generate a pure color photos / 生成一个纯色图片
 *
 *  @param size image size / 要生成的图片的大小
 *
 *  @param scale image scale
 *
 *  @return image
 */
- (UIImage *)kk_createImageWithSize:(CGSize)size scale:(CGFloat)scale;

@end



@interface UIColor (KKHex)
+ (UIColor *)kk_colorFromHexString:(NSString *)hexString;
@end
