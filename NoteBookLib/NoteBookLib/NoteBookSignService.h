//
//  NoteBookSignService.h
//  NoteBookLib
//
//  Created by dz on 16/1/8.
//  Copyright (c) 2016年 dz. All rights reserved.
//


#import "services/NoteBookDALService.h"
@interface NoteBookSignService : NoteBookDALService
- (RACCommand*) signInCommandEnable:(RACSignal*)enable;
- (RACCommand*) signUpCommandEnable:(RACSignal*)enable;
@end
