//
//  PermissionManager.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSError+PermissionManager.h"
#import "Permission.h"
#import "PermissionRegistry.h"
#import "NSObject+Ext.h"

#define PERMISSION_BEGIN(perm, grant, retry, context) {\
NSString * __permission_perm = (perm); \
BOOL __permission_grant = (grant); \
BOOL __permission_retry = (retry); \
id __permission_context = (context); \
[PermissionManager.manager run:^(id _) {

#define PERMISSION_END \
} \
needPermission:__permission_perm \
elseToGrant:__permission_grant \
grantCallback:nil \
retryAfterGranted:__permission_retry \
context:__permission_context]; \
}

#define PERMISSION_BEGIN_CALLBACK(perm, grant, retry, context) {\
NSString * __permission_perm = (perm); \
BOOL __permission_grant = (grant); \
BOOL __permission_retry = (retry); \
id __permission_context = (context); \
[PermissionManager.manager run:^(id _) { \

#define PERMISSION_CALLBACK_WITH_ERROR \
} \
needPermission:__permission_perm \
elseToGrant:__permission_grant \
grantCallback:^(NSError *error) { \

#define PERMISSION_END_CALLBACK \
} \
retryAfterGranted:__permission_retry \
context:__permission_context]; \
}


#pragma mark -

@interface PermissionManager : NSObject

DEF_SINGLETON(manager)

- (void)         run:(PermissionActionBlock)actionBlock
      needPermission:(NSString *)permission
         elseToGrant:(BOOL) grant
       grantCallback:(PermissionGrantCallBackBlock)grantCallbackBlock
   retryAfterGranted:(BOOL) retry
             context:(id) context;

- (void) registerPermission:(PermissionRegistry *)registry;

- (BOOL) checkPermission:(NSString *)permission context:(id)context;

@end