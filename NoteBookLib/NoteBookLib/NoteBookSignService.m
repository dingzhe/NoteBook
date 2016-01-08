//
//  NoteBookSignService.m
//  NoteBookLib
//
//  Created by dz on 16/1/8.
//  Copyright (c) 2016年 dz. All rights reserved.
//

#import "NoteBookSignService.h"
#import "SWGSignApi.h"
@implementation NoteBookSignService{
    SWGSignApi *_api;
}

- (instancetype) init {
    if (self = [super init]) {
        _api = [SWGSignApi apiWithBasePath:@"http://114.215.152.69/php/api"];
    }
    return self;
}

- (RACCommand*) signInCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(signInWithBody:completionHandler:) enabled:enable];
}

- (RACCommand*) signUpCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(signUpWithBody:completionHandler:) enabled:enable];
}
@end

