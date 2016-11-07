//
//  KKFactory.h
//  SnsDemo_1418
//
//  Created by xupeng on 14-8-15.
//  Copyright (c) 2014年 zhangcheng. All righUI reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface KKFactory : NSObject


+(NSAttributedString*)changeToAtUItrWithStr:(NSString*)text lineSpace:(CGFloat)lineSpace;
// 创建直接使用的


/*******************UIButton********************/
+(UIButton*)createButtonFrame:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)titleColor bgColor:(UIColor*)bgColor fonUIize:(CGFloat)fonUIize norImageName:(NSString*)norImageName seleImageName:(NSString*)seleImageName target:(id)target sel:(SEL)seletor;


+(UIButton*)createButtonFrame:(CGRect)frame Title:(NSString*)title imageName:(NSString*)imageName targat:(id)target sel:(SEL)sel;

+(UIButton*)createCommonBtnWith:(CGRect)frame title:(NSString*)title targat:(id)target sel:(SEL)sel;

+(UIButton*)createButtonFrame:(CGRect)frame targat:(id)target sel:(SEL)sel;

/*******************UIView********************/
+(UIView*)createViewWithFrame:(CGRect)frame;


/*******************UIImageView********************/
+(UIImageView*)createImageViewFrame:(CGRect)frame imageName:(NSString*)imageName;
+(UIImageView*)createCircleImageViewWith:(CGRect)frame imageName:(NSString*)iamgeName;


/*******************lable********************/
+(UILabel *)createLabelFrame:(CGRect)frame fonUIize:(float)fonUIize Text:(NSString *)text textColor:(UIColor*)textColor bgColor:(UIColor*)bgColor lineSpace:(CGFloat)lineSpace;
+(UILabel *)createLabelFrame:(CGRect)frame font:(float)font Text:(NSString *)text;
+(UILabel*)createLabelFrame:(CGRect)frame font:(float)font Text:(NSString*)text lineSpace:(CGFloat)lineSpace;

+(UILabel*)createLableWithFrame:(CGRect)frame title:(NSString*)title bgClolr:(UIColor*)bgColor fontSize:(NSInteger)fontSize;


/*******************textField********************/
+(UITextField*)createTextFieldFrame:(CGRect)frame Placeholder:(NSString*)placeholder
                           leftView:(UIView*)leftView rightView:(UIView*)rightView BgImageName:(NSString*)bgImageName SecureTextEntry:(BOOL) secureTextEntry returnType:(UIReturnKeyType)returnType keyType:(UIKeyboardType)keyType clearMode:(UITextFieldViewMode)clearButtonMode clearEd:(BOOL)clearsOnBeginEditing;
+(UITextField*)createTextFieldFrame:(CGRect)frame Placeholder:(NSString*)placeholder
                           leftView:(UIView*)leftView  SecureTextEntry:(BOOL)secureTextEntry font:(float)font returnTpye:(UIReturnKeyType)returnType;
+(float)isiOS7;
@end
