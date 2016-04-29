//
//  NoteBookDALService.h
//  NoteBookLib
//
//  Created by dz on 15/11/30.
//  Copyright (c) 2015年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteBookLib_gen.h"
#import "SWGApi+RAC.h"
#import "NoteBookConfigure.h"

@interface NoteBookDALService : NSObject<SWGApiDelegate>
+ (instancetype) service;
//
//+ (void) globalConfig;
//
//+ (BOOL) internetAccessable;

- (instancetype) init;

- (id) createApiWithClass:(Class)apiClass basePath:(NSString *)basePath;
@end
