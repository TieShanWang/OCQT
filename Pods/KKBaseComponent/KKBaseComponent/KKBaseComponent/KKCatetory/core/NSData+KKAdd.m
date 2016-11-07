//
//  NSData+KKAdd.m
//  KKBaseComponent
//
//  Created by KING on 2016/10/9.
//  Copyright © 2016年 King. All rights reserved.
//

#import "NSData+KKAdd.h"

@implementation NSData (KKAdd)

- (id)kk_jsonObject{
    id jsonObject = [NSJSONSerialization JSONObjectWithData:self options:NSJSONReadingMutableContainers error:nil];
    return jsonObject ? : nil;
}


- (NSString *)kk_string{
    return [[NSString alloc]initWithData:self encoding:NSUTF8StringEncoding];
}

@end



static unsigned char kPNGSignatureBytes[8] = {0x89, 0x50, 0x4E, 0x47, 0x0D, 0x0A, 0x1A, 0x0A};
static NSData *kPNGSignatureData = nil;

@implementation NSData (KKImageContentType)

- (NSString *)kk_contentImageType{
    uint8_t c;
    [self getBytes:&c length:1];
    switch (c) {
        case 0xFF:
            return @"image/jpeg";
        case 0x89:
            return @"image/png";
        case 0x47:
            return @"image/gif";
        case 0x49:
        case 0x4D:
            return @"image/tiff";
        case 0x52:
            // R as RIFF for WEBP
            if ([self length] < 12) {
                return nil;
            }
            
            NSString *testString = [[NSString alloc] initWithData:[self subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"image/webp";
            }
            
            return nil;
    }
    return nil;
}



-(BOOL) isPngType{
    
    if(!kPNGSignatureData){
        kPNGSignatureData = [NSData dataWithBytes:kPNGSignatureBytes length:8];
    }
    NSUInteger pngSignatureLength = [kPNGSignatureData length];
    if ([self length] >= pngSignatureLength) {
        if ([[self subdataWithRange:NSMakeRange(0, pngSignatureLength)] isEqualToData:kPNGSignatureData]) {
            return YES;
        }
    }
    
    return NO;
}


@end

