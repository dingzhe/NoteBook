#import <Foundation/Foundation.h>
#import "SWGGetArticleByIdRequest.h"
#import "SWGGetArticleByIdResponse.h"
#import "SWGObject.h"
#import "SWGApi.h"


@interface SWGGetArticleApi: SWGApi

/**

 list products
 The article API

 @param body 
 

 return type: SWGGetArticleByIdResponse*
 */
-(NSNumber*) getArticleByIdWithBody: (SWGGetArticleByIdRequest*) body
    completionHandler: (void (^)(SWGGetArticleByIdResponse* output, NSError* error))completionBlock;
    



@end
