#import <Foundation/Foundation.h>
#import "SWGObject.h"
#import "SWGApi.h"


@interface SWGGetArticleApi: SWGApi

/**

 list products
 The article API

 @param _id Tags to filter by
 @param api Tags to filter by
 

 return type: 
 */
-(NSNumber*) getArticleByIdWith_id: (NSString*) _id api: (NSString*) api
    
    completionHandler: (void (^)(NSData *data, NSError* error))completionBlock;



@end
