#import <Foundation/Foundation.h>
#import "SWGArticle.h"
#import "SWGAddArticleResponses.h"
#import "SWGObject.h"
#import "SWGApi.h"


@interface SWGAddArticleApi: SWGApi

/**

 添加文章
 添加文章

 @param body 
 

 return type: SWGAddArticleResponses*
 */
-(NSNumber*) addArticleWithBody: (SWGArticle*) body
    completionHandler: (void (^)(SWGAddArticleResponses* output, NSError* error))completionBlock;
    



@end
