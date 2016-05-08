//
//  ViewModel.h
//  NoteBook
//
//  Created by dz on 15/12/2.
//  Copyright (c) 2015年 dz. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "RVMViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>


@interface ViewModel : RVMViewModel

@property (nonatomic, strong, readonly) RACSubject *needsLayoutSignal;

@property (nonatomic, strong, readonly) RACSubject *showHUDSignal;

- (void) layout;

- (void) setNeedsLayout;

- (void) showHUDMessage:(NSString *)message;

@end
