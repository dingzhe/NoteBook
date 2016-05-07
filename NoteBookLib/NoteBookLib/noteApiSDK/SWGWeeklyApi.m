#import "SWGWeeklyApi.h"
#import "SWGFile.h"
#import "SWGQueryParamCollection.h"
#import "SWGAddWeeklyResponses.h"
#import "SWGAddWeeklyRequest.h"
#import "SWGResponses.h"
#import "SWGDelWeeklyRequest.h"
#import "SWGMyWeeklyRequest.h"
#import "SWGMyWeeklyResponses.h"
#import "SWGUpdateWeeklyRequest.h"
#import "SWGUploadFileResponse.h"
#import "SWGFile.h"
#import "SWGWeeklyListResponses.h"
#import "SWGWeeklyListRequest.h"


@implementation SWGWeeklyApi

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



