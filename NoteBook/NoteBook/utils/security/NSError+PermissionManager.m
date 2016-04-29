//
//  NSError+PermissionManager.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NSError+PermissionManager.h"

NSString * const PermissionManagerErrorDomain = @"PermissionManagerErrorDomain";

@implementation NSError(PermissionManager)

+ (instancetype) permissionGrantFailError:(NSError *)underlyingError {
    NSDictionary *userInfo = nil;
    
    if (underlyingError) {
        userInfo =@{NSUnderlyingErrorKey: underlyingError};
    }
    
    return [NSError errorWithDomain:PermissionManagerErrorDomain
                               code:PermissionManagerErrorGrantFailCode
                           userInfo:userInfo];
}

- (BOOL) isPermissionGrantFailError {
    return [PermissionManagerErrorDomain isEqualToString:self.domain] && PermissionManagerErrorGrantFailCode == self.code;
}

+ (instancetype) permissionGrantCancelError {
    return [NSError errorWithDomain:PermissionManagerErrorDomain
                               code:PermissionManagerErrorGrantCancleCode
                           userInfo:nil];
}

- (BOOL) isPermissionGrantCancelError {
    return [PermissionManagerErrorDomain isEqualToString:self.domain] && PermissionManagerErrorGrantCancleCode == self.code;
}

@end
