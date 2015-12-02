//
//  KeyboardState.m
//  bolome_shared
//
//  Created by by on 3/31/15.
//  Copyright (c) 2015 bolome. All rights reserved.
//

#import "KeyboardState.h"
#import "NSObject+RAC+Ext.h"

@interface KeyboardState() {
    RACSubject *_willChangeFrameSignal;
    RACSubject *_didChangeFrameSignal;
    
    RACDisposable *_willShowKeyboardDisposable;
    RACDisposable *_didShowKeyboardDisposable;
}

@end

@implementation KeyboardState(private)

- (RACTuple *) _keyboardTupleFromNotification:(NSNotification *)note {
    id frame = note.userInfo[UIKeyboardFrameEndUserInfoKey];
    id duration = note.userInfo[UIKeyboardAnimationDurationUserInfoKey];
    id curve = note.userInfo[UIKeyboardAnimationCurveUserInfoKey];
    
    return RACTuplePack(frame, duration, curve);
}

@end

@implementation KeyboardState

@synthesize willChangeFrameSignal = _willChangeFrameSignal;
@synthesize didChangeFrameSignal = _didChangeFrameSignal;

@synthesize keyboardFrame = _keyboardFrame;

@dynamic keyboardShowing;
- (BOOL) isKeyboardShowing {
    return [KeyboardState isKeyboardShowing:_keyboardFrame];
}

IMP_SINGLETON(sharedState, KeyboardState)

- (id) init {
    if (self = [super init]) {
        _willChangeFrameSignal = [RACSubject subject];
        _didChangeFrameSignal = [RACSubject subject];
    }
    return self;
}

- (void) startMonitoring {
    if (_willShowKeyboardDisposable) {
        return;
    }
    
    @weakify(self)
    
    _willShowKeyboardDisposable = [[self observeNotification:UIKeyboardWillChangeFrameNotification] subscribeNext:^(NSNotification *note) {
        @strongify(self)
        
        [self -> _willChangeFrameSignal sendNext:[self _keyboardTupleFromNotification:note]];
    }];
    
    _didShowKeyboardDisposable = [[self observeNotification:UIKeyboardDidChangeFrameNotification] subscribeNext:^(NSNotification *note) {
        @strongify(self)
        
        [self willChangeValueForKey:@"keyboardShowing"];
        [self willChangeValueForKey:@"keyboardFrame"];
        _keyboardFrame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
        [self didChangeValueForKey:@"keyboardFrame"];
        [self didChangeValueForKey:@"keyboardShowing"];
        
        [self -> _didChangeFrameSignal sendNext:[self _keyboardTupleFromNotification:note]];
    }];
}

- (void) stopMonitoring {
    if (!_willShowKeyboardDisposable) {
        return;
    }
    
    [_willShowKeyboardDisposable dispose];
    _willShowKeyboardDisposable = nil;
    [_didShowKeyboardDisposable dispose];
    _didShowKeyboardDisposable = nil;
}

+ (BOOL) isKeyboardShowing:(CGRect)frame {
    return frame.origin.y != 0 && frame.origin.y < [UIApplication sharedApplication].keyWindow.frame.size.height;
}

@end
