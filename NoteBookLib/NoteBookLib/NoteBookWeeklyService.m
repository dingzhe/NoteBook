//
//  NoteBookWeeklyService.m
//  NoteBookLib
//
//  Created by dz on 16/1/8.
//  Copyright (c) 2016年 dz. All rights reserved.
//

#import "NoteBookWeeklyService.h"
@implementation NoteBookWeeklyService{
    SWGWeeklyApi *_api;
}

- (instancetype) init {
    if (self = [super init]) {
        _api = [SWGWeeklyApi apiWithBasePath:ServerURL];
    }
    return self;
}

- (RACCommand*) weeklyListCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(weeklyListWithBody:completionHandler:) enabled:enable];
}

- (RACCommand*) addWeeklyCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(addWeeklyWithBody:completionHandler:) enabled:enable];
}
- (RACCommand*) myWeeklyCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(myWeeklyWithBody:completionHandler:) enabled:enable];
}

- (RACCommand*) delWeeklyCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(delWeeklyWithBody:completionHandler:) enabled:enable];
}
- (RACCommand*) updateWeeklyCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(updateWeeklyWithBody:completionHandler:) enabled:enable];
}

- (RACCommand*) uploadFileCommandEnable:(RACSignal*)enable {
    return [_api commandWithSelector:@selector(uploadFileWithUid:type:file:completionHandler:)
                             enabled:enable];
}
@end
