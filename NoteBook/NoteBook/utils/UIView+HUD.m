//
//  UIView+HUD.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "UIView+HUD.h"

@interface UIView(HUD_private)

@property (nonatomic, strong) MBProgressHUD *hud;

@end

#pragma mark -

@implementation UIView(HUD_private)

@dynamic hud;
- (MBProgressHUD *)hud {
    return GET_ASSOCIATED_OBJ();
}
- (void) setHud:(MBProgressHUD *)hud {
    return SET_ASSOCIATED_OBJ_RETAIN_NONATOMIC(hud);
}

- (void) _showHUDWithMode:(MBProgressHUDMode)mode
                     text:(NSString *)text
             detailedText:(NSString *)detailedText {
    if (!self.hud) {
        self.hud = [[MBProgressHUD alloc] initWithView:self];
        self.hud.color = [UIColor lightGrayColor];
        self.hud.removeFromSuperViewOnHide = YES;
        [self addSubview:self.hud];
        [self.hud show:YES];
    }
    
    self.hud.mode = mode;
    self.hud.labelText = text;
    self.hud.detailsLabelText = detailedText;
}

- (void) _dismissHUDAfterDelay:(NSTimeInterval)delay {
    if (!self.hud) {
        return;
    }
    
    // for smooth ui presentation between dismiss and then show
    if (0 == delay) {
        delay = 0.1f;
    }
    
    self.hud.removeFromSuperViewOnHide = YES;
    [self.hud hide:YES afterDelay:delay];
    self.hud = nil;
}

- (void) _bindHUDWithExecuting:(RACSignal *)signal reset:(BOOL)reset {
    @weakify(self)

    RACCompoundDisposable *oldDisposable = (RACCompoundDisposable *)RAC_DISPOSABLE(self, bindHUDDisposable);
    RACCompoundDisposable *newDisposable = oldDisposable;
    if (reset || !oldDisposable) {
        newDisposable = [RACCompoundDisposable compoundDisposable];
    }
    
    [newDisposable addDisposable:
     [signal subscribeNext:^(NSNumber *num) {
        @strongify(self)
        
        NSAssert([num isKindOfClass:NSNumber.class], @"The signal binded to show HUD must be executing signal.");
        
        if (num.boolValue) {
            [self _showHUDWithMode:MBProgressHUDModeIndeterminate
                              text:nil
                      detailedText:nil];
        }
        else {
            if (self.hud && self.hud.mode == MBProgressHUDModeIndeterminate) {
                [self _dismissHUDAfterDelay:0.f];
            }
        }
    }]];
    
    if (reset || !oldDisposable) {
        RAC_DISPOSABLE(self, bindHUDDisposable) = newDisposable;
    }
}

@end

#pragma mark -

@implementation UIView(HUD)


- (void) bindHUDWithExecuting:(RACSignal *)signal {
    [self _bindHUDWithExecuting:signal reset:NO];
}

- (void) rebindHUDWithExecuting:(RACSignal *)signal {
    [self _bindHUDWithExecuting:signal reset:YES];
}

- (void) showHUDWithText:(NSString *)text
              detailText:(NSString *)detailText
             autoDismiss:(BOOL)dismiss {
    [self showHUDWithText:text
               detailText:detailText
              autoDismiss:dismiss
adjustHeightOnKeyboardShow:NO];
}

- (void) showHUDWithText:(NSString *)text
              detailText:(NSString *)detailText
             autoDismiss:(BOOL)dismiss
adjustHeightOnKeyboardShow:(BOOL)adjust {
    [self _showHUDWithMode:MBProgressHUDModeText
                      text:text
              detailedText:detailText];
    
    if (adjust && KeyboardState.sharedState.keyboardShowing) {
        self.hud.yOffset = -KeyboardState.sharedState.keyboardFrame.size.height/2;
    }
    
    if(dismiss) {
        [self _dismissHUDAfterDelay:1.f];
    }
}

-(void)showHUDWithoutText{
    [self _showHUDWithMode:MBProgressHUDModeIndeterminate
                      text:nil
              detailedText:nil];
}

- (void) dismissHUD {
    [self _dismissHUDAfterDelay:0.f];
}

@end
