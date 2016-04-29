//
//  UIViewController+DzNote.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (DzNote)
+ (UINavigationController *) rootNavigationController;

- (void) configNavBackBarButtonItemWithAction:(void(^)())actionBlock;

@end

#pragma mark -

@interface UIViewController(KeyboardScroll)

@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIView *contentView;

- (void) setupKeyboardAutoScrollable;
@end
