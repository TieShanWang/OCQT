//
//  UIImage+KKAdd.m
//  KKBaseComponent
//
//  Created by KING on 2016/10/9.
//  Copyright © 2016年 King. All rights reserved.
//

#import "UIImage+KKAdd.h"
#import <Accelerate/Accelerate.h>

#import "KKMath.h"

//LOMO
const float colormatrix_lomo[] = {
    1.7f,  0.1f, 0.1f, 0, -73.1f,
    0,  1.7f, 0.1f, 0, -73.1f,
    0,  0.1f, 1.6f, 0, -73.1f,
    0,  0, 0, 1.0f, 0 };

//黑白
const float colormatrix_heibai[] = {
    0.8f,  1.6f, 0.2f, 0, -163.9f,
    0.8f,  1.6f, 0.2f, 0, -163.9f,
    0.8f,  1.6f, 0.2f, 0, -163.9f,
    0,  0, 0, 1.0f, 0 };
//复古
const float colormatrix_vintage[] = {
    0.2f,0.5f, 0.1f, 0, 40.8f,
    0.2f, 0.5f, 0.1f, 0, 40.8f,
    0.2f,0.5f, 0.1f, 0, 40.8f,
    0, 0, 0, 1, 0 };

//哥特
const float colormatrix_gete[] = {
    1.9f,-0.3f, -0.2f, 0,-87.0f,
    -0.2f, 1.7f, -0.1f, 0, -87.0f,
    -0.1f,-0.6f, 2.0f, 0, -87.0f,
    0, 0, 0, 1.0f, 0 };

//锐化
const float colormatrix_sharp[] = {
    4.8f,-1.0f, -0.1f, 0,-388.4f,
    -0.5f,4.4f, -0.1f, 0,-388.4f,
    -0.5f,-1.0f, 5.2f, 0,-388.4f,
    0, 0, 0, 1.0f, 0 };


//淡雅
const float colormatrix_danya[] = {
    0.6f,0.3f, 0.1f, 0,73.3f,
    0.2f,0.7f, 0.1f, 0,73.3f,
    0.2f,0.3f, 0.4f, 0,73.3f,
    0, 0, 0, 1.0f, 0 };

//酒红
const float colormatrix_jiuhong[] = {
    1.2f,0.0f, 0.0f, 0.0f,0.0f,
    0.0f,0.9f, 0.0f, 0.0f,0.0f,
    0.0f,0.0f, 0.8f, 0.0f,0.0f,
    0, 0, 0, 1.0f, 0 };

//清宁
const float colormatrix_qingning[] = {
    0.9f, 0, 0, 0, 0,
    0, 1.1f,0, 0, 0,
    0, 0, 0.9f, 0, 0,
    0, 0, 0, 1.0f, 0 };

//浪漫
const float colormatrix_langman[] = {
    0.9f, 0, 0, 0, 63.0f,
    0, 0.9f,0, 0, 63.0f,
    0, 0, 0.9f, 0, 63.0f,
    0, 0, 0, 1.0f, 0 };

//光晕
const float colormatrix_guangyun[] = {
    0.9f, 0, 0,  0, 64.9f,
    0, 0.9f,0,  0, 64.9f,
    0, 0, 0.9f,  0, 64.9f,
    0, 0, 0, 1.0f, 0 };

//蓝调
const float colormatrix_landiao[] = {
    2.1f, -1.4f, 0.6f, 0.0f, -31.0f,
    -0.3f, 2.0f, -0.3f, 0.0f, -31.0f,
    -1.1f, -0.2f, 2.6f, 0.0f, -31.0f,
    0.0f, 0.0f, 0.0f, 1.0f, 0.0f
};

//梦幻
const float colormatrix_menghuan[] = {
    0.8f, 0.3f, 0.1f, 0.0f, 46.5f,
    0.1f, 0.9f, 0.0f, 0.0f, 46.5f,
    0.1f, 0.3f, 0.7f, 0.0f, 46.5f,
    0.0f, 0.0f, 0.0f, 1.0f, 0.0f
};

//夜色
const float colormatrix_yese[] = {
    1.0f, 0.0f, 0.0f, 0.0f, -66.6f,
    0.0f, 1.1f, 0.0f, 0.0f, -66.6f,
    0.0f, 0.0f, 1.0f, 0.0f, -66.6f,
    0.0f, 0.0f, 0.0f, 1.0f, 0.0f
};


static void adjustColorValue(int *color){
    
    if (*color<0) {
        *color=0;
    }
    
    if (*color>255) {
        *color=255;
    }
    
}

static UIImage *filterOutputImage(UIImage *image,const float *f){
    
    // create bitmap context
    float width = CGImageGetWidth(image.CGImage);
    float height = CGImageGetHeight(image.CGImage);
    int bitsPerComponent = 8;// 每个通道占8bits，一个字节
    long bytesPerRow = width*4;
    size_t bitmapBytesCount = bytesPerRow * height;
    //void *bitmapData = malloc(bitmapBytesCount);
    CGColorSpaceRef inputColorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef bitmapContext = CGBitmapContextCreate(NULL, width, height, bitsPerComponent, bytesPerRow,inputColorSpace , kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast);//rgba
    CGColorSpaceRelease(inputColorSpace);
    if (!bitmapContext) {
        CGContextRelease(bitmapContext);
        return nil;
    }
    
    // get image datas
    CGRect rect = {{0,0},{width,height}};
    CGContextDrawImage(bitmapContext, rect, image.CGImage);
    UInt8 *datas = (UInt8 *)CGBitmapContextGetData(bitmapContext);
    
    
    //handle every pixel datas
    for (int i=0; i<bitmapBytesCount;i+=4){
        
        int r = f[0] * datas[i] + f[1] * datas[i+1] + f[2] * datas[i+2] + f[3] * datas[i+3] + f[4];
        int g = f[0+5] * datas[i] + f[1+5] * datas[i+1] + f[2+5] * datas[i+2] + f[3+5] * datas[i+3] + f[4+5];
        int b = f[0+5*2] * datas[i] + f[1+5*2] * datas[i+1] + f[2+5*2] * datas[i+2] + f[3+5*2] * datas[i+3] + f[4+5*2];
        int a = f[0+5*3] * datas[i] + f[1+5*3] * datas[i+1] + f[2+5*3] * datas[i+2] + f[3+5*3] * datas[i+3] + f[4+5*3];
        
        adjustColorValue(&r);
        adjustColorValue(&b);
        adjustColorValue(&g);
        adjustColorValue(&a);
        
        datas[i]=r;
        datas[i+1]=g;
        datas[i+2]=b;
        datas[i+3]=a;
        
    }
    
    // 创建输出  -->造成了崩溃！！！ fixed
    //    CGDataProviderRef provider = CGDataProviderCreateWithData(NULL,datas, bitmapBytesCount, NULL);
    //    CGColorSpaceRef outputColorSpace = CGColorSpaceCreateDeviceRGB();
    //    CGImageRef ouputImageRef = CGImageCreate(width, height, bitsPerComponent, bitsPerComponent*4, bytesPerRow, outputColorSpace, kCGBitmapByteOrderDefault, provider, NULL, NO, kCGRenderingIntentDefault);
    CGImageRef ouputImageRef = CGBitmapContextCreateImage(bitmapContext);
    UIImage *retImage = [UIImage imageWithCGImage:ouputImageRef];
    
    // return and release dest soruce
    //    CGDataProviderRelease(provider);
    //    CGColorSpaceRelease(outputColorSpace);
    CGImageRelease(ouputImageRef);
    CGContextRelease(bitmapContext);
    
    return retImage;
}


@implementation UIImage (KKFilter)

- (UIImage *)kk_LOMOFilterOutput{
    
    return filterOutputImage(self, colormatrix_lomo);
    
}  // LOMO

- (UIImage *)kk_grayFilterOutput{
    
    return filterOutputImage(self, colormatrix_heibai);
}  //黑白

- (UIImage *)kk_vintageFilterOutput{
    
    return filterOutputImage(self, colormatrix_vintage);
} //复古

- (UIImage *)kk_geteFilterOutput{
    return filterOutputImage(self, colormatrix_gete);
}  // 哥特

- (UIImage *)kk_sharpFilterOutput{
    return filterOutputImage(self, colormatrix_sharp);
}  // 锐化

- (UIImage *)kk_elegantFilterOutput{
    return filterOutputImage(self, colormatrix_danya);
} //淡雅

- (UIImage *)kk_redWineFilterOutput{
    return filterOutputImage(self, colormatrix_jiuhong);
} // 酒红

- (UIImage *)kk_quietFilterOutput{
    return filterOutputImage(self, colormatrix_qingning);
}    //清宁

- (UIImage *)kk_romanticFilterOutput{
    return filterOutputImage(self, colormatrix_langman);
} // 浪漫

- (UIImage *)kk_shineFilterOutput{
    return filterOutputImage(self, colormatrix_guangyun);
}  // 光晕

- (UIImage *)kk_blueFilterOutput{
    return filterOutputImage(self, colormatrix_landiao);
}   // 蓝调

- (UIImage *)kk_dreamFilterOutput{
    return filterOutputImage(self, colormatrix_menghuan);
} // 梦幻

- (UIImage *)kk_darkFilterOutput{
    return filterOutputImage(self, colormatrix_yese);
} // 夜色


- (UIImage *)kk_gaussBlurFilterWithLevel:(CGFloat)blurLevel{
    
    CIImage *inputImage = [CIImage imageWithCGImage:self.CGImage];
    
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur" keysAndValues:kCIInputImageKey ,inputImage, @"inputRadius",@(blurLevel) ,nil];
    
    
    CIImage *outputImage = filter.outputImage;
    
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef imageRef = [context createCGImage:outputImage fromRect:[outputImage extent]];
    
    UIImage *img = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    
    return img;
}

- (UIImage *)kk_blurWithLevel:(CGFloat)blurLevel{
    
    CIContext *context   = [CIContext contextWithOptions:nil];
    CIImage *sourceImage = [CIImage imageWithCGImage:self.CGImage];
    
    // Apply clamp filter:
    // this is needed because the CIGaussianBlur when applied makes
    // a trasparent border around the image
    
    NSString *clampFilterName = @"CIAffineClamp";
    CIFilter *clamp = [CIFilter filterWithName:clampFilterName];
    if (!clamp) {
        
        NSLog(@"");
        return nil;
    }
    
    [clamp setValue:sourceImage
             forKey:kCIInputImageKey];
    CIImage *clampResult = [clamp valueForKey:kCIOutputImageKey];
    
    // Apply Gaussian Blur filter
    
    NSString *gaussianBlurFilterName = @"CIGaussianBlur";
    CIFilter *gaussianBlur           = [CIFilter filterWithName:gaussianBlurFilterName];
    if (!gaussianBlur) {
        
        NSLog(@"");
        return nil;
    }
    
    [gaussianBlur setValue:clampResult
                    forKey:kCIInputImageKey];
    [gaussianBlur setValue:[NSNumber numberWithFloat:blurLevel]
                    forKey:@"inputRadius"];
    
    CIImage *gaussianBlurResult = [gaussianBlur valueForKey:kCIOutputImageKey];
    
    
    CGImageRef cgImage = [context createCGImage:gaussianBlurResult
                                       fromRect:[sourceImage extent]];
    
    UIImage *blurredImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return blurredImage;
}


@end





@implementation UIImage (ImageEffects)

- (UIImage *)kk_applyLightEffect{
    UIColor *tintColor = [UIColor colorWithWhite:1.0 alpha:0.3];
    return [self kk_applyBlurWithRadius:30 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)kk_applyExtraLightEffect{
    UIColor *tintColor = [UIColor colorWithWhite:0.97 alpha:0.82];
    return [self kk_applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)kk_applyDarkEffect{
    UIColor *tintColor = [UIColor colorWithWhite:0.11 alpha:0.73];
    return [self kk_applyBlurWithRadius:20 tintColor:tintColor saturationDeltaFactor:1.8 maskImage:nil];
}

- (UIImage *)kk_applyTintEffectWithColor:(UIColor *)tintColor{
    const CGFloat EffectColorAlpha = 0.6;
    UIColor *effectColor = tintColor;
    NSUInteger componentCount = CGColorGetNumberOfComponents(tintColor.CGColor);
    if (componentCount == 2) {
        CGFloat b;
        if ([tintColor getWhite:&b alpha:NULL]) {
            effectColor = [UIColor colorWithWhite:b alpha:EffectColorAlpha];
        }
    }
    else {
        CGFloat r, g, b;
        if ([tintColor getRed:&r green:&g blue:&b alpha:NULL]) {
            effectColor = [UIColor colorWithRed:r green:g blue:b alpha:EffectColorAlpha];
        }
    }
    return [self kk_applyBlurWithRadius:10 tintColor:effectColor saturationDeltaFactor:-1.0 maskImage:nil];
}

- (UIImage *)kk_applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage{
    // Check pre-conditions.
    if (self.size.width < 1 || self.size.height < 1) {
        NSLog (@"*** error: invalid size: (%.2f x %.2f). Both dimensions must be >= 1: %@", self.size.width, self.size.height, self);
        return nil;
    }
    if (!self.CGImage) {
        NSLog (@"*** error: image must be backed by a CGImage: %@", self);
        return nil;
    }
    if (maskImage && !maskImage.CGImage) {
        NSLog (@"*** error: maskImage must be backed by a CGImage: %@", maskImage);
        return nil;
    }
    
    CGRect imageRect = { CGPointZero, self.size };
    UIImage *effectImage = self;
    
    BOOL hasBlur = blurRadius > __FLT_EPSILON__;
    BOOL hasSaturationChange = fabs(saturationDeltaFactor - 1.) > __FLT_EPSILON__;
    if (hasBlur || hasSaturationChange) {
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectInContext = UIGraphicsGetCurrentContext();
        CGContextScaleCTM(effectInContext, 1.0, -1.0);
        CGContextTranslateCTM(effectInContext, 0, -self.size.height);
        CGContextDrawImage(effectInContext, imageRect, self.CGImage);
        
        vImage_Buffer effectInBuffer;
        effectInBuffer.data     = CGBitmapContextGetData(effectInContext);
        effectInBuffer.width    = CGBitmapContextGetWidth(effectInContext);
        effectInBuffer.height   = CGBitmapContextGetHeight(effectInContext);
        effectInBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectInContext);
        
        UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
        CGContextRef effectOutContext = UIGraphicsGetCurrentContext();
        vImage_Buffer effectOutBuffer;
        effectOutBuffer.data     = CGBitmapContextGetData(effectOutContext);
        effectOutBuffer.width    = CGBitmapContextGetWidth(effectOutContext);
        effectOutBuffer.height   = CGBitmapContextGetHeight(effectOutContext);
        effectOutBuffer.rowBytes = CGBitmapContextGetBytesPerRow(effectOutContext);
        
        if (hasBlur) {
            // A description of how to compute the box kernel width from the Gaussian
            // radius (aka standard deviation) appears in the SVG spec:
            // http://www.w3.org/TR/SVG/filters.html#feGaussianBlurElement
            //
            // For larger values of 's' (s >= 2.0), an approximation can be used: Three
            // successive box-blurs build a piece-wise quadratic convolution kernel, which
            // approximates the Gaussian kernel to within roughly 3%.
            //
            // let d = floor(s * 3*sqrt(2*pi)/4 + 0.5)
            //
            // ... if d is odd, use three box-blurs of size 'd', centered on the output pixel.
            //
            CGFloat inputRadius = blurRadius * [[UIScreen mainScreen] scale];
            NSUInteger radius = floor(inputRadius * 3. * sqrt(2 * M_PI) / 4 + 0.5);
            if (radius % 2 != 1) {
                radius += 1; // force radius to be odd so that the three box-blur methodology works.
            }
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectOutBuffer, &effectInBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
            vImageBoxConvolve_ARGB8888(&effectInBuffer, &effectOutBuffer, NULL, 0, 0, (uint32_t)radius, (uint32_t)radius, 0, kvImageEdgeExtend);
        }
        BOOL effectImageBuffersAreSwapped = NO;
        if (hasSaturationChange) {
            CGFloat s = saturationDeltaFactor;
            CGFloat floatingPointSaturationMatrix[] = {
                0.0722 + 0.9278 * s,  0.0722 - 0.0722 * s,  0.0722 - 0.0722 * s,  0,
                0.7152 - 0.7152 * s,  0.7152 + 0.2848 * s,  0.7152 - 0.7152 * s,  0,
                0.2126 - 0.2126 * s,  0.2126 - 0.2126 * s,  0.2126 + 0.7873 * s,  0,
                0,                    0,                    0,  1,
            };
            const int32_t divisor = 256;
            NSUInteger matrixSize = sizeof(floatingPointSaturationMatrix)/sizeof(floatingPointSaturationMatrix[0]);
            int16_t saturationMatrix[matrixSize];
            for (NSUInteger i = 0; i < matrixSize; ++i) {
                saturationMatrix[i] = (int16_t)roundf(floatingPointSaturationMatrix[i] * divisor);
            }
            if (hasBlur) {
                vImageMatrixMultiply_ARGB8888(&effectOutBuffer, &effectInBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
                effectImageBuffersAreSwapped = YES;
            }
            else {
                vImageMatrixMultiply_ARGB8888(&effectInBuffer, &effectOutBuffer, saturationMatrix, divisor, NULL, NULL, kvImageNoFlags);
            }
        }
        if (!effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        if (effectImageBuffersAreSwapped)
            effectImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    // Set up output context.
    UIGraphicsBeginImageContextWithOptions(self.size, NO, [[UIScreen mainScreen] scale]);
    CGContextRef outputContext = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(outputContext, 1.0, -1.0);
    CGContextTranslateCTM(outputContext, 0, -self.size.height);
    
    // Draw base image.
    CGContextDrawImage(outputContext, imageRect, self.CGImage);
    
    // Draw effect image.
    if (hasBlur) {
        CGContextSaveGState(outputContext);
        if (maskImage) {
            CGContextClipToMask(outputContext, imageRect, maskImage.CGImage);
        }
        CGContextDrawImage(outputContext, imageRect, effectImage.CGImage);
        CGContextRestoreGState(outputContext);
    }
    
    // Add in color tint.
    if (tintColor) {
        CGContextSaveGState(outputContext);
        CGContextSetFillColorWithColor(outputContext, tintColor.CGColor);
        CGContextFillRect(outputContext, imageRect);
        CGContextRestoreGState(outputContext);
    }
    
    // Output image is ready.
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return outputImage;
}


@end


@implementation UIImage (KKResize)


- (void)drawInSize:(CGSize)size withContentMode:(UIViewContentMode)contentMode clipsToBounds:(BOOL)clips{
    CGRect drawRect = CGRectFitSizeWithContentMode(size, self.size, contentMode);
    if (drawRect.size.width == 0 || drawRect.size.height == 0) return;
    if (clips) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        if (context) {
            CGContextSaveGState(context);
            CGContextAddRect(context, CGZeroXYRectBySize(size));
            CGContextClip(context);
            [self drawInRect:drawRect];
            CGContextRestoreGState(context);
        }
    } else {
        [self drawInRect:drawRect];
    }
}

- (UIImage *)imageByResizeToSize:(CGSize)size contentMode:(UIViewContentMode)contentMode {
    if (size.width <= 0 || size.height <= 0) return nil;
    UIGraphicsBeginImageContextWithOptions(size, NO, self.scale);
    [self drawInSize:size withContentMode:contentMode clipsToBounds:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end

