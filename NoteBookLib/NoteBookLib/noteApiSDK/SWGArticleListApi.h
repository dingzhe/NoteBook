#import <Foundation/Foundation.h>
#import "SWGGetArticleByIdRequest.h"
#import "SWGArticleList.h"
#import "SWGObject.h"
#import "SWGApi.h"


@interface SWGArticleListApi: SWGApi

/**

 得到文章列表
 得到文章列表

 @param body 
 

 return type: SWGArticleList*
 */
-(NSNumber*) getArticleListWithBody: (SWGGetArticleByIdRequest*) body
    completionHandler: (void (^)(SWGArticleList* output, NSError* error))completionBlock;
    



@end
