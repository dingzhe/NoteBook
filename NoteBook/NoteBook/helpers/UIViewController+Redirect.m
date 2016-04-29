//
//  UIViewController+Redirect.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "UIViewController+Redirect.h"

@implementation UIViewController (Redirect)
- (void) showModalViewController:(UIViewController *)vc
    wrapWithNavigationController:(BOOL)wrapWithNav
                        animated:(BOOL)animated {
    if (!vc.navigationController && vc.navigationController.presentingViewController) {
        return;
    }
    
    UIViewController *prensentingVC = vc;
    
    if (![vc isKindOfClass:UINavigationController.class] && wrapWithNav) {
        UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
        prensentingVC = navi;
    }
    
    [self presentViewController:prensentingVC animated:animated completion:nil];
}
@end
