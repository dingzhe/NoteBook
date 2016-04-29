//
//  AuthPermissionRegistry.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "AuthPermissionRegistry.h"
#import "LoginViewController.h"
#import "DDLogMacros.h"

NSString * const PermissionAuthSignedon = @"PermissionAuthSignedon";
NSString * const PermissionAuthContextStyleFullScreen = @"PermissionAuthContextStyleFullScreen";

@implementation AuthPermissionRegistry(prviate)

- (Permission *) _signedOnUserPermission {
    Permission *result = [Permission permissionWithName:PermissionAuthSignedon];
    
    @weakify(result)
    
    result.ifBlock = ^BOOL (id _) {
        return UserModelSignedOn == UserModel.currentUser.status;
    };
    
    result.grantBlock = ^(id context, PermissionGrantCallBackBlock callback) {
        @strongify(result)
        
        RACSignal *cancelSignal = nil;
        
        // show full screen ui for signed on user permission granting
        if ([PermissionAuthContextStyleFullScreen isEqualToString:context]) {
            LoginViewController *controller = [LoginViewController viewController];
            [controller showAnimated:YES];
            
            cancelSignal = controller.cancelSignal;
        }
        
        // default to show full screen ui for signed on user permission granting
        else {
            LoginViewController *controller = [LoginViewController viewController];
            [controller showAnimated:YES];
            
            cancelSignal = controller.cancelSignal;
        }
        
        RACCompoundDisposable *disposable = [RACCompoundDisposable compoundDisposable];
        
        void (^completeBlock)(NSError *) = ^(NSError *error){
            //DDLogError(@"[Auth] signed on user:%@ error:%@", UserModel.currentUser.uid, error);
            
            [disposable dispose];
            callback(error);
        };
        
        __weak id target_ = (UserModel.currentUser);
        RACSignal *valueChangeSignal = [target_ rac_valuesAndChangesForKeyPath:@keypath(UserModel.currentUser, status)
                                                                       options:0
                                                                      observer:result];
        RACDisposable *dis = [[valueChangeSignal takeUntil:cancelSignal] subscribeNext:^(NSNumber *status) {
            NSError *error = (UserModelSignedOn == UserModel.currentUser.status) ? nil : [NSError permissionGrantFailError:nil];
            completeBlock(error);
        } completed:^{
            completeBlock([NSError permissionGrantCancelError]);
        }];
        
        [disposable addDisposable:dis];
    };
    
    return result;
}

@end

@implementation AuthPermissionRegistry

- (NSArray *) permissions {
    return @[[self _signedOnUserPermission]];
}
@end
