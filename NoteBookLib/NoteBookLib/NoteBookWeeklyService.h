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

@end
