//
//  KKSessionManager.m
//  OCQT
//
//  Created by KING_KE on 2016/11/8.
//  Copyright © 2016年 kk. All rights reserved.
//

#import "KKURLSessionManager.h"

#import <KKRequestManager.h>

#import <netinet/in.h>

#import <SystemConfiguration/SCNetworkReachability.h>

#import "KKURLCodeModel.h"

NSString * const KKURLSessionNetWorkUnuseCode = @"KKURLSessionNetNotReachCode";
NSString * const KKURLSessionNetWorkUnuseMessage = @"网络无连接请稍后重试";

NSString * const KKURLSessionErrorKeyPathCode = @"此次网络请求 keyPath 设置有误";

NSString * const KKURLSessionMethodGET = @"GET";
NSString * const KKURLSessionMethodPOST = @"POST";

@interface KKURLSessionManager ()

@property(nonatomic, copy)NSString * baseURL;

@end

@implementation KKURLSessionManager

+ (void)requestPath:(NSString *)path
           parameters:(NSDictionary *)parameters
               method:(NSString *)method
              keyPath:(NSString *)keyPath
      resultClassName:(NSString *)className
        configureTask:(void(^)(id<KKSingle>))configure
{
    [[self shareManager] requestPath:path parameters:parameters method:method keyPath:keyPath resultClassName:className configureTask:configure];
}

+ (instancetype)shareManager
{
    static KKURLSessionManager * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (!manager) {
            manager = [[KKURLSessionManager alloc]init];
        }
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        // set base url
        self.baseURL = @"";
    }
    return self;
}

- (void)requestPath:(NSString *)path
         parameters:(NSDictionary *)parameters
             method:(NSString *)method
            keyPath:(NSString *)keyPath
    resultClassName:(NSString *)className
      configureTask:(void(^)(id<KKSingle>))configure
{
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        KKURLSessionTask * task = [[KKURLSessionTask alloc]init];
        
        if (configure) {
            configure(task);
        }
        
        [task sendRequesting:true];
        
        void (^taskError)() = ^{
            [task sendRequesting:NO];
            
            [task sendErrors:[KKURLCodeModel defaultNetWorkErrorModel]];
        };
        
        if (![self checkNetworkConnection]) {
            
            taskError();
            
            return ;
        }
        
        void (^completion)(id a,id b) = ^(id responseData, NSError *error) {
            if (error) {
                
                taskError();
                
            }else{
                [self dealData:responseData keyPath:keyPath resultClassName:className task:task];
            }
        };
        
        NSDictionary * sendParam = [self getFullParametersWithParams:parameters];
        NSString * requestURL = [self getFullRequesURLWithPath:path];
        
        if ([method isEqualToString:KKURLSessionMethodGET]) {
            [[KKRequestManager defaultManager] GETWithURLStr:requestURL parameters:sendParam completion:completion];
        }else if([method isEqualToString:KKURLSessionMethodPOST]){
            [[KKRequestManager defaultManager] POSTWithURLStr:requestURL parameters:parameters completion:completion];
        }
        
    });
    
}

- (void)dealData:(id)data
         keyPath:(NSString *)keyPath
 resultClassName:(NSString *)className
            task:(KKURLSessionTask *)task
{
    if (keyPath && className && data) {
        
        NSDictionary * sourceData = [(NSString *)data mj_JSONObject];
        
        if (!sourceData) {[task sendRequesting:NO];[task sendData:nil];}
        
        NSDictionary * result;
        
        NSArray * keyPaths = [keyPath componentsSeparatedByString:@"/"];
        
        NSString * tmpKey;
        
        for (int i = 0; i < keyPaths.count; i++) {
            tmpKey = keyPaths[i];
            if (![sourceData.allKeys containsObject:tmpKey]) {
                [task sendRequesting:NO];
                [task sendErrors:[KKURLCodeModel defaultKeyPathErrorModel]];
                return;
            }
            result = [sourceData objectForKey:tmpKey];
            sourceData = result;
        }
        
        [task sendRequesting:NO];
        if (result) {
            Class resultClass = NSClassFromString(className);
            [task sendData:([result isKindOfClass:[NSArray class]]) ? [resultClass mj_objectArrayWithKeyValuesArray:result] : [resultClass mj_objectWithKeyValues:result]];
        }else{
            [task sendData:nil];
        }
        
    }else{
        [task sendRequesting:NO];
        [task sendData:data];
    }
}

- (NSString *)getFullRequesURLWithPath:(NSString *)path
{
    if ([path kk_ctStr:@"http:"] || [path kk_ctStr:@"https:"]) {
        return path;
    }
    return [[self baseURL] stringByAppendingPathComponent:path];
}

- (NSDictionary *)getFullParametersWithParams:(NSDictionary *)param
{
    NSMutableDictionary * dic = [NSMutableDictionary dictionaryWithDictionary:param];
    
    // 这里添加一些基本的、每次都要传输的参数
    
    return [dic copy];
}


- (BOOL)checkNetworkConnection
{
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    if (!didRetrieveFlags) {
        printf("Error. Count not recover network reachability flags\n");
        return NO;
    }
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    return (isReachable && !needsConnection) ? YES : NO;
}
@end

@implementation KKURLSessionTask

@end

