//
//  RACSubscriptingAssignmentTrampoline+Ext.h
//  bolome_shared
//
//  Created by by on 4/20/15.
//  Copyright (c) 2015 bolome. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa.h>

#define RAC_ONCE(TARGET, ...) \
metamacro_if_eq(1, metamacro_argcount(__VA_ARGS__)) \
(RAC_ONCE_(TARGET, __VA_ARGS__, nil)) \
(RAC_ONCE_(TARGET, __VA_ARGS__))

/// Do not use this directly. Use the RAC macro above.
#define RAC_ONCE_(TARGET, KEYPATH, NILVALUE) \
[[RACOnceSubscriptingAssignmentTrampoline alloc] initWithTarget:(TARGET) nilValue:(NILVALUE)][@keypath(TARGET, KEYPATH)]

@interface RACOnceSubscriptingAssignmentTrampoline : RACSubscriptingAssignmentTrampoline

- (id)initWithTarget:(id)target nilValue:(id)nilValue;
- (void)setObject:(RACSignal *)signal forKeyedSubscript:(NSString *)keyPath;

@end
