//
//  ViewModel.m
//  NoteBook
//
//  Created by dz on 15/12/2.
//  Copyright (c) 2015年 dz. All rights reserved.
//

#import "ViewModel.h"

@implementation ViewModel

@synthesize needsLayoutSignal = _needsLayoutSignal;
- (RACSubject *) needsLayoutSignal {
    if (!_needsLayoutSignal) {
        @synchronized(self) {
            if (!_needsLayoutSignal) {
                _needsLayoutSignal = [RACSubject subject];
            }
        }
    }
    
    return _needsLayoutSignal;
}

@synthesize showHUDSignal = _showHUDSignal;
- (RACSubject *) showHUDSignal {
    if (!_showHUDSignal) {
        @synchronized(self) {
            if (!_showHUDSignal) {
                _showHUDSignal = [RACSubject subject];
            }
        }
    }
    
    return _showHUDSignal;
}

- (void) layout {
}

- (void) setNeedsLayout {
    [[RACScheduler schedulerWithPriority:DISPATCH_QUEUE_PRIORITY_HIGH] schedule:^{
        [self layout];
        [self.needsLayoutSignal sendNext:nil];
    }];
}

- (void) showHUDMessage:(NSString *)message {
    [self.showHUDSignal sendNext:message];
}
@end
