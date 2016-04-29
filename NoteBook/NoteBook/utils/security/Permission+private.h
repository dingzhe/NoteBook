//
//  Permission+private.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "Permission.h"

@interface PermissionPendingAction : NSObject

@property (nonatomic, copy) PermissionActionBlock actionBlock;
@property (nonatomic, copy) PermissionGrantCallBackBlock grantCallback;

@end

#pragma mark -

@interface Permission()

@property (nonatomic, assign) BOOL granting;
@property (nonatomic, strong) NSMutableArray *pendingActions;

- (void) addPendingActionBlock:(PermissionActionBlock)block
                 grantCallback:(PermissionGrantCallBackBlock)grantCallback;
@end

