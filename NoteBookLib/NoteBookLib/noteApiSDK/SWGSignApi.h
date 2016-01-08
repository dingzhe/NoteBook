#import <Foundation/Foundation.h>
#import "SWGSignRequest.h"
#import "SWGSignResponses.h"
#import "SWGObject.h"
#import "SWGApi.h"


@interface SWGSignApi: SWGApi

/**

 登录
 sign in

 @param body 
 

 return type: SWGSignResponses*
 */
-(NSNumber*) signInWithBody: (SWGSignRequest*) body
    completionHandler: (void (^)(SWGSignResponses* output, NSError* error))completionBlock;
    


/**

 注册
 sign up

 @param body 
 

 return type: SWGSignResponses*
 */
-(NSNumber*) signUpWithBody: (SWGSignRequest*) body
    completionHandler: (void (^)(SWGSignResponses* output, NSError* error))completionBlock;
    



@end
