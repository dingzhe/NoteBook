//
//  PermissionManager+DzNote.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "PermissionManager+DzNote.h"

@implementation PermissionManager (DzNote)

- (void) registerVisionPermissions {
    [self registerPermission:[AuthPermissionRegistry registry]];
}

@end
