#import <Foundation/Foundation.h>
#import "SWGAddNoteGroupResponses.h"
#import "SWGAddNoteGroupRequest.h"
#import "SWGAddWeeklyResponses.h"
#import "SWGAddWeeklyRequest.h"
#import "SWGAlreadyFavoriteBlogResponses.h"
#import "SWGAlreadyFavoriteBlogRequest.h"
#import "SWGResponses.h"
#import "SWGDelWeeklyRequest.h"
#import "SWGFavoriteBlogResponses.h"
#import "SWGFavoriteBlogRequest.h"
#import "SWGFavoriteBlogListResponses.h"
#import "SWGFavoriteBlogListRequest.h"
#import "SWGIsBlogRequest.h"
#import "SWGIsBlogResponses.h"
#import "SWGMyBlogListResponses.h"
#import "SWGMyBlogListRequest.h"
#import "SWGMyWeeklyRequest.h"
#import "SWGMyWeeklyResponses.h"
#import "SWGNoteGroupResponses.h"
#import "SWGNoteGroupRequest.h"
#import "SWGNoteGroupListResponses.h"
#import "SWGNoteGroupListRequest.h"
#import "SWGNoteGroupNameByIdRequest.h"
#import "SWGNoteGroupNameByIdResponses.h"
#import "SWGUserInfo.h"
#import "SWGUserInfoResponses.h"
#import "SWGUpdateWeeklyRequest.h"
#import "SWGUploadFileResponse.h"
#import "SWGFile.h"
#import "SWGUserInfoRequest.h"
#import "SWGWeeklyByIdRequest.h"
#import "SWGWeeklyByIdResponses.h"
#import "SWGWeeklyListResponses.h"
#import "SWGWeeklyListRequest.h"
#import "SWGObject.h"
#import "SWGApi.h"


@interface SWGWeeklyApi: SWGApi

/**

 新添笔记本
 新添笔记本

 @param body 
 

 return type: SWGAddNoteGroupResponses*
 */
-(NSNumber*) addNoteGroupWithBody: (SWGAddNoteGroupRequest*) body
    completionHandler: (void (^)(SWGAddNoteGroupResponses* output, NSError* error))completionBlock;
    


/**

 添加周报
 添加周报

 @param body 
 

 return type: SWGAddWeeklyResponses*
 */
-(NSNumber*) addWeeklyWithBody: (SWGAddWeeklyRequest*) body
    completionHandler: (void (^)(SWGAddWeeklyResponses* output, NSError* error))completionBlock;
    


/**

 判断博客是否已经收藏
 判断博客是否已经收藏

 @param body 
 

 return type: SWGAlreadyFavoriteBlogResponses*
 */
-(NSNumber*) alreadyFavoriteBlogWithBody: (SWGAlreadyFavoriteBlogRequest*) body
    completionHandler: (void (^)(SWGAlreadyFavoriteBlogResponses* output, NSError* error))completionBlock;
    


/**

 添加周报
 添加周报

 @param body 
 

 return type: SWGResponses*
 */
-(NSNumber*) delWeeklyWithBody: (SWGDelWeeklyRequest*) body
    completionHandler: (void (^)(SWGResponses* output, NSError* error))completionBlock;
    


/**

 收藏博客
 收藏博客

 @param body 
 

 return type: SWGFavoriteBlogResponses*
 */
-(NSNumber*) favoriteBlogWithBody: (SWGFavoriteBlogRequest*) body
    completionHandler: (void (^)(SWGFavoriteBlogResponses* output, NSError* error))completionBlock;
    


/**

 收藏博客列表
 收藏博客列表

 @param body 
 

 return type: SWGFavoriteBlogListResponses*
 */
-(NSNumber*) favoriteBlogListWithBody: (SWGFavoriteBlogListRequest*) body
    completionHandler: (void (^)(SWGFavoriteBlogListResponses* output, NSError* error))completionBlock;
    


/**

 设置笔记为博客
 设置笔记为博客

 @param body 
 

 return type: SWGIsBlogResponses*
 */
-(NSNumber*) isBlogWithBody: (SWGIsBlogRequest*) body
    completionHandler: (void (^)(SWGIsBlogResponses* output, NSError* error))completionBlock;
    


/**

 我的博客列表
 我的博客列表

 @param body 
 

 return type: SWGMyBlogListResponses*
 */
-(NSNumber*) myBlogListWithBody: (SWGMyBlogListRequest*) body
    completionHandler: (void (^)(SWGMyBlogListResponses* output, NSError* error))completionBlock;
    


/**

 用户周报列表
 用户周报列表

 @param body 
 

 return type: SWGMyWeeklyResponses*
 */
-(NSNumber*) myWeeklyWithBody: (SWGMyWeeklyRequest*) body
    completionHandler: (void (^)(SWGMyWeeklyResponses* output, NSError* error))completionBlock;
    


/**

 设置笔记分组
 设置笔记分组

 @param body 
 

 return type: SWGNoteGroupResponses*
 */
-(NSNumber*) noteGroupWithBody: (SWGNoteGroupRequest*) body
    completionHandler: (void (^)(SWGNoteGroupResponses* output, NSError* error))completionBlock;
    


/**

 笔记本列表
 笔记本列表

 @param body 
 

 return type: SWGNoteGroupListResponses*
 */
-(NSNumber*) noteGroupListWithBody: (SWGNoteGroupListRequest*) body
    completionHandler: (void (^)(SWGNoteGroupListResponses* output, NSError* error))completionBlock;
    


/**

 设置笔记分组
 设置笔记分组

 @param body 
 

 return type: SWGNoteGroupNameByIdResponses*
 */
-(NSNumber*) noteGroupNameByIdWithBody: (SWGNoteGroupNameByIdRequest*) body
    completionHandler: (void (^)(SWGNoteGroupNameByIdResponses* output, NSError* error))completionBlock;
    


/**

 修改个人信息
 修改个人信息

 @param body 
 

 return type: SWGUserInfoResponses*
 */
-(NSNumber*) updateUserInfoWithBody: (SWGUserInfo*) body
    completionHandler: (void (^)(SWGUserInfoResponses* output, NSError* error))completionBlock;
    


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

 个人信息
 个人信息

 @param body 
 

 return type: SWGUserInfoResponses*
 */
-(NSNumber*) userInfoWithBody: (SWGUserInfoRequest*) body
    completionHandler: (void (^)(SWGUserInfoResponses* output, NSError* error))completionBlock;
    


/**

 根据weekid查询博客内容
 根据weekid查询博客内容

 @param body 
 

 return type: SWGWeeklyByIdResponses*
 */
-(NSNumber*) weeklyByIdWithBody: (SWGWeeklyByIdRequest*) body
    completionHandler: (void (^)(SWGWeeklyByIdResponses* output, NSError* error))completionBlock;
    


/**

 周报列表
 周报列表

 @param body 
 

 return type: SWGWeeklyListResponses*
 */
-(NSNumber*) weeklyListWithBody: (SWGWeeklyListRequest*) body
    completionHandler: (void (^)(SWGWeeklyListResponses* output, NSError* error))completionBlock;
    



@end
