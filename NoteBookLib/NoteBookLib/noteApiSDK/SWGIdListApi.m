#import "SWGIdListApi.h"
#import "SWGFile.h"
#import "SWGQueryParamCollection.h"
#import "SWGGetArticleByIdRequest.h"
#import "SWGIdList.h"


@implementation SWGIdListApi

/*!
 * 得到文章id列表
 * 得到文章id列表
 * \param body 
 * \returns SWGIdList*
 */
-(NSNumber*) getIdListWithBody: (SWGGetArticleByIdRequest*) body
    completionHandler: (void (^)(SWGIdList* output, NSError* error))completionBlock { 
    

    
    // verify the required parameter 'body' is set
    NSAssert(body != nil, @"Missing the required parameter `body` when calling getIdList");
    

    NSMutableString* requestUrl = [NSMutableString stringWithFormat:@"%@/idlist", self.basePath];

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
                             SWGIdList* result = nil;
                             if (data) {
                                 result = [[SWGIdList  alloc]  initWithDictionary:data error:nil];
                             }
                             completionBlock(result , nil);
                             
                           }];
    

    

    
}



@end



