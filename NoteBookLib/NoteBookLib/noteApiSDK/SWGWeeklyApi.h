#import <Foundation/Foundation.h>
#import "SWGAddWeeklyResponses.h"
#import "SWGAddWeeklyRequest.h"
#import "SWGResponses.h"
#import "SWGDelWeeklyRequest.h"
#import "SWGMyWeeklyRequest.h"
#import "SWGMyWeeklyResponses.h"
#import "SWGUpdateWeeklyRequest.h"
#import "SWGUploadFileResponse.h"
#import "SWGFile.h"
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

 添加周报
 添加周报

 @param body 
 

 return type: SWGResponses*
 */
-(NSNumber*) delWeeklyWithBody: (SWGDelWeeklyRequest*) body
    completionHandler: (void (^)(SWGResponses* output, NSError* error))completionBlock;
    


/**

 用户周报列表
 用户周报列表

 @param body 
 

 return type: SWGMyWeeklyResponses*
 */
-(NSNumber*) myWeeklyWithBody: (SWGMyWeeklyRequest*) body
    completionHandler: (void (^)(SWGMyWeeklyResponses* output, NSError* error))completionBlock;
    


/**

 添加周报
 添加周报

 @param body 
 

 return type: SWGResponses*
 */
-(NSNumber*) updateWeeklyWithBody: (SWGUpdateWeeklyRequest*) body
    completionHandler: (void (^)(SWGResponses* output, NSError* error))completionBlock;
    


/**

 上传文件
 

 @param uid 
 @param type 
 @param file 
 

 return type: SWGUploadFileResponse*
 */
-(NSNumber*) uploadFileWithUid: (NSString*) uid type: (NSString*) type file: (SWGFile*) file
    completionHandler: (void (^)(SWGUploadFileResponse* output, NSError* error))completionBlock;
    


/**

 周报列表
 周报列表

 @param body 
 

 return type: SWGWeeklyListResponses*
 */
-(NSNumber*) weeklyListWithBody: (SWGWeeklyListRequest*) body
    completionHandler: (void (^)(SWGWeeklyListResponses* output, NSError* error))completionBlock;
    



@end
