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

- (RACCommand*) userInfoCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(userInfoWithBody:completionHandler:) enabled:enable];
}
- (RACCommand*) updateUserInfoCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(updateUserInfoWithBody:completionHandler:) enabled:enable];
}
- (RACCommand*) alreadyFavoriteBlogCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(alreadyFavoriteBlogWithBody:completionHandler:) enabled:enable];
}
- (RACCommand*) favoriteBlogCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(favoriteBlogWithBody:completionHandler:) enabled:enable];
}
- (RACCommand*) favoriteBlogListCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(favoriteBlogListWithBody:completionHandler:) enabled:enable];
}
- (RACCommand*) isBlogCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(isBlogWithBody:completionHandler:) enabled:enable];
}
- (RACCommand*) myBlogListCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(myBlogListWithBody:completionHandler:) enabled:enable];
}
- (RACCommand*) noteGroupCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(noteGroupWithBody:completionHandler:) enabled:enable];
}
- (RACCommand*) noteGroupNameByIdCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(noteGroupNameByIdWithBody:completionHandler:) enabled:enable];
}
- (RACCommand*) noteGroupListCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(noteGroupListWithBody:completionHandler:) enabled:enable];
}
- (RACCommand*) addNoteGroupCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(addNoteGroupWithBody:completionHandler:) enabled:enable];
}
- (RACCommand*) weeklyByIdCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(weeklyByIdWithBody:completionHandler:) enabled:enable];
}


@end
