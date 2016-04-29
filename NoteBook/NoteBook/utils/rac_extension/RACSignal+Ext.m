//
//  RACSignal+Ext.m
//  bolome_shared
//
//  Created by by on 4/11/15.
//  Copyright (c) 2015 bolome. All rights reserved.
//

#import "RACSignal+Ext.h"


@implementation RACSignal(Ext)

@dynamic executionInput;
- (id) executionInput {
    return GET_ASSOCIATED_OBJ();
}
- (void) setExecutionInput:(id)executionInput {
    SET_ASSOCIATED_OBJ_RETAIN_NONATOMIC(executionInput);
}

+ (RACSignal *)after:(NSTimeInterval)interval onScheduler:(RACScheduler *)scheduler {
    NSCParameterAssert(scheduler != nil);
    NSCParameterAssert(scheduler != RACScheduler.immediateScheduler);
    
    return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        return [scheduler afterDelay:interval schedule:^{
            [subscriber sendNext:[NSDate date]];
            [subscriber sendCompleted];
        }];
    }] setNameWithFormat:@"+after: %f onScheduler: %@", (double)interval, scheduler];
}

@end
