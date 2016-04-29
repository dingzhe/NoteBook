//
//  NBBaseViewController.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+HUD.h"
@interface NBBaseViewController : UIViewController
@property (nonatomic, assign) BOOL navBackBarButtonHidden;
@property (nonatomic, strong, readonly) RACSubject *viewWillDisappearSignal;

+ (instancetype) viewController;

- (void) configNavBackBarButtonItem;
- (void) navBackBarButtonDidClick;
- (void) cleanBeforeDismiss;
@end
