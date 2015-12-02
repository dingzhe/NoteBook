//
//  NoteBookArticleService.h
//  NoteBookLib
//
//  Created by dz on 15/11/24.
//  Copyright (c) 2015年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NoteBookLib_gen.h"
//#import "NoteBookDALService.h"
#import "services/NoteBookDALService.h"
@interface NoteBookArticleService : NoteBookDALService

- (RACCommand*) getArticleWithIdCommandEnable:(RACSignal*)enable;

@end
