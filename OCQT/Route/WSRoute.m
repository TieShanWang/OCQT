//
//  WSRoute.m
//  OCQT
//
//  Created by KING_KE on 2016/11/8.
//  Copyright © 2016年 kk. All rights reserved.
//

#import "WSRoute.h"

@implementation WSRoute

+ (KKBaseViewController *)homeViewControllerWithID:(NSNumber *)ID
{
    return [self fetchViewControllerWithClassName:@"ViewController" selectorString:@"homeViewControllerWithID:" parameter:ID];
}

+ (KKBaseViewController *)fetchViewControllerWithClassName:(NSString *)className selectorString:(NSString *)selectorString parameter:(id)parameter
{
    Class class = NSClassFromString(className);
    SEL selector = NSSelectorFromString(selectorString);
    IMP imp = [class methodForSelector:selector];
    if (parameter) {
        if ([parameter isKindOfClass:[NSArray class]] && ((NSArray *)parameter).count == 2) {
            KKBaseViewController * (*function)(id, SEL,id,id) = (void *)imp;
            return function(class,selector,[((NSArray *)parameter) firstObject],[((NSArray *)parameter) lastObject]);
        } else if ([parameter isKindOfClass:[NSArray class]] && ((NSArray *)parameter).count == 3) {
            KKBaseViewController * (*function)(id, SEL,id,id,id) = (void *)imp;
            return function(class,selector,[((NSArray *)parameter) firstObject],parameter[1],[((NSArray *)parameter) lastObject]);
        } else {
            KKBaseViewController * (*function)(id, SEL,id) = (void *)imp;
            return function(class,selector,parameter);
        }
    } else {
        KKBaseViewController * (*function)(id, SEL) = (void *)imp;
        return function(class,selector);
    }
}
@end
