//
//  Permission.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PermissionActionBlock)(id context);
typedef BOOL (^PermissionIfBlock)(id context);
typedef void (^PermissionGrantCallBackBlock)(NSError *error);
typedef void (^PermissionGrantBlock)(id context, PermissionGrantCallBackBlock callback);

@interface Permission : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) PermissionIfBlock ifBlock;
@property (nonatomic, copy) PermissionGrantBlock grantBlock;

+ (instancetype) permissionWithName:(NSString *)name;

@end
