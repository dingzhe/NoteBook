//
//  UIView+HUD.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
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
