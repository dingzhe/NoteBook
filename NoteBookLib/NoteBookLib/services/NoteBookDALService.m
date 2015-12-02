//
//  NoteBookDALService.m
//  NoteBookLib
//
//  Created by dz on 15/11/30.
//  Copyright (c) 2015年 dz. All rights reserved.
//

#import "NoteBookDALService.h"

static dispatch_queue_t dalRequestProcessingQueue() {
    static dispatch_queue_t dalRequestProcessingQueue;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dalRequestProcessingQueue = dispatch_queue_create("com.vision.dalRequestProcessingQueue", DISPATCH_QUEUE_CONCURRENT);
    });
    
    return dalRequestProcessingQueue;
}

@implementation NoteBookDALService(private)

- (void) _configSwaggerApi:(SWGApi *) api {
//    api.apiClient.requestSerializer.timeoutInterval = VisionConfig.config.httpRequestTimeoutInterval;
//    api.apiClient.completionQueue = dalRequestProcessingQueue();
}

@end
@implementation NoteBookDALService

+ (instancetype) service {
    static volatile NSMutableDictionary *instanceDict = nil;
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        instanceDict = [[NSMutableDictionary alloc] initWithCapacity:8];
    });
    
    NSString *className = NSStringFromClass(self);
    if (![instanceDict objectForKey:className]) {
        @synchronized(instanceDict) {
            if (![instanceDict objectForKey:className]) {
                NoteBookDALService *api = [[self alloc] init];
                [instanceDict setObject:api forKey:className];
            }
        }
    }
    
    return [instanceDict objectForKey:className];
}


//+ (void) globalConfig {
//    
//    NSURLCache *cache = [[NSURLCache alloc] initWithMemoryCapacity:8*1024*1024
//                                                      diskCapacity:128*1024*1024
//                                                          diskPath:@"vision"];
//    [NSURLCache setSharedURLCache:cache];
//}
//
//+ (BOOL) internetAccessable {
//    return AFNetworkReachabilityStatusNotReachable != AFNetworkReachabilityManager.sharedManager.networkReachabilityStatus;
//}

- (instancetype) init {
    return [super init];
}

- (id) createApiWithClass:(Class)apiClass basePath:(NSString *)basePath {
    SWGApi *result = [apiClass apiWithBasePath:basePath];
    
//    result.apiClient.requestSerializer.timeoutInterval = VisionConfig.config.httpRequestTimeoutInterval;
    result.apiClient.completionQueue = dalRequestProcessingQueue();
    result.delegate = self;
    
    return result;
}

#pragma mark - SWGApiDelegate

- (NSDictionary *) api:(SWGApi *)api defaultHeadersForRequest:(NSString *)request {
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
//    [result setValue:VisionConfig.config.appId forKey:@"appId"];
//    [result setValue:[NSString stringWithFormat:@"%@-%@", VisionConfig.config.appVersion, VisionConfig.config.appBuildString]forKey:@"versionCode"];
    
    return result;
}

@end
