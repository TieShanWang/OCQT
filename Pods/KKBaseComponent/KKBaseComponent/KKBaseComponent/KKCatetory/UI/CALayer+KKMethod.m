//
//  CALayer+KKMethod.m
//  KKBaseComponent
//
//  Created by KING on 2016/10/9.
//  Copyright © 2016年 King. All rights reserved.
//

#import "CALayer+KKMethod.h"


@implementation CALayer (KKImage)

- (UIImage*)kk_getThumbnailImage
{
    return [self kk_getThumbnailImageWithSize:self.frame.size];
}

- (UIImage*)kk_getThumbnailImageWithSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, YES, [[UIScreen mainScreen] scale]);
    [self renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *viewImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return viewImage;
}

@end
