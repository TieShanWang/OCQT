//
//  CALayer+KKMethod.h
//  KKBaseComponent
//
//  Created by KING on 2016/10/9.
//  Copyright © 2016年 King. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

#import <UIKit/UIKit.h>

@interface CALayer (KKImage)

/**
 *  get thumbnail image
 *
 *  @return thumbnail image
 */
- (UIImage*)kk_getThumbnailImage;

/**
 *  get thumbnail image by special size
 *
 *  @param size thumbnail size
 *
 *  @return thumbnail image
 */
- (UIImage*)kk_getThumbnailImageWithSize:(CGSize)size;

@end