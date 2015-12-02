//
//  KeyboardState.h
//  bolome_shared
//
//  Created by by on 3/31/15.
//  Copyright (c) 2015 bolome. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <ReactiveCocoa/ReactiveCocoa.h>
//#import "NSObject+Ext.h"

@interface KeyboardState : NSObject

@property (nonatomic, readonly) RACSignal *willChangeFrameSignal;
@property (nonatomic, readonly) RACSignal *didChangeFrameSignal;

@property (nonatomic, readonly) CGRect keyboardFrame;
@property (nonatomic, readonly, getter=isKeyboardShowing) BOOL keyboardShowing;

DEF_SINGLETON(sharedState)

- (void) startMonitoring;
- (void) stopMonitoring;

+ (BOOL) isKeyboardShowing:(CGRect)frame;

@end
