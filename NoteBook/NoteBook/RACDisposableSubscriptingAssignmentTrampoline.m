//
//  RACDisposableSubscriptingAssignmentTrampoline.m
//  bolome_shared
//
//  Created by by on 6/16/15.
//  Copyright (c) 2015 bolome. All rights reserved.
//

#import "RACDisposableSubscriptingAssignmentTrampoline.h"
#import <objc/runtime.h>

static void *bindingsKey = &bindingsKey;

@interface RACDisposableSubscriptingAssignmentTrampoline ()

// The object to bind to.
@property (nonatomic, strong, readonly) NSObject *target;

@end

@implementation RACDisposableSubscriptingAssignmentTrampoline

- (id)initWithTarget:(NSObject *)target {
    // This is often a programmer error, but this prevents crashes if the target
    // object has unexpectedly deallocated.
    if (target == nil) return nil;
    
    self = [super init];
    if (self == nil) return nil;
    
    _target = target;
    
    return self;
}

- (RACDisposable *) objectForKeyedSubscript:(NSString *)keyPath {
    NSMutableDictionary *bindings = objc_getAssociatedObject(self.target, bindingsKey);
    return [bindings objectForKey:keyPath];
}

- (void)setObject:(RACDisposable *)disposable forKeyedSubscript:(NSString *)keyPath {
    NSMutableDictionary *bindings = nil;
    
    @synchronized (self.target) {
        bindings = objc_getAssociatedObject(self.target, bindingsKey);
        if (bindings == nil) {
            bindings = [NSMutableDictionary dictionaryWithCapacity:8];
            objc_setAssociatedObject(self.target, bindingsKey, bindings, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    RACDisposable *preDisposable = bindings[keyPath];
    if (preDisposable) {
        [preDisposable dispose];
        [self.target.rac_deallocDisposable removeDisposable:preDisposable];
    }
    
    [bindings setValue:disposable forKey:keyPath];
    
    if (disposable) {
        [self.target.rac_deallocDisposable addDisposable:disposable];
    }
}


@end
