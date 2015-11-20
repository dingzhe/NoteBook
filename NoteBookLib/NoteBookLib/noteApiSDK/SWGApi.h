#import <Foundation/Foundation.h>
#import "SWGApiClient.h"

@protocol SWGApiDelegate;

#pragma mark -

@interface SWGApi : NSObject

@property (nonatomic, strong, readonly) SWGApiClient *apiClient;
@property (nonatomic, strong, readonly) NSString *basePath;
@property (nonatomic, assign) id<SWGApiDelegate> delegate;

+ (instancetype) apiWithBasePath:(NSString *)basePath;

@end

#pragma mark -

@protocol SWGApiDelegate <NSObject>

@optional

- (NSDictionary *) api:(SWGApi *)api defaultHeadersForRequest:(NSString *)request;

@end