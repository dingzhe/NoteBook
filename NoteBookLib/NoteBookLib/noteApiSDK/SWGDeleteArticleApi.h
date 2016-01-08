#import <Foundation/Foundation.h>
#import "SWGId.h"
#import "SWGAddArticleResponses.h"
#import "SWGObject.h"
#import "SWGApi.h"


@interface SWGDeleteArticleApi: SWGApi

/**

 删除文章
 删除文章

 @param body 
 

 return type: SWGAddArticleResponses*
 */
-(NSNumber*) deleteArticleWithBody: (SWGId*) body
    completionHandler: (void (^)(SWGAddArticleResponses* output, NSError* error))completionBlock;
    



@end
