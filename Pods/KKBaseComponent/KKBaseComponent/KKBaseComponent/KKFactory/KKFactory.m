//
//  KKFactory.m
//  SnsDemo_1418
//
//  Created by xupeng on 14-8-15.
//  Copyright (c) 2014年 xupeng. All righUI reserved.
//

#import "KKFactory.h"

#import "UIView+KKMethod.h"

@implementation KKFactory

/*******************UIButton********************/

+(UIButton*)createButtonFrame:(CGRect)frame title:(NSString*)title titleColor:(UIColor*)titleColor bgColor:(UIColor*)bgColor fonUIize:(CGFloat)fonUIize norImageName:(NSString*)norImageName seleImageName:(NSString*)seleImageName target:(id)target sel:(SEL)seletor{
    
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = frame;
    
    btn.backgroundColor = bgColor;
    
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    if (title) {
        [btn setTitle:title forState:UIControlStateNormal];
    }
    
    [btn setTitleColor:titleColor forState:UIControlStateNormal];
    
    if (fonUIize > 0) {
        btn .titleLabel.font = [UIFont systemFontOfSize:fonUIize];
    }
    
    if (norImageName) {
        [btn setBackgroundImage:[UIImage imageNamed:norImageName] forState:UIControlStateNormal];
    }
    
    if (seleImageName) {
        [btn setBackgroundImage:[UIImage imageNamed:seleImageName] forState:UIControlStateSelected];
    }
    
    if (target) {
        if ([target respondsToSelector:seletor]) {
            [btn addTarget:target action:seletor forControlEvents:UIControlEventTouchUpInside];
        }
    }else{
        
    }
    return btn;
}


+(UIButton*)createButtonFrame:(CGRect)frame Title:(NSString*)title imageName:(NSString*)imageName targat:(id)target sel:(SEL)sel
{
    return [self createButtonFrame:frame title:title titleColor:[UIColor blackColor] bgColor:[UIColor clearColor] fonUIize:0 norImageName:imageName seleImageName:nil target:target sel:sel];
}

+(UIButton*)createButtonFrame:(CGRect)frame targat:(id)target sel:(SEL)sel{
    return [self createButtonFrame:frame title:nil titleColor:[UIColor blackColor] bgColor:[UIColor clearColor] fonUIize:0 norImageName:nil seleImageName:nil target:target sel:sel];
}


+(UIButton*)createCommonBtnWith:(CGRect)frame title:(NSString*)title targat:(id)target sel:(SEL)sel{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = frame;
    [btn setBackgroundImage:[[UIImage imageNamed:@"btn_blue"] resizableImageWithCapInsets:UIEdgeInsetsMake(10, 10, 10, 10) ]forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn addTarget:target action:sel forControlEvents:UIControlEventTouchUpInside];
    btn.titleLabel.font =[UIFont systemFontOfSize:16];
    return btn;
}






/*******************UIView********************/


+(UIView*)createViewWithFrame:(CGRect)frame
{
//创建View
    UIView*view=[[UIView alloc]initWithFrame:frame];
    //如果手动
    //return [view autorelease];
    return view;

}





/*******************UIImageView********************/
+(UIImageView*)createImageViewFrame:(CGRect)frame imageName:(NSString*)imageName{
    UIImageView*imageView=[[UIImageView alloc]initWithFrame:frame];
    //如果imageName传递是空，虽然不会崩溃，但是打印信息会显示很多GUI错误，所以要判断imageName是否为nil
    if (imageName) {
        imageView.image=[UIImage imageNamed:imageName];
 
    }
    //如果手动
    //return [imageView autorelease];
    imageView.userInteractionEnabled=YES;
    return imageView;
}


+(UIImageView*)createCircleImageViewWith:(CGRect)frame imageName:(NSString*)iamgeName{
    UIImageView * imageV = [[UIImageView alloc]initWithFrame:frame];
    imageV.image = [UIImage imageNamed:iamgeName];
    imageV.layer.masksToBounds = YES;
    imageV.layer.cornerRadius = [imageV kk_width] / 2.0;
    imageV.backgroundColor = [UIColor clearColor];
    return imageV;
}



/*******************lable********************/


+(UILabel *)createLabelFrame:(CGRect)frame fonUIize:(float)fonUIize Text:(NSString *)text textColor:(UIColor*)textColor bgColor:(UIColor*)bgColor lineSpace:(CGFloat)lineSpace{
    
    UILabel*label=[[UILabel alloc]initWithFrame:frame];
    
    
    //设置折行方式，注意设置折行方式以后就无法使用sizeToFit，如果使用，需要设置回默认
    label.lineBreakMode=NSLineBreakByWordWrapping;
    
    
    //设置限制行数 0为不限制行数
    label.numberOfLines=1;
    
    
    //设置字号
    if (fonUIize >0) {
        label.font=[UIFont systemFontOfSize:fonUIize];
    }
    
    
    if (bgColor) {
        label.backgroundColor = bgColor;
    }else{
        label.backgroundColor = [UIColor clearColor];
    }
    
    //设置文字
    if (text) {
        label.text=text;
    }
    
    if (textColor) {
        label.textColor = textColor;
    }else{
        label.textColor = [UIColor blackColor];
    }
    
    if (lineSpace > 0 &&([text length] > 0)) {
        label.numberOfLines = 0;
        
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
        
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:lineSpace];
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
        
        label.attributedText = attributedString;
    }
    
    return label;
}

+(NSAttributedString*)changeToAtUItrWithStr:(NSString*)text lineSpace:(CGFloat)lineSpace{
    if (!text
        ) {
        return nil;
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    
    [paragraphStyle setLineSpacing:lineSpace];
    
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, [text length])];
    
    return  attributedString;
}




+(UILabel *)createLabelFrame:(CGRect)frame font:(float)font Text:(NSString *)text{
    UILabel * lable = [self createLabelFrame:frame fonUIize:font Text:text textColor:[UIColor blackColor] bgColor:[UIColor clearColor] lineSpace:0];
    lable.textAlignment = NSTextAlignmentCenter;
    return lable;
}

/*
 *label  设置行距
 */
+(UILabel*)createLabelFrame:(CGRect)frame font:(float)font Text:(NSString*)text lineSpace:(CGFloat)lineSpace{
    return [self createLabelFrame:frame fonUIize:font Text:text textColor:[UIColor blackColor] bgColor:[UIColor clearColor] lineSpace:lineSpace];
}




+(UILabel*)createLableWithFrame:(CGRect)frame title:(NSString*)title bgClolr:(UIColor*)bgColor fontSize:(NSInteger)fontSize{
    UILabel * lable = [[UILabel alloc]initWithFrame:frame];
    lable.backgroundColor = bgColor;
    lable.text = title;
    lable.font = [UIFont systemFontOfSize:fontSize - 2];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.textColor = [UIColor whiteColor];
    return lable;
}



/*******************textField********************/
/*
 *textField
 */
+(UITextField*)createTextFieldFrame:(CGRect)frame Placeholder:(NSString*)placeholder
                           leftView:(UIView*)leftView rightView:(UIView*)rightView BgImageName:(NSString*)bgImageName SecureTextEntry:(BOOL) secureTextEntry returnType:(UIReturnKeyType)returnType keyType:(UIKeyboardType)keyType clearMode:(UITextFieldViewMode)clearButtonMode clearEd:(BOOL)clearsOnBeginEditing
{
    UITextField*textField = [[UITextField alloc]initWithFrame:frame];
    //默认文字
    if (placeholder) {
        textField.placeholder = placeholder;
    }
    
    //UITextFieldViewMode 控制图案何时出现
    //左边图像
    if (leftView) {
        textField.leftViewMode = UITextFieldViewModeAlways;//一直出现
        textField.leftView = leftView;
    }
    
    //右边图像
    if (rightView) {
        textField.rightViewMode = UITextFieldViewModeAlways;
        textField.rightView = rightView;
    }
    
    //输入框中是否有个叉号，在什么时候显示，用于一次性删除输入框中的内容
    //textField.clearButtonMode = UITextFieldViewModeAlways;
    
    if (bgImageName) {
        [textField setBackground:[UIImage imageNamed:bgImageName]];
    }
    
    //每输入一个字符就变成点 用于密码输入
    if (secureTextEntry) {
        textField.secureTextEntry = secureTextEntry;
    }
    
    //设置键盘的样式
    textField.keyboardType = keyType;
    
    //首字母是否大写
    //textField.autocapitalizationType = UITextAutocapitalizationTypeNone;//不自动大写
    
    //return键变成什么键
    textField.returnKeyType =returnType;
    
    textField.clearButtonMode = clearButtonMode;
    
    textField.clearsOnBeginEditing = clearsOnBeginEditing;
    
    //键盘外观
    //textField.keyboardAppearance=UIKeyboardAppearanceDefault;
    
    return textField;
}

+(UITextField*)createTextFieldFrame:(CGRect)frame Placeholder:(NSString*)placeholder
                           leftView:(UIView*)leftView  SecureTextEntry:(BOOL)secureTextEntry font:(float)font returnTpye:(UIReturnKeyType)returnType{
    

    return [self createTextFieldFrame:frame Placeholder:placeholder leftView:leftView rightView:nil BgImageName:nil SecureTextEntry:secureTextEntry returnType:returnType keyType:UIKeyboardTypeDefault clearMode:UITextFieldViewModeWhileEditing clearEd:NO];
    
}

+(float)isiOS7
{
    if ([[[UIDevice currentDevice]systemVersion]floatValue]>=7.0) {
        return 64;
    }else{
    
        return 44;
    }
}


@end









