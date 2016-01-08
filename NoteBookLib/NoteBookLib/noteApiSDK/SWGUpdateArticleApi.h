#import <Foundation/Foundation.h>
#import "SWGUpdateArticleResponses.h"
#import "SWGArticle.h"
#import "SWGObject.h"
#import "SWGApi.h"


@interface SWGUpdateArticleApi: SWGApi

/**

 修改文章
 修改文章

 @param body 
 

 return type: SWGUpdateArticleResponses*
 */
-(NSNumber*) updateArticleWithBody: (SWGArticle*) body
    completionHandler: (void (^)(SWGUpdateArticleResponses* output, NSError* error))completionBlock;
    



@end
