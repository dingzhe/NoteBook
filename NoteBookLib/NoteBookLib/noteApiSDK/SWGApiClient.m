#import "SWGApiClient.h"
#import "SWGFile.h"
#import "SWGQueryParamCollection.h"
#import "SWGConfiguration.h"


NSString *const SWGResponseObjectErrorKey = @"SWGResponseObject";

static long requestId = 0;
static NSMutableDictionary *queuedRequestsDict = nil;

#pragma mark -

@implementation SWGApiClient(private)

- (NSString*) _descriptionForRequest:(NSURLRequest*)request {
    return [[request URL] absoluteString];
}

- (void) _logRequestId:(NSNumber*)requestId
               request:(NSURLRequest *)request {
    if (self.logRequests) {
        NSLog(@"[SWGApiClient] request[#%@]: %@", requestId, [self _descriptionForRequest:request]);
    }
}

- (void) _logResponseId:(NSNumber *)requestId
                   data:(id)data
                  error:(NSError *)error {
    if (self.logRequests) {
        if (error) {
            NSLog(@"[SWGApiClient] response[#%@] error: %@ ", requestId, error);
        }
        else {
            NSLog(@"[SWGApiClient] response[#%@] data: %@ ", requestId, data);
        }
    }
}

- (NSNumber *) _genNextRequestId {
    long nextId = 0;

    @synchronized(queuedRequestsDict) {
        nextId = ++requestId;
    }

    return @(nextId);
}

- (void) _queueRequestOperation:(AFHTTPRequestOperation *)requestOperation
                         withId:(NSNumber *) requestId{
    @synchronized(queuedRequestsDict) {
        [queuedRequestsDict setObject:requestOperation forKey:requestId];
    }
}

- (AFHTTPRequestOperation *) _finishRequestWithId:(NSNumber*) requestId {
    AFHTTPRequestOperation *result = nil;

    @synchronized(queuedRequestsDict) {
        result = [queuedRequestsDict objectForKey:requestId];
        if (result) {
            [queuedRequestsDict removeObjectForKey:requestId];
        }
    }

    return result;
}

@end

#pragma mark -

@implementation SWGApiClient

+(SWGApiClient *)sharedClientFromPool:(NSString *)baseUrl {
    SWGApiClient *result = nil;

    @synchronized(self) {
        if (!queuedRequestsDict) {
            queuedRequestsDict = [[NSMutableDictionary alloc]init];
        }

        static NSMutableDictionary *pool = nil;
        if(pool == nil) {
            pool = [[NSMutableDictionary alloc] init];
        }

        result = [pool objectForKey:baseUrl];
        if (!result) {
            result = [[SWGApiClient alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
            [pool setValue:result forKey:baseUrl];
        }
    }

    return result;
}

-(id)initWithBaseURL:(NSURL *)url {
    if (self = [super initWithBaseURL:url]) {
        self.requestSerializer = [AFJSONRequestSerializer serializer];
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }

    return self;
}

/*
 * Detect `Accept` from accepts
 */
+ (NSString *) selectHeaderAccept:(NSArray *)accepts
{
    if (accepts == nil || [accepts count] == 0) {
        return @"application/json";
    }

    NSMutableArray *lowerAccepts = [[NSMutableArray alloc] initWithCapacity:[accepts count]];
    [accepts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [lowerAccepts addObject:[obj lowercaseString]];
    }];


    if ([lowerAccepts containsObject:@"application/json"]) {
        return @"application/json";
    }
    else {
        return [lowerAccepts componentsJoinedByString:@", "];
    }
}

/*
 * Detect `Content-Type` from contentTypes
 */
+ (NSString *) selectHeaderContentType:(NSArray *)contentTypes
{
    if (contentTypes == nil || [contentTypes count] == 0) {
        return @"application/json";
    }

    NSMutableArray *lowerContentTypes = [[NSMutableArray alloc] initWithCapacity:[contentTypes count]];
    [contentTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [lowerContentTypes addObject:[obj lowercaseString]];
    }];

    if ([lowerContentTypes containsObject:@"application/json"]) {
        return @"application/json";
    }
    else {
        return lowerContentTypes[0];
    }
}

+(unsigned long)requestQueueSize {
    return [queuedRequestsDict count];
}

+(NSString*) escape:(id)unescaped {
    if([unescaped isKindOfClass:[NSString class]]){
        return (NSString *)CFBridgingRelease
        (CFURLCreateStringByAddingPercentEscapes(
                                                 NULL,
                                                 (__bridge CFStringRef) unescaped,
                                                 NULL,
                                                 (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                 kCFStringEncodingUTF8));
    }
    else {
        return [NSString stringWithFormat:@"%@", unescaped];
    }
}

-(NSString*) pathWithQueryParamsToString:(NSString*) path
                             queryParams:(NSDictionary*) queryParams {
    NSString * separator = nil;
    int counter = 0;

    NSMutableString * requestUrl = [NSMutableString stringWithFormat:@"%@", path];
    if(queryParams != nil){
        for(NSString * key in [queryParams keyEnumerator]){
            if(counter == 0) separator = @"?";
            else separator = @"&";
            id queryParam = [queryParams valueForKey:key];
            if([queryParam isKindOfClass:[NSString class]]){
                [requestUrl appendString:[NSString stringWithFormat:@"%@%@=%@", separator,
                                          [SWGApiClient escape:key], [SWGApiClient escape:[queryParams valueForKey:key]]]];
            }
            else if([queryParam isKindOfClass:[SWGQueryParamCollection class]]){
                SWGQueryParamCollection * coll = (SWGQueryParamCollection*) queryParam;
                NSArray* values = [coll values];
                NSString* format = [coll format];

                if([format isEqualToString:@"csv"]) {
                    [requestUrl appendString:[NSString stringWithFormat:@"%@%@=%@", separator,
                        [SWGApiClient escape:key], [NSString stringWithFormat:@"%@", [values componentsJoinedByString:@","]]]];

                }
                else if([format isEqualToString:@"tsv"]) {
                    [requestUrl appendString:[NSString stringWithFormat:@"%@%@=%@", separator,
                        [SWGApiClient escape:key], [NSString stringWithFormat:@"%@", [values componentsJoinedByString:@"\t"]]]];

                }
                else if([format isEqualToString:@"pipes"]) {
                    [requestUrl appendString:[NSString stringWithFormat:@"%@%@=%@", separator,
                        [SWGApiClient escape:key], [NSString stringWithFormat:@"%@", [values componentsJoinedByString:@"|"]]]];

                }
                else if([format isEqualToString:@"multi"]) {
                    for(id obj in values) {
                        [requestUrl appendString:[NSString stringWithFormat:@"%@%@=%@", separator,
                            [SWGApiClient escape:key], [NSString stringWithFormat:@"%@", obj]]];
                        counter += 1;
                    }

                }
            }
            else {
                [requestUrl appendString:[NSString stringWithFormat:@"%@%@=%@", separator,
                                          [SWGApiClient escape:key], [NSString stringWithFormat:@"%@", [queryParams valueForKey:key]]]];
            }

            counter += 1;
        }
    }
    return requestUrl;
}

- (void) updateHeaderParams:(NSDictionary *__autoreleasing *)headers
                queryParams:(NSDictionary *__autoreleasing *)querys
           WithAuthSettings:(NSArray *)authSettings {

    if (!authSettings || [authSettings count] == 0) {
        return;
    }

    NSMutableDictionary *headersWithAuth = [NSMutableDictionary dictionaryWithDictionary:*headers];
    NSMutableDictionary *querysWithAuth = [NSMutableDictionary dictionaryWithDictionary:*querys];

    SWGConfiguration *config = [SWGConfiguration sharedConfig];
    for (NSString *auth in authSettings) {
        NSDictionary *authSetting = [[config authSettings] objectForKey:auth];

        if (authSetting) {
            if ([authSetting[@"in"] isEqualToString:@"header"]) {
                [headersWithAuth setObject:authSetting[@"value"] forKey:authSetting[@"key"]];
            }
            else if ([authSetting[@"in"] isEqualToString:@"query"]) {
                [querysWithAuth setObject:authSetting[@"value"] forKey:authSetting[@"key"]];
            }
        }
    }

    *headers = [NSDictionary dictionaryWithDictionary:headersWithAuth];
    *querys = [NSDictionary dictionaryWithDictionary:querysWithAuth];
}

-(NSNumber*)  executeWithPath: (NSString*) path
                       method: (NSString*) method
                  queryParams: (NSDictionary*) queryParams
                         body: (id) body
                 headerParams: (NSDictionary*) headerParams
                 authSettings: (NSArray *) authSettings
           requestContentType: (NSString*) requestContentType
          responseContentType: (NSString*) responseContentType
              completionBlock: (void (^)(id, NSError *))completionBlock {
    // setting response serializer
    if ([responseContentType isEqualToString:@"application/json"]) {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
    }
    else {
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
    }

    // auth setting
    [self updateHeaderParams:&headerParams queryParams:&queryParams WithAuthSettings:authSettings];

    NSMutableURLRequest * request = nil;
    if (body != nil && [body isKindOfClass:[NSArray class]]){
        SWGFile * file;
        NSMutableDictionary * params = [[NSMutableDictionary alloc] init];
        for(id obj in body) {
            if([obj isKindOfClass:[SWGFile class]]) {
                file = (SWGFile*) obj;
                requestContentType = @"multipart/form-data";
            }
            else if([obj isKindOfClass:[NSDictionary class]]) {
                for(NSString * key in obj) {
                    params[key] = obj[key];
                }
            }
        }
        NSString * urlString = [[NSURL URLWithString:path relativeToURL:self.baseURL] absoluteString];

        // request with multipart form
        if([requestContentType isEqualToString:@"multipart/form-data"]) {
            request = [self.requestSerializer multipartFormRequestWithMethod: @"POST"
                                                                   URLString: urlString
                                                                  parameters: nil
                                                   constructingBodyWithBlock: ^(id<AFMultipartFormData> formData) {

                                                       for(NSString * key in params) {
                                                           NSData* data = [params[key] dataUsingEncoding:NSUTF8StringEncoding];
                                                           [formData appendPartWithFormData: data name: key];
                                                       }

                                                       if (file) {
                                                           [formData appendPartWithFileData: [file data]
                                                                                       name: [file paramName]
                                                                                   fileName: [file name]
                                                                                   mimeType: [file mimeType]];
                                                       }

                                                   }
                                                                       error:nil];
        }
        // request with form parameters or json
        else {
            NSString* pathWithQueryParams = [self pathWithQueryParamsToString:path queryParams:queryParams];
            NSString* urlString = [[NSURL URLWithString:pathWithQueryParams relativeToURL:self.baseURL] absoluteString];

            request = [self.requestSerializer requestWithMethod:method
                                                      URLString:urlString
                                                     parameters:params
                                                          error:nil];
        }
    }
    else {
        NSString * pathWithQueryParams = [self pathWithQueryParamsToString:path queryParams:queryParams];
        NSString * urlString = [[NSURL URLWithString:pathWithQueryParams relativeToURL:self.baseURL] absoluteString];

        request = [self.requestSerializer requestWithMethod:method
                                                  URLString:urlString
                                                 parameters:body
                                                      error:nil];
    }

    for(NSString * key in [headerParams keyEnumerator]){
        [request setValue:[headerParams valueForKey:key] forHTTPHeaderField:key];
    }

    NSNumber *requestId = [self _genNextRequestId];

    __weak id weakSelf = self;

    AFHTTPRequestOperation *operation = \
    [self HTTPRequestOperationWithRequest:request
                                  success:^(AFHTTPRequestOperation *operation, id data) {
                                      if([weakSelf _finishRequestWithId:requestId]) {

                                          [weakSelf _logResponseId:requestId
                                                              data:data
                                                             error:nil];

                                          completionBlock(data, nil);
                                      }
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      if([weakSelf _finishRequestWithId:requestId]) {
                                          NSMutableDictionary *userInfo = [error.userInfo mutableCopy];

                                          if(operation.responseObject) {
                                              // Add in the (parsed) response body.
                                              userInfo[SWGResponseObjectErrorKey] = operation.responseObject;
                                          }
                                          NSError *augmentedError = [error initWithDomain:error.domain
                                                                                     code:error.code
                                                                                 userInfo:userInfo];

                                          [weakSelf _logResponseId:requestId
                                                              data:nil
                                                             error:augmentedError];

                                          completionBlock(nil, augmentedError);
                                      }
                                  }
     ];

    [self.operationQueue addOperation:operation];

    [self _queueRequestOperation:operation withId:requestId];
    [self _logRequestId:requestId request:request];

    return requestId;
}

- (void) cancelRequest:(NSNumber*)requestId {
    AFHTTPRequestOperation *operation = [self _finishRequestWithId:requestId];
    [operation cancel];
}

@end