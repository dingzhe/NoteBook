#import "SWGApi.h"

@implementation SWGApi

@dynamic apiClient;
- (SWGApiClient *) apiClient {
    return [SWGApiClient sharedClientFromPool:self.basePath];
}

+ (instancetype) apiWithBasePath:(NSString *)basePath {
    return [[self alloc] initWithBasePath:basePath];
}

- (id) initWithBasePath:(NSString *)basePath {
    if (self = [super init]) {
        _basePath = basePath;

        // force to create api client
        [self apiClient];
    }
    return self;
}

@end