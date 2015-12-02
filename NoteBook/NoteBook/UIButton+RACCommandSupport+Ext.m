//
//  UIButton+RACCommandSupport+Ext.m
//  bolome_shared
//
//  Created by by on 4/7/15.
//  Copyright (c) 2015 bolome. All rights reserved.
//
#import <objc/runtime.h>

#import "UIButton+RACCommandSupport+Ext.h"
#import "NSObject+Ext.h"

static void *UIButtonEnabledDisposableKey = &UIButtonEnabledDisposableKey;

@implementation UIButton(RACCommandSupport_Ext)

@dynamic normalStateTitle;
- (NSString *)normalStateTitle {
    return [self titleForState:UIControlStateNormal];
}

- (void) setNormalStateTitle:(NSString *)normalStateTitle{
    [self setTitle:normalStateTitle forState:UIControlStateNormal];
}

- (void) setEnabled:(RACSignal *)enabled actionBlock:(void(^)(UIButton *sender))actionBlock {
    // Check for stored signal in order to remove it and add a new one
    RACDisposable *disposable = objc_getAssociatedObject(self, UIButtonEnabledDisposableKey);
    [disposable dispose];
    
    if (enabled) {
        disposable = [enabled setKeyPath:@keypath(self.enabled) onObject:self];
        objc_setAssociatedObject(self, UIButtonEnabledDisposableKey, disposable, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    if (actionBlock) {
        @weakify(self)
        [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id _) {
            @strongify(self)
            actionBlock(self);
        }];
    }
    
}

@end

#pragma mark -

@implementation RACCommand(UIButton)

+ (RACCommand *) commandWithEnabled:(RACSignal *)enabled
                              block:(void (^)(id input))block {
    return [[RACCommand alloc] initWithEnabled:enabled
                                   signalBlock:^RACSignal *(id input) {
                                       block(input);
                                       return [RACSignal empty];
                                   }];
}

+ (RACCommand *) commandWithBlock:(void (^)(id input))block {
    return [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        block(input);
        return [RACSignal empty];
    }];
}

@end
