#import "SWGGetArticleApi.h"
#import "SWGFile.h"
#import "SWGQueryParamCollection.h"


@implementation SWGGetArticleApi

/*!
 * list products
 * The article API
 * \param _id Tags to filter by
 * \param api Tags to filter by
 * \returns void
 */
-(NSNumber*) getArticleByIdWith_id: (NSString*) _id api: (NSString*) api
    
    completionHandler: (void (^)(NSData *data, NSError* error))completionBlock { 

    
    // verify the required parameter '_id' is set
    NSAssert(_id != nil, @"Missing the required parameter `_id` when calling getArticleById");
    
    // verify the required parameter 'api' is set
    NSAssert(api != nil, @"Missing the required parameter `api` when calling getArticleById");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/api.php", self.basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    if(_id != nil) {
        
        queryParams[@"id"] = _id;
    }
    if(api != nil) {
        
        queryParams[@"api"] = api;
    }
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionary];

    if ([self.delegate respondsToSelector:@selector(api:defaultHeadersForRequest:)]) {
        NSDictionary *defaultHeaders = [self.delegate api:self defaultHeadersForRequest:requestUrl];
        if (defaultHeaders) {
            [headerParams addEntriesFromDictionary:defaultHeaders];
        }
    }

    
    
    // HTTP header `Accept` 
    headerParams[@"Accept"] = [SWGApiClient selectHeaderAccept:@[]];
    if ([headerParams[@"Accept"] length] == 0) {
        [headerParams removeObjectForKey:@"Accept"];
    }

    // response content type
    NSString *responseContentType;
    if ([headerParams objectForKey:@"Accept"]) {
        responseContentType = [headerParams[@"Accept"] componentsSeparatedByString:@", "][0];
    }
    else {
        responseContentType = @"";
    }

    // request content type
    NSString *requestContentType = [SWGApiClient selectHeaderContentType:@[]];

    // Authentication setting
    NSArray *authSettings = @[];
    
    id bodyDictionary = nil;
    
    

    

    

    

    

    

    
    // it's void
    return [self.apiClient executeWithPath: requestUrl
                                method: @"GET"
                           queryParams: queryParams
                                  body: bodyDictionary
                          headerParams: headerParams
                          authSettings: authSettings
                    requestContentType: requestContentType
                   responseContentType: responseContentType
                       completionBlock: ^(NSData *data, NSError *error) {
                            completionBlock(data, error);
                        }];
    
}



@end



