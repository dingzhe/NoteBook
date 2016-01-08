//
//  NoteBookArticleService.m
//  NoteBookLib
//
//  Created by dz on 15/11/24.
//  Copyright (c) 2015年 dz. All rights reserved.
//

#import "NoteBookArticleService.h"


@implementation NoteBookArticleService{
    SWGGetArticleApi *_api;
}

- (instancetype) init {
    if (self = [super init]) {
        _api = [SWGGetArticleApi apiWithBasePath:@"http://114.215.152.69/php/api"];
    }
    return self;
}

- (RACCommand*) getArticleWithIdCommandEnable:(RACSignal*)enable{
    return [_api commandWithSelector:@selector(getArticleByIdWithBody:completionHandler:) enabled:enable];
}

@end
