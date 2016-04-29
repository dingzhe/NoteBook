//
//  RACSubscriptingAssignmentTrampoline+Ext.m
//  bolome_shared
//
//  Created by by on 4/20/15.
//  Copyright (c) 2015 bolome. All rights reserved.
//

#import "RACOnceSubscriptingAssignmentTrampoline.h"
#import <objc/runtime.h>

@interface RACOnceSubscriptingAssignmentTrampoline ()

// The object to bind to.
@property (nonatomic, strong, readonly) id target;

// A value to use when `nil` is sent on the bound signal.
@property (nonatomic, strong, readonly) id nilValue;

@end

@implementation RACOnceSubscriptingAssignmentTrampoline

- (id)initWithTarget:(id)target nilValue:(id)nilValue {
    // This is often a programmer error, but this prevents crashes if the target
    // object has unexpectedly deallocated.
    if (target == nil) return nil;
    
    self = [super init];
    if (self == nil) return nil;
    
    _target = target;
    _nilValue = nilValue;
    
    return self;
}

- (void)setObject:(RACSignal *)signal forKeyedSubscript:(NSString *)keyPath {
    static void *bindingsKey = &bindingsKey;
    NSMutableDictionary *bindings = nil;
    
    @synchronized (self.target) {
        bindings = objc_getAssociatedObject(self.target, bindingsKey);
        if (bindings == nil) {
            bindings = [NSMutableDictionary dictionary];
            objc_setAssociatedObject(self.target, bindingsKey, bindings, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    RACDisposable *preDisposable = bindings[keyPath];
    if (preDisposable) {
        [preDisposable dispose];
    }
    
    if (signal) {
        RACDisposable *disposable = [signal setKeyPath:keyPath onObject:self.target nilValue:self.nilValue];
        @synchronized (bindings) {
            bindings[keyPath] = disposable;
        }
    }
}

@end
