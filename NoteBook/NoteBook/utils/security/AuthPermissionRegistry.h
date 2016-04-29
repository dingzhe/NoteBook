//
//  AuthPermissionRegistry.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "PermissionRegistry.h"

extern NSString * const PermissionAuthSignedon;
extern NSString * const PermissionAuthContextStyleFullScreen;

@interface AuthPermissionRegistry : PermissionRegistry

- (NSArray *) permissions;

@end
