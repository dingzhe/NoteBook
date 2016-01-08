#import <Foundation/Foundation.h>
#import "SWGArticle.h"
#import "SWGGetArticleByIdRequest.h"
#import "SWGObject.h"
#import "SWGApi.h"


@interface SWGMakeUrlApi: SWGApi

/**

 得到URL
 得到URL

 @param body 
 

 return type: SWGArticle*
 */
-(NSNumber*) makeUrlWithBody: (SWGGetArticleByIdRequest*) body
    completionHandler: (void (^)(SWGArticle* output, NSError* error))completionBlock;
    



@end
