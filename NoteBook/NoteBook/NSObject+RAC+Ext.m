//
//  NSObject+RACCommandSupport+Ext.m
//  bolome_shared
//
//  Created by by on 4/10/15.
//  Copyright (c) 2015 bolome. All rights reserved.
//

#import "NSObject+RAC+Ext.h"
#import "RACSignal+Ext.h"
#import <ReactiveCocoa/NSInvocation+RACTypeParsing.h>

@implementation NSObject(RAC_Ext)

- (RACSignal *) observeNotification:(NSString *)notificationName {
    return [self observeNotification:notificationName object:nil];
}

- (RACSignal *) observeNotification:(NSString *)notificationName object:(id)object {
    return [[[NSNotificationCenter defaultCenter] rac_addObserverForName:notificationName object:object] takeUntil:self.rac_willDeallocSignal];
}

+ (RACSignal *) _executionWithTarget:(id)target
                            selector:(SEL)selector
                               input:(id)input
                         willExecute:(NSError *(^)(id input)) willExecuteBlock
                         executeArgs:(NSArray *(^)(id input, id<RACSubscriber>subscriber)) executeArgsBlock
                          didExecute:(NSError *(^)(id input, id result)) didExecuteBlock
                       cancleExecute:(void (^)(id input, id result)) cancelExecuteBlock {
    @weakify(target)
    
    RACSignal *result = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        @strongify(target)
        
        NSError *error = nil;
        
        if (willExecuteBlock && (error = willExecuteBlock(input))) {
            [subscriber sendError:error];
            return nil;
        }
        
        NSMethodSignature *signature = [target methodSignatureForSelector:selector];
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
        invocation.selector = selector;
        invocation.target = target;
        
        __block NSInteger argIndex = 2;
        NSArray *arguments = nil;
        
        if (executeArgsBlock) {
            arguments = executeArgsBlock(input, subscriber);
            NSAssert(!arguments || [arguments isKindOfClass:NSArray.class], @"arguments must be array");
        }
        
        [arguments enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            [invocation rac_setArgument:obj atIndex:argIndex++];
        }];
        
        [invocation invoke];
        
        id returnValue = [invocation rac_returnValue];
        
        if (didExecuteBlock && (error = didExecuteBlock(input, returnValue))) {
            [subscriber sendError:error];
            return nil;
        }
        
        return [RACDisposable disposableWithBlock:^{
            !cancelExecuteBlock ? : cancelExecuteBlock(input, returnValue);
        }];
    }];
    
    result.executionInput = input;
    
    return result;
}

+ (RACCommand *) commandWithSelector:(SEL)selector
                             enabled:(RACSignal *)enabled
                         willExecute:(NSError *(^)(id input)) willExecuteBlock
                         executeArgs:(NSArray *(^)(id input, id<RACSubscriber>subscriber)) executeArgsBlock
                          didExecute:(NSError *(^)(id input, id result)) didExecuteBlock
                       cancleExecute:(void (^)(id input, id result)) cancelExecuteBlock {
    @weakify(self)

    return [[RACCommand alloc] initWithEnabled:enabled signalBlock:^RACSignal *(id input) {
        @strongify(self)

        return [self _executionWithTarget:self
                                 selector:selector
                                    input:input
                              willExecute:willExecuteBlock
                              executeArgs:executeArgsBlock
                               didExecute:didExecuteBlock
                            cancleExecute:cancelExecuteBlock];
    }];
}

- (RACCommand *) commandWithSelector:(SEL)selector
                             enabled:(RACSignal *)enabled
                         willExecute:(NSError *(^)(id input)) willExecuteBlock
                         executeArgs:(NSArray *(^)(id input, id<RACSubscriber>subscriber)) executeArgsBlock
                          didExecute:(NSError *(^)(id input, id result)) didExecuteBlock
                       cancleExecute:(void (^)(id input, id result)) cancelExecuteBlock {
    @weakify(self)
    
    return [[RACCommand alloc] initWithEnabled:enabled signalBlock:^RACSignal *(id input) {
        @strongify(self)
        
        return [self.class _executionWithTarget:self
                                       selector:selector
                                          input:input
                                    willExecute:willExecuteBlock
                                    executeArgs:executeArgsBlock
                                     didExecute:didExecuteBlock
                                  cancleExecute:cancelExecuteBlock];
    }];
}

@end
