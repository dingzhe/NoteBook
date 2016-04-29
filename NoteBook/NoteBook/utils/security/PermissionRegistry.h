//
//  PermissionRegistry.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Permission.h"

@interface PermissionRegistry : NSObject
+ (instancetype) registry;

- (NSArray *)permissions;
@end
