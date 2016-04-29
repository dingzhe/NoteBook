//
//  UIViewController+Redirect.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ViewPresentingStyle) {
    ViewPresentingStyleDefault = 0,
    ViewPresentingStylePush = 1,
    ViewPresentingStyleModal = 2
};

@interface UIViewController (Redirect)

- (void) showModalViewController:(UIViewController *)vc
    wrapWithNavigationController:(BOOL)wrapWithNav
                        animated:(BOOL)animated;

@end
