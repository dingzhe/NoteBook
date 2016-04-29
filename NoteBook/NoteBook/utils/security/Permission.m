//
//  Permission.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "Permission.h"
#import "Permission+private.h"

@implementation PermissionPendingAction

@end

#pragma mark -

@implementation Permission

+ (instancetype) permissionWithName:(NSString *)name {
    Permission *result = [[self alloc] init];
    result.name = name;
    return result;
}

- (id) init {
    if (self = [super init]) {
        _pendingActions = [NSMutableArray arrayWithCapacity:8];
        _granting = NO;
    }
    return self;
}

- (void) addPendingActionBlock:(PermissionActionBlock) block
                 grantCallback:(PermissionGrantCallBackBlock) grantCallback {
    PermissionPendingAction* pending = [[PermissionPendingAction alloc] init];
    
    pending.actionBlock = block;
    pending.grantCallback = grantCallback;
    
    [_pendingActions addObject:pending];
}
@end
