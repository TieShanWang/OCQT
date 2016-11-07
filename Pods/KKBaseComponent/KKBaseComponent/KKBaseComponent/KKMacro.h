//
//  KKMacro.h
//  KKKit
//
//  Created by MR.KING on 16/7/8.
//  Copyright © 2016年 KING. All rights reserved.
//

#ifndef KKMacro_h
#define KKMacro_h

#define KKDeprecated(message) __deprecated_msg("##message##")

#define KK_IPHONE_OS_VERSINO_MAX_ALLOWED __IPHONE_OS_VERSION_MAX_ALLOWED

// 如果是非OBJC_ARC,线程需要管理内存 see: http://stackoverflow.com/questions/8618632/does-arc-support-dispatch-queues
#if OS_OBJECT_USE_OBJC
#undef KKDispatchQueueRelease
#undef KKDispatchQueueSetterProperty
#define KKDispatchQueueRelease(q)
#define KKDispatchQueueSetterProperty strong
#else
#undef SDDispatchQueueRelease
#undef SDDispatchQueueSetterProperty
#define SDDispatchQueueRelease(q) (dispatch_release(q))
#define SDDispatchQueueSetterProperty assign
#endif


#define dispatch_main_sync_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_sync(dispatch_get_main_queue(), block);\
}

#define dispatch_main_async_safe(block)\
if ([NSThread isMainThread]) {\
block();\
} else {\
dispatch_async(dispatch_get_main_queue(), block);\
}

#define KScreenSize [UIScreen mainScreen].bounds.size
#define KScreenWidth KScreenSize.width
#define KScreenHeight KScreenSize.height

#define KKWeak(obj) __weak typedof(obj) weak##obj = obj;
#define KKWeakSelf KKWeak(self)

#ifndef KP
#define KP(x,y) CGPointMake(x,y)
#endif

#define HEXCOLOR(c)                         [UIColor colorWithRed:((c>>16)&0xFF)/255.0 green:((c>>8)&0xFF)/255.0 blue:(c&0xFF)/255.0 alpha:1.0]


#define RGBCOLOR(r, g, b)       [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r, g, b, a)   [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

#define P(x,y) CGPointMake(x,y)

#endif /* KKMacro_h */
