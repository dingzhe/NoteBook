//
//  PermissionManager.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "PermissionManager.h"
#import "Permission.h"
#import "Permission+private.h"

#define ASSERT_MAIN_THREAD NSAssert([NSThread isMainThread], @"This action MUST be run in main thread");

@interface PermissionManager() {
    NSMutableDictionary *_permissionDict;
}

@end
@implementation PermissionManager
BEGIN_IMP_SINGLETON(manager, PermissionManager)
instance = [[PermissionManager alloc] init];
instance -> _permissionDict = [NSMutableDictionary dictionaryWithCapacity:8];
END_IMP_SINGLETON

- (void)         run:(PermissionActionBlock)actionBlock
      needPermission:(NSString *)permission
         elseToGrant:(BOOL) grant
       grantCallback:(PermissionGrantCallBackBlock)grantCallbackBlock
   retryAfterGranted:(BOOL) retry
             context:(id)context {
    ASSERT_MAIN_THREAD
    NSAssert(actionBlock, @"actionBlock should not be nil");
    
    Permission *perm = _permissionDict[permission];
    NSAssert(perm, @"permission has not been registered: %@", permission);
    
    @weakify(perm)
    
    BOOL run = perm.ifBlock ? perm.ifBlock(context) : YES;
    if (run) {
        actionBlock(context);
    }
    else if (grant) {
        if(retry || grantCallbackBlock) {
            [perm addPendingActionBlock:retry ? actionBlock : nil
                          grantCallback:grantCallbackBlock];
        }
        
        if (! perm.granting) {
            perm.granting = YES;
            
            perm.grantBlock(context, ^(NSError *error) {
                @strongify(perm)
                
                perm.granting = NO;
                
                [perm.pendingActions enumerateObjectsUsingBlock:^(PermissionPendingAction *pending, NSUInteger idx, BOOL *stop) {
                    if (error && pending.grantCallback) {
                        pending.grantCallback(error);
                    }
                    else if (!error && pending.actionBlock) {
                        pending.actionBlock(context);
                    }
                }];
                
                [perm.pendingActions removeAllObjects];
            });
        }
    }
    else if (grantCallbackBlock) {
        grantCallbackBlock([NSError permissionGrantCancelError]);
    }
}

- (void) registerPermission:(PermissionRegistry *)registry {
    ASSERT_MAIN_THREAD
    
    [[registry permissions] enumerateObjectsUsingBlock:^(Permission *permission, NSUInteger idx, BOOL *stop) {
        NSAssert([_permissionDict objectForKey:permission.name] == nil, @"permission has been registerd: %@", permission.name);
        
        @synchronized(_permissionDict) {
            _permissionDict[permission.name] = permission;
        }
    }];
}

- (BOOL) checkPermission:(NSString *)permission context:(id)context {
    ASSERT_MAIN_THREAD
    
    Permission *perm = _permissionDict[permission];
    NSAssert(perm, @"permission has not been registered: %@", permission);
    
    return perm.ifBlock(context);
}

@end
