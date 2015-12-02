//
//  UIView+HUD.h
//  Vision
//
//  Created by Joully on 7/16/15.
//  Copyright (c) 2015 Vision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "MBProgressHUD.h"

@interface UIView(HUD)

- (void) bindHUDWithExecuting:(RACSignal *)signal;
- (void) rebindHUDWithExecuting:(RACSignal *)signal;

- (void) showHUDWithText:(NSString *)text
              detailText:(NSString *)detailText
             autoDismiss:(BOOL)dismiss;

- (void) showHUDWithText:(NSString *)text
              detailText:(NSString *)detailText
             autoDismiss:(BOOL)dismiss
adjustHeightOnKeyboardShow:(BOOL)adjust;

- (void) showHUDWithoutText;

- (void) dismissHUD;

@end
