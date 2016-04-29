//
//  RACDisposableSubscriptingAssignmentTrampoline.h
//  bolome_shared
//
//  Created by by on 6/16/15.
//  Copyright (c) 2015 bolome. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#define RAC_DISPOSABLE(TARGET, KEY) \
[[RACDisposableSubscriptingAssignmentTrampoline alloc] initWithTarget:(TARGET)][@#KEY]

@interface RACDisposableSubscriptingAssignmentTrampoline : NSObject

- (id)initWithTarget:(NSObject *)target;

- (RACDisposable *) objectForKeyedSubscript:(NSString *)keyPath;
- (void)setObject:(RACDisposable *)disposable forKeyedSubscript:(NSString *)keyPath;

@end
