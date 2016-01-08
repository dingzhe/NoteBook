#import <Foundation/Foundation.h>
#import "SWGGetArticleByIdRequest.h"
#import "SWGIdList.h"
#import "SWGObject.h"
#import "SWGApi.h"


@interface SWGIdListApi: SWGApi

/**

 得到文章id列表
 得到文章id列表

 @param body 
 

 return type: SWGIdList*
 */
-(NSNumber*) getIdListWithBody: (SWGGetArticleByIdRequest*) body
    completionHandler: (void (^)(SWGIdList* output, NSError* error))completionBlock;
    



@end
