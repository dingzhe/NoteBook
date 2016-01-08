#import <Foundation/Foundation.h>
#import "SWGGetArticleByIdRequest.h"
#import "SWGArticleList.h"
#import "SWGObject.h"
#import "SWGApi.h"


@interface SWGAllArticleApi: SWGApi

/**

 得到所有的文章
 得到所有的文章

 @param body 
 

 return type: SWGArticleList*
 */
-(NSNumber*) getAllArticleWithBody: (SWGGetArticleByIdRequest*) body
    completionHandler: (void (^)(SWGArticleList* output, NSError* error))completionBlock;
    



@end
