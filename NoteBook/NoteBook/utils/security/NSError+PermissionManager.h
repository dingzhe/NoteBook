//
//  NSError+PermissionManager.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>
extern NSString * const PermissionManagerErrorDomain;

#define PermissionManagerErrorGrantFailCode 1000
#define PermissionManagerErrorGrantCancleCode 1001
@interface NSError (PermissionManager)
+ (instancetype) permissionGrantFailError:(NSError *)underlyingError;
- (BOOL) isPermissionGrantFailError;

+ (instancetype) permissionGrantCancelError;
- (BOOL) isPermissionGrantCancelError;
@end
