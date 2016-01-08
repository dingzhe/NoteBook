#import <Foundation/Foundation.h>
#import "SWGArticle.h"
#import "SWGGetArticleByIdRequest.h"
#import "SWGObject.h"
#import "SWGApi.h"


@interface SWGGetArticleApi: SWGApi

/**

 根据id得到文章
 根据id得到文章

 @param body 
 

 return type: SWGArticle*
 */
-(NSNumber*) getArticleByIdWithBody: (SWGGetArticleByIdRequest*) body
    completionHandler: (void (^)(SWGArticle* output, NSError* error))completionBlock;
    



@end
