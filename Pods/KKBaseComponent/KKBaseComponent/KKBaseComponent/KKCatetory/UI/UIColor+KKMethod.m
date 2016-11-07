//
//  UIColor+KKMethod.m
//  KKBaseComponent
//
//  Created by KING on 2016/10/9.
//  Copyright © 2016年 King. All rights reserved.
//

#import "UIColor+KKMethod.h"

#import "NSString+KKMethod.h"

#import "KKMath.h"

@implementation UIColor (KKImage)

/*通过颜色来生成一个纯色图片*/
- (UIImage *)kk_createImageWithSize:(CGSize)size {
    return [self kk_createImageWithSize:size scale:1.0f];
}

-(UIImage *)kk_createImageWithSize:(CGSize)size scale:(CGFloat)scale{
    UIGraphicsBeginImageContextWithOptions(size, NO, scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, CGZeroXYRectBySize(size));
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext(); return img;
}

@end


@implementation UIColor (KKHex)

+ (UIColor *)kk_colorFromHexString:(NSString *)hexString
{
    if ([hexString isKindOfClass:[NSNull class]]) {
        return nil;
    }
    if (!hexString || [hexString isEqualToString:@"none"] || !(hexString.length == 3 || hexString.length == 4 || hexString.length == 6 || hexString.length == 7))
        return nil;
    hexString = [hexString stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"#"]];
    if (hexString.length == 3) {
        hexString = [NSString stringWithFormat:@"%@%@%@%@%@%@", [hexString characterStrAtIndex:0], [hexString characterStrAtIndex:0],
                     [hexString characterStrAtIndex:1], [hexString characterStrAtIndex:1],
                     [hexString characterStrAtIndex:2], [hexString characterStrAtIndex:2]];
    }
    unsigned int rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0
                           green:((rgbValue & 0xFF00) >> 8)/255.0
                            blue:(rgbValue & 0xFF)/255.0
                           alpha:1.0];
}

@end
