#import <Foundation/Foundation.h>
#import "SWGAddWeeklyResponses.h"
#import "SWGAddWeeklyRequest.h"
#import "SWGMyWeeklyRequest.h"
#import "SWGMyWeeklyResponses.h"
#import "SWGWeeklyListResponses.h"
#import "SWGWeeklyListRequest.h"
#import "SWGObject.h"
#import "SWGApi.h"


@interface SWGWeeklyApi: SWGApi

/**

 添加周报
 添加周报

 @param body 
 

 return type: SWGAddWeeklyResponses*
 */
-(NSNumber*) addWeeklyWithBody: (SWGAddWeeklyRequest*) body
    completionHandler: (void (^)(SWGAddWeeklyResponses* output, NSError* error))completionBlock;
    


/**

 用户周报列表
 用户周报列表

 @param body 
 

 return type: SWGMyWeeklyResponses*
 */
-(NSNumber*) myWeeklyWithBody: (SWGMyWeeklyRequest*) body
    completionHandler: (void (^)(SWGMyWeeklyResponses* output, NSError* error))completionBlock;
    


/**

 周报列表
 周报列表

 @param body 
 

 return type: SWGWeeklyListResponses*
 */
-(NSNumber*) weeklyListWithBody: (SWGWeeklyListRequest*) body
    completionHandler: (void (^)(SWGWeeklyListResponses* output, NSError* error))completionBlock;
    



@end
