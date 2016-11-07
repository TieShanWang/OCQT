//
//  NSString+SandBoxPath.m
//  KKKit
//
//  Created by MR.KING on 16/7/8.
//  Copyright © 2016年 KING. All rights reserved.
//

#import "NSString+KKMethod.h"

@implementation NSString (KKTool)

+ (NSString *)hexStringFromColor:(UIColor *)color {
    if (!color) {
        return nil;
    }
    if (CGColorGetNumberOfComponents(color.CGColor) < 4) {
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        color = [UIColor colorWithRed:components[0]
                                green:components[0]
                                 blue:components[0]
                                alpha:components[1]];
    }
    
    if (CGColorSpaceGetModel(CGColorGetColorSpace(color.CGColor)) != kCGColorSpaceModelRGB) {
        return [NSString stringWithFormat:@"#FFFFFF"];
    }
    
    return [NSString stringWithFormat:@"#%02X%02X%02X", (int)((CGColorGetComponents(color.CGColor))[0]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[1]*255.0),
            (int)((CGColorGetComponents(color.CGColor))[2]*255.0)];
}

+ (NSString *)stringWithUUID
{
    CFUUIDRef uuidObj = CFUUIDCreate(nil);//create a new UUID
    
    //get the string representation of the UUID
    NSString *uuidString = (__bridge_transfer NSString *)CFUUIDCreateString(nil, uuidObj);
    
    CFRelease(uuidObj);
    return uuidString;
}

-(NSString *)kk_ridSpace{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

-(BOOL)kk_ctStr:(NSString *)str{
    return kkContainStr(self, str, NSCaseInsensitiveSearch);
}

-(BOOL)kk_ctStrStrit:(NSString*)otherS{
    return kkContainStr(self, otherS, NSLiteralSearch);
}

BOOL kkContainStr(NSString * str ,NSString * beCheck, NSStringCompareOptions options){
    NSRange range = [str rangeOfString:beCheck options:options];
    if (range.location == NSNotFound) {
        return NO;
    }
    return YES;
}

-(BOOL)isKk_Empty{
    return self.isKk_lenZero;
}

-(BOOL)isKk_lenZero{
    return  ([self length] == 0);
}

-(NSString *)characterStrAtIndex:(NSUInteger)index{
    return (self.length > index) ? [NSString stringWithFormat:@"%C", [self characterAtIndex:index]] : nil;
}

@end




@implementation NSString (KKFrame)

/*
 *根据字符串的实际内容的多少 在固定的宽度和字体和行间距的大小，动态的计算出实际的高度
 */
- (CGSize)kk_heightWithWidth:(CGFloat)textWidth
                  fontSize:(CGFloat)fontSize{
    
    if ([self isKk_Empty]) {
        return CGSizeZero;
    }

    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithDictionary:@{
                                                                                 NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
                                                                                 }];
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:dic context:nil];
    
    return rect.size;
}
/*
 *根据字符串的实际内容的多少 在固定的宽度和字体和行间距的大小，动态的计算出实际的高度
 */
- (CGSize)kk_heightWithWidth:(CGFloat)textWidth
                   fontSize:(CGFloat)fontSize
               lineSpacing:(double)lineSpace{
    
    if ([self isKk_Empty]) {
        return CGSizeZero;
    }
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:lineSpace];
    
    NSMutableDictionary * dic = [[NSMutableDictionary alloc]initWithDictionary:@{
                                                                                 NSFontAttributeName:[UIFont systemFontOfSize:fontSize],
                                                                                 NSParagraphStyleAttributeName:paragraphStyle
                                                                                 
                                                                                 }];
    
    CGRect rect = [self boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading|NSStringDrawingTruncatesLastVisibleLine attributes:dic context:nil];
    
    return rect.size;
}

@end


@implementation NSString (KKURL)

-(NSURL *)kk_URL{
    return [NSURL URLWithString:self];
}

-(NSURL *)kk_fileURL{
    return [NSURL fileURLWithPath:self];
}

@end


@implementation NSString (KKSandBoxPath)

#define KKDispatchSyncGlobal(some)\
dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{\
some\
});\

#pragma mark - OC
+(nullable NSString*)kk_cachesDirectory{
    return KKCachesDirectory();
}

+(nullable NSString *)kk_DocDirectory{
    return KKDocDirectory();
}

+(nullable NSString *)kkPrefrenceDirectory{
    return KKPrefrenceDirecory();
}

+(nullable NSString *)kk_temporaryDirectory{
    return KKTemporaryDirectory();
}


-(BOOL)kk_fileIsReadable{
    return KKFileIsReadable(self);
}

-(BOOL)kk_fileIsWritable{
    return KKFileIsWritable(self);
}

-(BOOL)kk_fileIsExecutable{
    return KKFileIsExecutable(self);
}

-(BOOL)kk_fileIsExist{
    return KKFileExist(self);
}

-(void)kk_fileIsExistAndDirectory:(void(^)(BOOL exist, BOOL directory))T{
    KKFileExistAndDirectory(self, T);
}

-(NSString *)kk_docPath{
    return KKDocFullPath(self);
}

-(NSString *)kk_cachesPath{
    return KKCacheFullPath(self);
}



-(void)kk_fileAtts:(void(^)(NSDictionary * att, NSError * error))T{
    KKFileAtts(self, T);
}

-(NSDate*)kk_fileCreateData{
    return KKFileCreateData(self);
}

-(BOOL)kk_fileExpiredWithTimeInterval:(NSTimeInterval)seconds{
    return KKFileExpired(self, seconds);
}



#pragma mark - C

/// file manager
NSFileManager * KKFileManager(void){
    return [NSFileManager defaultManager];
}

/// /Library/Caches
NSString * KKCachesDirectory(void){
    return  [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
}

/// Documents
NSString * KKDocDirectory(void){
    return  [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
}

/// /Library/Prefrence
NSString * KKPrefrenceDirecory(void){
    return  [NSSearchPathForDirectoriesInDomains(NSPreferencePanesDirectory, NSUserDomainMask, YES) firstObject];
}

/// tmp directory
NSString * KKTemporaryDirectory(void){
    return  NSTemporaryDirectory();
}

/* The following methods are of limited utility. Attempting to predicate behavior based on the current state of the filesystem or a particular file on the filesystem is encouraging odd behavior in the face of filesystem race conditions. It's far better to attempt an operation (like loading a file or creating a directory) and handle the error gracefully than it is to try to figure out ahead of time whether the operation will succeed.
 */
/// whether the file at path is readable
BOOL KKFileIsReadable(NSString * path){
    return [[NSFileManager defaultManager] isReadableFileAtPath:path];
}

/// whether the file at path is writable
BOOL KKFileIsWritable(NSString * path){
    return [[NSFileManager defaultManager] isWritableFileAtPath:path];
}

/// whether the file at path is readabel
BOOL KKFileIsExecutable(NSString * path){
    return [[NSFileManager defaultManager] isExecutableFileAtPath:path];
}

/// whether path is exist
BOOL KKFileExist(NSString * path){
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

/// whether path is exist and is a directory
void KKFileExistAndDirectory(NSString * path, void(^T)(BOOL exist, BOOL isDirectory)){
    BOOL isDirectory;
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    if (T) {
        T(exist, isDirectory);
    }
}

/**
 *  combine path
 */
/// Documents/component
NSString * KKDocFullPath(NSString * component){
    return  [KKDocDirectory() stringByAppendingString:component];
}

/// /Library/Caches/component
NSString * KKCacheFullPath(NSString * component){
    return  [KKCachesDirectory() stringByAppendingString:component];
}

/// attributes of special path
void KKFileAtts(NSString * path, void(^T)(NSDictionary * att, NSError * error)){
    KKDispatchSyncGlobal(
                         NSError * error;
                         NSDictionary * dic = [[NSFileManager defaultManager]attributesOfItemAtPath:path error:&error];
                         if (T) {
                             T(dic, error);
                         }
    )
    
}

/// time of special file's create date
NSDate * KKFileCreateData(NSString * path){
    __block NSDictionary * dic;
    KKFileAtts(path, ^(NSDictionary *att, NSError *error) {
        dic = att;
    });
    return dic.fileCreationDate;
}

/// whether file is time out of date
BOOL KKFileExpired(NSString * path, NSTimeInterval seconds){
    NSTimeInterval cha = [[NSDate date] timeIntervalSinceDate:KKFileCreateData(path) ];
    if (cha > seconds) {
        return YES;
    }
    return NO;
}



@end
