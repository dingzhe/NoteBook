//
//  NoteBookWeeklyService.h
//  NoteBookLib
//
//  Created by dz on 16/1/8.
//  Copyright (c) 2016年 dz. All rights reserved.
//


#import "services/NoteBookDALService.h"

@interface NoteBookWeeklyService : NoteBookDALService
- (RACCommand*) weeklyListCommandEnable:(RACSignal*)enable;
- (RACCommand*) addWeeklyCommandEnable:(RACSignal*)enable;
- (RACCommand*) myWeeklyCommandEnable:(RACSignal*)enable;
- (RACCommand*) delWeeklyCommandEnable:(RACSignal*)enable;
- (RACCommand*) updateWeeklyCommandEnable:(RACSignal*)enable;

- (RACCommand*) uploadFileCommandEnable:(RACSignal*)enable;

- (RACCommand*) userInfoCommandEnable:(RACSignal*)enable;
- (RACCommand*) updateUserInfoCommandEnable:(RACSignal*)enable;
- (RACCommand*) alreadyFavoriteBlogCommandEnable:(RACSignal*)enable;
- (RACCommand*) favoriteBlogCommandEnable:(RACSignal*)enable;
- (RACCommand*) favoriteBlogListCommandEnable:(RACSignal*)enable;
- (RACCommand*) isBlogCommandEnable:(RACSignal*)enable;
- (RACCommand*) myBlogListCommandEnable:(RACSignal*)enable;
- (RACCommand*) noteGroupCommandEnable:(RACSignal*)enable;
- (RACCommand*) noteGroupNameByIdCommandEnable:(RACSignal*)enable;
- (RACCommand*) noteGroupListCommandEnable:(RACSignal*)enable;
- (RACCommand*) addNoteGroupCommandEnable:(RACSignal*)enable;
- (RACCommand*) weeklyByIdCommandEnable:(RACSignal*)enable;

@end
