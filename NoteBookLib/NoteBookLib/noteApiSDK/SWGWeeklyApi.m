#import "SWGWeeklyApi.h"
#import "SWGFile.h"
#import "SWGQueryParamCollection.h"
#import "SWGAddNoteGroupResponses.h"
#import "SWGAddNoteGroupRequest.h"
#import "SWGAddWeeklyResponses.h"
#import "SWGAddWeeklyRequest.h"
#import "SWGAlreadyFavoriteBlogResponses.h"
#import "SWGAlreadyFavoriteBlogRequest.h"
#import "SWGResponses.h"
#import "SWGDelWeeklyRequest.h"
#import "SWGFavoriteBlogResponses.h"
#import "SWGFavoriteBlogRequest.h"
#import "SWGFavoriteBlogListResponses.h"
#import "SWGFavoriteBlogListRequest.h"
#import "SWGIsBlogRequest.h"
#import "SWGIsBlogResponses.h"
#import "SWGMyBlogListResponses.h"
#import "SWGMyBlogListRequest.h"
#import "SWGMyWeeklyRequest.h"
#import "SWGMyWeeklyResponses.h"
#import "SWGNoteGroupResponses.h"
#import "SWGNoteGroupRequest.h"
#import "SWGNoteGroupListResponses.h"
#import "SWGNoteGroupListRequest.h"
#import "SWGNoteGroupNameByIdRequest.h"
#import "SWGNoteGroupNameByIdResponses.h"
#import "SWGUserInfo.h"
#import "SWGUserInfoResponses.h"
#import "SWGUpdateWeeklyRequest.h"
#import "SWGUploadFileResponse.h"
#import "SWGFile.h"
#import "SWGUserInfoRequest.h"
#import "SWGWeeklyByIdRequest.h"
#import "SWGWeeklyByIdResponses.h"
#import "SWGWeeklyListResponses.h"
#import "SWGWeeklyListRequest.h"


@implementation SWGWeeklyApi

/*!
 * 新添笔记本
 * 新添笔记本
 * \param body 
 * \returns SWGAddNoteGroupResponses*
 */
-(NSNumber*) addNoteGroupWithBody: (SWGAddNoteGroupRequest*) body
    completionHandler: (void (^)(SWGAddNoteGroupResponses* output, NSError* error))completionBlock { 
    

    
    // verify the required parameter 'body' is set
    NSAssert(body != nil, @"Missing the required parameter `body` when calling addNoteGroup");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/addnotegroup", self.basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
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
    
    id __body = body;

    if(__body != nil && [__body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)__body) {
            if([dict respondsToSelector:@selector(toDictionary)]) {
                [objs addObject:[(SWGObject*)dict toDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([__body respondsToSelector:@selector(toDictionary)]) {
        bodyDictionary = [(SWGObject*)__body toDictionary];
    }
    else if([__body isKindOfClass:[NSString class]]) {
        // convert it to a dictionary
        NSError * error;
        NSString * str = (NSString*)__body;
        NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding: NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
        bodyDictionary = JSON;
    }
    
    

    

    

    
    // non container response

    

    
    // complex response
        
    // comples response type
    return [self.apiClient executeWithPath: requestUrl
                                    method: @"POST"
                               queryParams: queryParams
                                      body: bodyDictionary
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                           completionBlock: ^(NSDictionary *data, NSError *error) {
                             if (error) {
                                 completionBlock(nil, error);
                                 
                                 return;
                             }
                             SWGAddNoteGroupResponses* result = nil;
                             if (data) {
                                 result = [[SWGAddNoteGroupResponses  alloc]  initWithDictionary:data error:nil];
                             }
                             completionBlock(result , nil);
                             
                           }];
    

    

    
}

/*!
 * 添加周报
 * 添加周报
 * \param body 
 * \returns SWGAddWeeklyResponses*
 */
-(NSNumber*) addWeeklyWithBody: (SWGAddWeeklyRequest*) body
    completionHandler: (void (^)(SWGAddWeeklyResponses* output, NSError* error))completionBlock { 
    

    
    // verify the required parameter 'body' is set
    NSAssert(body != nil, @"Missing the required parameter `body` when calling addWeekly");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/addweekly", self.basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
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
    
    id __body = body;

    if(__body != nil && [__body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)__body) {
            if([dict respondsToSelector:@selector(toDictionary)]) {
                [objs addObject:[(SWGObject*)dict toDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([__body respondsToSelector:@selector(toDictionary)]) {
        bodyDictionary = [(SWGObject*)__body toDictionary];
    }
    else if([__body isKindOfClass:[NSString class]]) {
        // convert it to a dictionary
        NSError * error;
        NSString * str = (NSString*)__body;
        NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding: NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
        bodyDictionary = JSON;
    }
    
    

    

    

    
    // non container response

    

    
    // complex response
        
    // comples response type
    return [self.apiClient executeWithPath: requestUrl
                                    method: @"POST"
                               queryParams: queryParams
                                      body: bodyDictionary
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                           completionBlock: ^(NSDictionary *data, NSError *error) {
                             if (error) {
                                 completionBlock(nil, error);
                                 
                                 return;
                             }
                             SWGAddWeeklyResponses* result = nil;
                             if (data) {
                                 result = [[SWGAddWeeklyResponses  alloc]  initWithDictionary:data error:nil];
                             }
                             completionBlock(result , nil);
                             
                           }];
    

    

    
}

/*!
 * 判断博客是否已经收藏
 * 判断博客是否已经收藏
 * \param body 
 * \returns SWGAlreadyFavoriteBlogResponses*
 */
-(NSNumber*) alreadyFavoriteBlogWithBody: (SWGAlreadyFavoriteBlogRequest*) body
    completionHandler: (void (^)(SWGAlreadyFavoriteBlogResponses* output, NSError* error))completionBlock { 
    

    
    // verify the required parameter 'body' is set
    NSAssert(body != nil, @"Missing the required parameter `body` when calling alreadyFavoriteBlog");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/alreadyfavoriteblog", self.basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
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
    
    id __body = body;

    if(__body != nil && [__body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)__body) {
            if([dict respondsToSelector:@selector(toDictionary)]) {
                [objs addObject:[(SWGObject*)dict toDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([__body respondsToSelector:@selector(toDictionary)]) {
        bodyDictionary = [(SWGObject*)__body toDictionary];
    }
    else if([__body isKindOfClass:[NSString class]]) {
        // convert it to a dictionary
        NSError * error;
        NSString * str = (NSString*)__body;
        NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding: NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
        bodyDictionary = JSON;
    }
    
    

    

    

    
    // non container response

    

    
    // complex response
        
    // comples response type
    return [self.apiClient executeWithPath: requestUrl
                                    method: @"POST"
                               queryParams: queryParams
                                      body: bodyDictionary
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                           completionBlock: ^(NSDictionary *data, NSError *error) {
                             if (error) {
                                 completionBlock(nil, error);
                                 
                                 return;
                             }
                             SWGAlreadyFavoriteBlogResponses* result = nil;
                             if (data) {
                                 result = [[SWGAlreadyFavoriteBlogResponses  alloc]  initWithDictionary:data error:nil];
                             }
                             completionBlock(result , nil);
                             
                           }];
    

    

    
}

/*!
 * 添加周报
 * 添加周报
 * \param body 
 * \returns SWGResponses*
 */
-(NSNumber*) delWeeklyWithBody: (SWGDelWeeklyRequest*) body
    completionHandler: (void (^)(SWGResponses* output, NSError* error))completionBlock { 
    

    
    // verify the required parameter 'body' is set
    NSAssert(body != nil, @"Missing the required parameter `body` when calling delWeekly");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/delweekly", self.basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
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
    
    id __body = body;

    if(__body != nil && [__body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)__body) {
            if([dict respondsToSelector:@selector(toDictionary)]) {
                [objs addObject:[(SWGObject*)dict toDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([__body respondsToSelector:@selector(toDictionary)]) {
        bodyDictionary = [(SWGObject*)__body toDictionary];
    }
    else if([__body isKindOfClass:[NSString class]]) {
        // convert it to a dictionary
        NSError * error;
        NSString * str = (NSString*)__body;
        NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding: NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
        bodyDictionary = JSON;
    }
    
    

    

    

    
    // non container response

    

    
    // complex response
        
    // comples response type
    return [self.apiClient executeWithPath: requestUrl
                                    method: @"POST"
                               queryParams: queryParams
                                      body: bodyDictionary
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                           completionBlock: ^(NSDictionary *data, NSError *error) {
                             if (error) {
                                 completionBlock(nil, error);
                                 
                                 return;
                             }
                             SWGResponses* result = nil;
                             if (data) {
                                 result = [[SWGResponses  alloc]  initWithDictionary:data error:nil];
                             }
                             completionBlock(result , nil);
                             
                           }];
    

    

    
}

/*!
 * 收藏博客
 * 收藏博客
 * \param body 
 * \returns SWGFavoriteBlogResponses*
 */
-(NSNumber*) favoriteBlogWithBody: (SWGFavoriteBlogRequest*) body
    completionHandler: (void (^)(SWGFavoriteBlogResponses* output, NSError* error))completionBlock { 
    

    
    // verify the required parameter 'body' is set
    NSAssert(body != nil, @"Missing the required parameter `body` when calling favoriteBlog");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/favoriteblog", self.basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
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
    
    id __body = body;

    if(__body != nil && [__body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)__body) {
            if([dict respondsToSelector:@selector(toDictionary)]) {
                [objs addObject:[(SWGObject*)dict toDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([__body respondsToSelector:@selector(toDictionary)]) {
        bodyDictionary = [(SWGObject*)__body toDictionary];
    }
    else if([__body isKindOfClass:[NSString class]]) {
        // convert it to a dictionary
        NSError * error;
        NSString * str = (NSString*)__body;
        NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding: NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
        bodyDictionary = JSON;
    }
    
    

    

    

    
    // non container response

    

    
    // complex response
        
    // comples response type
    return [self.apiClient executeWithPath: requestUrl
                                    method: @"POST"
                               queryParams: queryParams
                                      body: bodyDictionary
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                           completionBlock: ^(NSDictionary *data, NSError *error) {
                             if (error) {
                                 completionBlock(nil, error);
                                 
                                 return;
                             }
                             SWGFavoriteBlogResponses* result = nil;
                             if (data) {
                                 result = [[SWGFavoriteBlogResponses  alloc]  initWithDictionary:data error:nil];
                             }
                             completionBlock(result , nil);
                             
                           }];
    

    

    
}

/*!
 * 收藏博客列表
 * 收藏博客列表
 * \param body 
 * \returns SWGFavoriteBlogListResponses*
 */
-(NSNumber*) favoriteBlogListWithBody: (SWGFavoriteBlogListRequest*) body
    completionHandler: (void (^)(SWGFavoriteBlogListResponses* output, NSError* error))completionBlock { 
    

    
    // verify the required parameter 'body' is set
    NSAssert(body != nil, @"Missing the required parameter `body` when calling favoriteBlogList");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/favoritebloglist", self.basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
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
    
    id __body = body;

    if(__body != nil && [__body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)__body) {
            if([dict respondsToSelector:@selector(toDictionary)]) {
                [objs addObject:[(SWGObject*)dict toDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([__body respondsToSelector:@selector(toDictionary)]) {
        bodyDictionary = [(SWGObject*)__body toDictionary];
    }
    else if([__body isKindOfClass:[NSString class]]) {
        // convert it to a dictionary
        NSError * error;
        NSString * str = (NSString*)__body;
        NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding: NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
        bodyDictionary = JSON;
    }
    
    

    

    

    
    // non container response

    

    
    // complex response
        
    // comples response type
    return [self.apiClient executeWithPath: requestUrl
                                    method: @"POST"
                               queryParams: queryParams
                                      body: bodyDictionary
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                           completionBlock: ^(NSDictionary *data, NSError *error) {
                             if (error) {
                                 completionBlock(nil, error);
                                 
                                 return;
                             }
                             SWGFavoriteBlogListResponses* result = nil;
                             if (data) {
                                 result = [[SWGFavoriteBlogListResponses  alloc]  initWithDictionary:data error:nil];
                             }
                             completionBlock(result , nil);
                             
                           }];
    

    

    
}

/*!
 * 设置笔记为博客
 * 设置笔记为博客
 * \param body 
 * \returns SWGIsBlogResponses*
 */
-(NSNumber*) isBlogWithBody: (SWGIsBlogRequest*) body
    completionHandler: (void (^)(SWGIsBlogResponses* output, NSError* error))completionBlock { 
    

    
    // verify the required parameter 'body' is set
    NSAssert(body != nil, @"Missing the required parameter `body` when calling isBlog");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/isblog", self.basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
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
    
    id __body = body;

    if(__body != nil && [__body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)__body) {
            if([dict respondsToSelector:@selector(toDictionary)]) {
                [objs addObject:[(SWGObject*)dict toDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([__body respondsToSelector:@selector(toDictionary)]) {
        bodyDictionary = [(SWGObject*)__body toDictionary];
    }
    else if([__body isKindOfClass:[NSString class]]) {
        // convert it to a dictionary
        NSError * error;
        NSString * str = (NSString*)__body;
        NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding: NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
        bodyDictionary = JSON;
    }
    
    

    

    

    
    // non container response

    

    
    // complex response
        
    // comples response type
    return [self.apiClient executeWithPath: requestUrl
                                    method: @"POST"
                               queryParams: queryParams
                                      body: bodyDictionary
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                           completionBlock: ^(NSDictionary *data, NSError *error) {
                             if (error) {
                                 completionBlock(nil, error);
                                 
                                 return;
                             }
                             SWGIsBlogResponses* result = nil;
                             if (data) {
                                 result = [[SWGIsBlogResponses  alloc]  initWithDictionary:data error:nil];
                             }
                             completionBlock(result , nil);
                             
                           }];
    

    

    
}

/*!
 * 我的博客列表
 * 我的博客列表
 * \param body 
 * \returns SWGMyBlogListResponses*
 */
-(NSNumber*) myBlogListWithBody: (SWGMyBlogListRequest*) body
    completionHandler: (void (^)(SWGMyBlogListResponses* output, NSError* error))completionBlock { 
    

    
    // verify the required parameter 'body' is set
    NSAssert(body != nil, @"Missing the required parameter `body` when calling myBlogList");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/mybloglist", self.basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
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
    
    id __body = body;

    if(__body != nil && [__body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)__body) {
            if([dict respondsToSelector:@selector(toDictionary)]) {
                [objs addObject:[(SWGObject*)dict toDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([__body respondsToSelector:@selector(toDictionary)]) {
        bodyDictionary = [(SWGObject*)__body toDictionary];
    }
    else if([__body isKindOfClass:[NSString class]]) {
        // convert it to a dictionary
        NSError * error;
        NSString * str = (NSString*)__body;
        NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding: NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
        bodyDictionary = JSON;
    }
    
    

    

    

    
    // non container response

    

    
    // complex response
        
    // comples response type
    return [self.apiClient executeWithPath: requestUrl
                                    method: @"POST"
                               queryParams: queryParams
                                      body: bodyDictionary
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                           completionBlock: ^(NSDictionary *data, NSError *error) {
                             if (error) {
                                 completionBlock(nil, error);
                                 
                                 return;
                             }
                             SWGMyBlogListResponses* result = nil;
                             if (data) {
                                 result = [[SWGMyBlogListResponses  alloc]  initWithDictionary:data error:nil];
                             }
                             completionBlock(result , nil);
                             
                           }];
    

    

    
}

/*!
 * 用户周报列表
 * 用户周报列表
 * \param body 
 * \returns SWGMyWeeklyResponses*
 */
-(NSNumber*) myWeeklyWithBody: (SWGMyWeeklyRequest*) body
    completionHandler: (void (^)(SWGMyWeeklyResponses* output, NSError* error))completionBlock { 
    

    
    // verify the required parameter 'body' is set
    NSAssert(body != nil, @"Missing the required parameter `body` when calling myWeekly");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/myweekly", self.basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
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
    
    id __body = body;

    if(__body != nil && [__body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)__body) {
            if([dict respondsToSelector:@selector(toDictionary)]) {
                [objs addObject:[(SWGObject*)dict toDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([__body respondsToSelector:@selector(toDictionary)]) {
        bodyDictionary = [(SWGObject*)__body toDictionary];
    }
    else if([__body isKindOfClass:[NSString class]]) {
        // convert it to a dictionary
        NSError * error;
        NSString * str = (NSString*)__body;
        NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding: NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
        bodyDictionary = JSON;
    }
    
    

    

    

    
    // non container response

    

    
    // complex response
        
    // comples response type
    return [self.apiClient executeWithPath: requestUrl
                                    method: @"POST"
                               queryParams: queryParams
                                      body: bodyDictionary
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                           completionBlock: ^(NSDictionary *data, NSError *error) {
                             if (error) {
                                 completionBlock(nil, error);
                                 
                                 return;
                             }
                             SWGMyWeeklyResponses* result = nil;
                             if (data) {
                                 result = [[SWGMyWeeklyResponses  alloc]  initWithDictionary:data error:nil];
                             }
                             completionBlock(result , nil);
                             
                           }];
    

    

    
}

/*!
 * 设置笔记分组
 * 设置笔记分组
 * \param body 
 * \returns SWGNoteGroupResponses*
 */
-(NSNumber*) noteGroupWithBody: (SWGNoteGroupRequest*) body
    completionHandler: (void (^)(SWGNoteGroupResponses* output, NSError* error))completionBlock { 
    

    
    // verify the required parameter 'body' is set
    NSAssert(body != nil, @"Missing the required parameter `body` when calling noteGroup");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/notegroup", self.basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
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
    
    id __body = body;

    if(__body != nil && [__body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)__body) {
            if([dict respondsToSelector:@selector(toDictionary)]) {
                [objs addObject:[(SWGObject*)dict toDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([__body respondsToSelector:@selector(toDictionary)]) {
        bodyDictionary = [(SWGObject*)__body toDictionary];
    }
    else if([__body isKindOfClass:[NSString class]]) {
        // convert it to a dictionary
        NSError * error;
        NSString * str = (NSString*)__body;
        NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding: NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
        bodyDictionary = JSON;
    }
    
    

    

    

    
    // non container response

    

    
    // complex response
        
    // comples response type
    return [self.apiClient executeWithPath: requestUrl
                                    method: @"POST"
                               queryParams: queryParams
                                      body: bodyDictionary
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                           completionBlock: ^(NSDictionary *data, NSError *error) {
                             if (error) {
                                 completionBlock(nil, error);
                                 
                                 return;
                             }
                             SWGNoteGroupResponses* result = nil;
                             if (data) {
                                 result = [[SWGNoteGroupResponses  alloc]  initWithDictionary:data error:nil];
                             }
                             completionBlock(result , nil);
                             
                           }];
    

    

    
}

/*!
 * 笔记本列表
 * 笔记本列表
 * \param body 
 * \returns SWGNoteGroupListResponses*
 */
-(NSNumber*) noteGroupListWithBody: (SWGNoteGroupListRequest*) body
    completionHandler: (void (^)(SWGNoteGroupListResponses* output, NSError* error))completionBlock { 
    

    
    // verify the required parameter 'body' is set
    NSAssert(body != nil, @"Missing the required parameter `body` when calling noteGroupList");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/notegrouplist", self.basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
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
    
    id __body = body;

    if(__body != nil && [__body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)__body) {
            if([dict respondsToSelector:@selector(toDictionary)]) {
                [objs addObject:[(SWGObject*)dict toDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([__body respondsToSelector:@selector(toDictionary)]) {
        bodyDictionary = [(SWGObject*)__body toDictionary];
    }
    else if([__body isKindOfClass:[NSString class]]) {
        // convert it to a dictionary
        NSError * error;
        NSString * str = (NSString*)__body;
        NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding: NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
        bodyDictionary = JSON;
    }
    
    

    

    

    
    // non container response

    

    
    // complex response
        
    // comples response type
    return [self.apiClient executeWithPath: requestUrl
                                    method: @"POST"
                               queryParams: queryParams
                                      body: bodyDictionary
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                           completionBlock: ^(NSDictionary *data, NSError *error) {
                             if (error) {
                                 completionBlock(nil, error);
                                 
                                 return;
                             }
                             SWGNoteGroupListResponses* result = nil;
                             if (data) {
                                 result = [[SWGNoteGroupListResponses  alloc]  initWithDictionary:data error:nil];
                             }
                             completionBlock(result , nil);
                             
                           }];
    

    

    
}

/*!
 * 设置笔记分组
 * 设置笔记分组
 * \param body 
 * \returns SWGNoteGroupNameByIdResponses*
 */
-(NSNumber*) noteGroupNameByIdWithBody: (SWGNoteGroupNameByIdRequest*) body
    completionHandler: (void (^)(SWGNoteGroupNameByIdResponses* output, NSError* error))completionBlock { 
    

    
    // verify the required parameter 'body' is set
    NSAssert(body != nil, @"Missing the required parameter `body` when calling noteGroupNameById");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/notegroupnamebyid", self.basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
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
    
    id __body = body;

    if(__body != nil && [__body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)__body) {
            if([dict respondsToSelector:@selector(toDictionary)]) {
                [objs addObject:[(SWGObject*)dict toDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([__body respondsToSelector:@selector(toDictionary)]) {
        bodyDictionary = [(SWGObject*)__body toDictionary];
    }
    else if([__body isKindOfClass:[NSString class]]) {
        // convert it to a dictionary
        NSError * error;
        NSString * str = (NSString*)__body;
        NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding: NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
        bodyDictionary = JSON;
    }
    
    

    

    

    
    // non container response

    

    
    // complex response
        
    // comples response type
    return [self.apiClient executeWithPath: requestUrl
                                    method: @"POST"
                               queryParams: queryParams
                                      body: bodyDictionary
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                           completionBlock: ^(NSDictionary *data, NSError *error) {
                             if (error) {
                                 completionBlock(nil, error);
                                 
                                 return;
                             }
                             SWGNoteGroupNameByIdResponses* result = nil;
                             if (data) {
                                 result = [[SWGNoteGroupNameByIdResponses  alloc]  initWithDictionary:data error:nil];
                             }
                             completionBlock(result , nil);
                             
                           }];
    

    

    
}

/*!
 * 修改个人信息
 * 修改个人信息
 * \param body 
 * \returns SWGUserInfoResponses*
 */
-(NSNumber*) updateUserInfoWithBody: (SWGUserInfo*) body
    completionHandler: (void (^)(SWGUserInfoResponses* output, NSError* error))completionBlock { 
    

    
    // verify the required parameter 'body' is set
    NSAssert(body != nil, @"Missing the required parameter `body` when calling updateUserInfo");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/updateuserinfo", self.basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
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
    
    id __body = body;

    if(__body != nil && [__body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)__body) {
            if([dict respondsToSelector:@selector(toDictionary)]) {
                [objs addObject:[(SWGObject*)dict toDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([__body respondsToSelector:@selector(toDictionary)]) {
        bodyDictionary = [(SWGObject*)__body toDictionary];
    }
    else if([__body isKindOfClass:[NSString class]]) {
        // convert it to a dictionary
        NSError * error;
        NSString * str = (NSString*)__body;
        NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding: NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
        bodyDictionary = JSON;
    }
    
    

    

    

    
    // non container response

    

    
    // complex response
        
    // comples response type
    return [self.apiClient executeWithPath: requestUrl
                                    method: @"POST"
                               queryParams: queryParams
                                      body: bodyDictionary
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                           completionBlock: ^(NSDictionary *data, NSError *error) {
                             if (error) {
                                 completionBlock(nil, error);
                                 
                                 return;
                             }
                             SWGUserInfoResponses* result = nil;
                             if (data) {
                                 result = [[SWGUserInfoResponses  alloc]  initWithDictionary:data error:nil];
                             }
                             completionBlock(result , nil);
                             
                           }];
    

    

    
}

/*!
 * 添加周报
 * 添加周报
 * \param body 
 * \returns SWGResponses*
 */
-(NSNumber*) updateWeeklyWithBody: (SWGUpdateWeeklyRequest*) body
    completionHandler: (void (^)(SWGResponses* output, NSError* error))completionBlock { 
    

    
    // verify the required parameter 'body' is set
    NSAssert(body != nil, @"Missing the required parameter `body` when calling updateWeekly");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/updateweekly", self.basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
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
    
    id __body = body;

    if(__body != nil && [__body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)__body) {
            if([dict respondsToSelector:@selector(toDictionary)]) {
                [objs addObject:[(SWGObject*)dict toDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([__body respondsToSelector:@selector(toDictionary)]) {
        bodyDictionary = [(SWGObject*)__body toDictionary];
    }
    else if([__body isKindOfClass:[NSString class]]) {
        // convert it to a dictionary
        NSError * error;
        NSString * str = (NSString*)__body;
        NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding: NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
        bodyDictionary = JSON;
    }
    
    

    

    

    
    // non container response

    

    
    // complex response
        
    // comples response type
    return [self.apiClient executeWithPath: requestUrl
                                    method: @"POST"
                               queryParams: queryParams
                                      body: bodyDictionary
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                           completionBlock: ^(NSDictionary *data, NSError *error) {
                             if (error) {
                                 completionBlock(nil, error);
                                 
                                 return;
                             }
                             SWGResponses* result = nil;
                             if (data) {
                                 result = [[SWGResponses  alloc]  initWithDictionary:data error:nil];
                             }
                             completionBlock(result , nil);
                             
                           }];
    

    

    
}

/*!
 * 上传文件
 * 
 * \param uid 
 * \param type 
 * \param file 
 * \returns SWGUploadFileResponse*
 */
-(NSNumber*) uploadFileWithUid: (NSString*) uid type: (NSString*) type file: (SWGFile*) file
    completionHandler: (void (^)(SWGUploadFileResponse* output, NSError* error))completionBlock { 
    

    
    // verify the required parameter 'file' is set
    NSAssert(file != nil, @"Missing the required parameter `file` when calling uploadFile");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/uploadfile", self.basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary* headerParams = [NSMutableDictionary dictionary];

    if ([self.delegate respondsToSelector:@selector(api:defaultHeadersForRequest:)]) {
        NSDictionary *defaultHeaders = [self.delegate api:self defaultHeadersForRequest:requestUrl];
        if (defaultHeaders) {
            [headerParams addEntriesFromDictionary:defaultHeaders];
        }
    }

    
    
    // HTTP header `Accept` 
    headerParams[@"Accept"] = [SWGApiClient selectHeaderAccept:@[@"application/json", @"application/xml"]];
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
    NSString *requestContentType = [SWGApiClient selectHeaderContentType:@[@"application/x-www-form-urlencoded"]];

    // Authentication setting
    NSArray *authSettings = @[];
    
    id bodyDictionary = nil;
    
    

    
    if(bodyDictionary == nil) {
        bodyDictionary = [[NSMutableArray alloc] init];
    }

    
    NSMutableDictionary * formParams = [[NSMutableDictionary alloc]init];
    formParams[@"uid"] = uid;

    [bodyDictionary addObject:formParams];
    
    
    
    if(bodyDictionary == nil) {
        bodyDictionary = [[NSMutableArray alloc] init];
    }

    
//    NSMutableDictionary * formParams = [[NSMutableDictionary alloc]init];
    formParams[@"type"] = type;

    [bodyDictionary addObject:formParams];
    
    
    
    if(bodyDictionary == nil) {
        bodyDictionary = [[NSMutableArray alloc] init];
    }

    
    
    requestContentType = @"multipart/form-data";

    if(file != nil) {
        file.paramName = @"file";
        [bodyDictionary addObject:file];
    }
    
    

    

    

    

    
    // non container response

    

    
    // complex response
        
    // comples response type
    return [self.apiClient executeWithPath: requestUrl
                                    method: @"POST"
                               queryParams: queryParams
                                      body: bodyDictionary
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                           completionBlock: ^(NSDictionary *data, NSError *error) {
                             if (error) {
                                 completionBlock(nil, error);
                                 
                                 return;
                             }
                             SWGUploadFileResponse* result = nil;
                             if (data) {
                                 result = [[SWGUploadFileResponse  alloc]  initWithDictionary:data error:nil];
                             }
                             completionBlock(result , nil);
                             
                           }];
    

    

    
}

/*!
 * 个人信息
 * 个人信息
 * \param body 
 * \returns SWGUserInfoResponses*
 */
-(NSNumber*) userInfoWithBody: (SWGUserInfoRequest*) body
    completionHandler: (void (^)(SWGUserInfoResponses* output, NSError* error))completionBlock { 
    

    
    // verify the required parameter 'body' is set
    NSAssert(body != nil, @"Missing the required parameter `body` when calling userInfo");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/userinfo", self.basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
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
    
    id __body = body;

    if(__body != nil && [__body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)__body) {
            if([dict respondsToSelector:@selector(toDictionary)]) {
                [objs addObject:[(SWGObject*)dict toDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([__body respondsToSelector:@selector(toDictionary)]) {
        bodyDictionary = [(SWGObject*)__body toDictionary];
    }
    else if([__body isKindOfClass:[NSString class]]) {
        // convert it to a dictionary
        NSError * error;
        NSString * str = (NSString*)__body;
        NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding: NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
        bodyDictionary = JSON;
    }
    
    

    

    

    
    // non container response

    

    
    // complex response
        
    // comples response type
    return [self.apiClient executeWithPath: requestUrl
                                    method: @"POST"
                               queryParams: queryParams
                                      body: bodyDictionary
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                           completionBlock: ^(NSDictionary *data, NSError *error) {
                             if (error) {
                                 completionBlock(nil, error);
                                 
                                 return;
                             }
                             SWGUserInfoResponses* result = nil;
                             if (data) {
                                 result = [[SWGUserInfoResponses  alloc]  initWithDictionary:data error:nil];
                             }
                             completionBlock(result , nil);
                             
                           }];
    

    

    
}

/*!
 * 根据weekid查询博客内容
 * 根据weekid查询博客内容
 * \param body 
 * \returns SWGWeeklyByIdResponses*
 */
-(NSNumber*) weeklyByIdWithBody: (SWGWeeklyByIdRequest*) body
    completionHandler: (void (^)(SWGWeeklyByIdResponses* output, NSError* error))completionBlock { 
    

    
    // verify the required parameter 'body' is set
    NSAssert(body != nil, @"Missing the required parameter `body` when calling weeklyById");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/weeklybyid", self.basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
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
    
    id __body = body;

    if(__body != nil && [__body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)__body) {
            if([dict respondsToSelector:@selector(toDictionary)]) {
                [objs addObject:[(SWGObject*)dict toDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([__body respondsToSelector:@selector(toDictionary)]) {
        bodyDictionary = [(SWGObject*)__body toDictionary];
    }
    else if([__body isKindOfClass:[NSString class]]) {
        // convert it to a dictionary
        NSError * error;
        NSString * str = (NSString*)__body;
        NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding: NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
        bodyDictionary = JSON;
    }
    
    

    

    

    
    // non container response

    

    
    // complex response
        
    // comples response type
    return [self.apiClient executeWithPath: requestUrl
                                    method: @"POST"
                               queryParams: queryParams
                                      body: bodyDictionary
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                           completionBlock: ^(NSDictionary *data, NSError *error) {
                             if (error) {
                                 completionBlock(nil, error);
                                 
                                 return;
                             }
                             SWGWeeklyByIdResponses* result = nil;
                             if (data) {
                                 result = [[SWGWeeklyByIdResponses  alloc]  initWithDictionary:data error:nil];
                             }
                             completionBlock(result , nil);
                             
                           }];
    

    

    
}

/*!
 * 周报列表
 * 周报列表
 * \param body 
 * \returns SWGWeeklyListResponses*
 */
-(NSNumber*) weeklyListWithBody: (SWGWeeklyListRequest*) body
    completionHandler: (void (^)(SWGWeeklyListResponses* output, NSError* error))completionBlock { 
    

    
    // verify the required parameter 'body' is set
    NSAssert(body != nil, @"Missing the required parameter `body` when calling weeklyList");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/weeklylist", self.basePath];

    // remove format in URL if needed
    if ([requestUrl rangeOfString:@".{format}"].location != NSNotFound)
        [requestUrl replaceCharactersInRange: [requestUrl rangeOfString:@".{format}"] withString:@".json"];

    

    NSMutableDictionary* queryParams = [[NSMutableDictionary alloc] init];
    
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
    
    id __body = body;

    if(__body != nil && [__body isKindOfClass:[NSArray class]]){
        NSMutableArray * objs = [[NSMutableArray alloc] init];
        for (id dict in (NSArray*)__body) {
            if([dict respondsToSelector:@selector(toDictionary)]) {
                [objs addObject:[(SWGObject*)dict toDictionary]];
            }
            else{
                [objs addObject:dict];
            }
        }
        bodyDictionary = objs;
    }
    else if([__body respondsToSelector:@selector(toDictionary)]) {
        bodyDictionary = [(SWGObject*)__body toDictionary];
    }
    else if([__body isKindOfClass:[NSString class]]) {
        // convert it to a dictionary
        NSError * error;
        NSString * str = (NSString*)__body;
        NSDictionary *JSON =
            [NSJSONSerialization JSONObjectWithData: [str dataUsingEncoding: NSUTF8StringEncoding]
                                            options: NSJSONReadingMutableContainers
                                              error: &error];
        bodyDictionary = JSON;
    }
    
    

    

    

    
    // non container response

    

    
    // complex response
        
    // comples response type
    return [self.apiClient executeWithPath: requestUrl
                                    method: @"POST"
                               queryParams: queryParams
                                      body: bodyDictionary
                              headerParams: headerParams
                              authSettings: authSettings
                        requestContentType: requestContentType
                       responseContentType: responseContentType
                           completionBlock: ^(NSDictionary *data, NSError *error) {
                             if (error) {
                                 completionBlock(nil, error);
                                 
                                 return;
                             }
                             SWGWeeklyListResponses* result = nil;
                             if (data) {
                                 result = [[SWGWeeklyListResponses  alloc]  initWithDictionary:data error:nil];
                             }
                             completionBlock(result , nil);
                             
                           }];
    

    

    
}



@end



