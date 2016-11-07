//
//  NSData+KKAdd.h
//  KKBaseComponent
//
//  Created by KING on 2016/10/9.
//  Copyright © 2016年 King. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (KKAdd)

- (nullable NSString *)kk_jsonObject;

- (nullable NSString *)kk_string;
@end



@interface NSData (KKImageContentType)

/**
 *  Compute the content type for an image data
 *
 *  @return the content type as string (i.e. image/jpeg, image/gif)
 */
- (nullable NSString *)kk_contentImageType;


@end
