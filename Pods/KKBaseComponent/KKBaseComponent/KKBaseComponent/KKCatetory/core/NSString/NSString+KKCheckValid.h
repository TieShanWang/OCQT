//
//  NSString+Tool.h
//  SWXY
//
//  Created by MR.KING on 15/12/30.
//  Copyright © 2015年 KK. All righUI reserved.
//

#import <Foundation/Foundation.h>

#import "KKMacro.h"

@interface NSString (KKCheckValid)

#define KKNonatomic NS_NONATOMIC_IOSONLY

/**
 *  检查邮箱是否合格
 */
@property(KKNonatomic,assign,readonly,getter=isKk_ValidEmail)BOOL kk_ValidEmail;

/**
 *  检查手机号是否合格
 */
@property(KKNonatomic,assign,readonly,getter=isKk_ValidMobilPNum)BOOL kk_ValidMobilPNum;


/**
 *  检查座机是否合格
 */
@property(KKNonatomic,assign,readonly,getter=isKk_ValidTelNum)BOOL Kk_ValidTelNum;


/**
 *  检查银行卡是否合格
 */
@property(KKNonatomic,assign,readonly,getter=isKk_ValidBankNum)BOOL kk_ValidBankNum;


/**
 *  检查URL是否合格
 */
@property(KKNonatomic,assign,readonly,getter=isKk_ValidURL)BOOL  kk_validURL;



/**
 *  检查密码是否合格
 */
@property(KKNonatomic,assign,readonly,getter=isKk_ValidPsw)BOOL  kk_ValidPsw;

/**
 *  检查身份证号是否合格
 */
@property(KKNonatomic,assign,readonly,getter=isKk_validIDNum)BOOL  kk_validIDNum;


- (BOOL)checkURL KKDeprecated("user -kk_validURL");
- (NSString *)getRidOfSpace KKDeprecated("user -kk_ridSpace");
- (BOOL)checkLengWithIn:(NSInteger)min max:(NSInteger)max;
- (BOOL)checkPassWord KKDeprecated("user -kk_ValidPsw");
- (BOOL)checkPhoneNumber KKDeprecated("user -kk_ValidMobilPNum");
- (BOOL)checkTelNumber KKDeprecated("user -Kk_ValidTelNum");
- (BOOL)checkUserIdCard KKDeprecated("user -kk_validIDNum");
- (BOOL)checkBankNumCard KKDeprecated("user -kk_ValidBankNum");
- (BOOL)checkEmail KKDeprecated("user -kk_ValidEmail");
- (BOOL)useful KKDeprecated("user -kk_Empty");
@end
