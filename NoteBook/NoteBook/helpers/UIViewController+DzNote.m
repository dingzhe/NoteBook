//
//  UIViewController+DzNote.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "UIViewController+DzNote.h"
#import <Masonry.h>
@implementation UIViewController (DzNote)
//TODO
+ (UINavigationController *) rootNavigationController {
    return (UINavigationController *)((UITabBarController *)self.rootViewController).selectedViewController;
}

- (void) configNavBackBarButtonItemWithAction:(void(^)())actionBlock {
    @weakify(self)
    
    UIBarButtonItem *backButton = \
    [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ic_back_normal"]
                                     style:UIBarButtonItemStylePlain
                                    target:nil
                                    action:nil];
    backButton.rac_command = [RACCommand commandWithBlock:^(id input) {
        @strongify(self)
        
        if (actionBlock) {
            actionBlock();
        }
        
        if (self.navigationController && self.navigationController.viewControllers.count > 1) {
            [self.navigationController popViewControllerAnimated:YES];
        }
        else if (self.presentingViewController) {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
    }];
    
    self.navigationItem.leftBarButtonItem = backButton;
}

@end

#pragma mark -

@implementation UIViewController(KeyboardScroll)

@dynamic scrollView;
- (UIScrollView *) scrollView {
    return GET_ASSOCIATED_OBJ();
}
- (void) setScrollView:(UIScrollView *)scrollView {
    SET_ASSOCIATED_OBJ_RETAIN_NONATOMIC(scrollView);
}

@dynamic contentView;
- (UIView *) contentView {
    return GET_ASSOCIATED_OBJ();
}
- (void) setContentView:(UIView *)contentView {
    SET_ASSOCIATED_OBJ_RETAIN_NONATOMIC(contentView);
}

- (void) setupKeyboardAutoScrollable {
    if (self.scrollView.superview) {
        return;
    }
    
    self.contentView = self.view;
    
    UIView *view = [[UIView alloc] initWithFrame:self.contentView.frame];
    view.backgroundColor = self.contentView.backgroundColor;
    
    if (!self.scrollView) {
        self.scrollView = [[UIScrollView alloc] initWithFrame:view.frame];
    }
    self.scrollView.showsHorizontalScrollIndicator = NO;
    self.scrollView.backgroundColor = view.backgroundColor;
    
    [view addSubview:self.scrollView];
    [self.scrollView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(view);
    }];
    
    [self.scrollView addSubview:self.contentView];
    [self.contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.scrollView);
    }];
    
    [self.contentView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(view.mas_left);
        make.right.mas_equalTo(view.mas_right);
    }];
    
    self.view = view;
    
    @weakify(self)
    
    [[KeyboardState.sharedState.willChangeFrameSignal
      takeUntil:self.rac_willDeallocSignal] subscribeNext:^(RACTuple *tuple) {
        @strongify(self)
        
        CGRect frame = [tuple[0] CGRectValue];
        frame = [self.view convertRect:frame fromView:nil];
        
        BOOL showingKeyboard = [KeyboardState isKeyboardShowing:frame];
        CGFloat yInset = showingKeyboard ? frame.size.height : 0;
        
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, yInset, 0);
        self.scrollView.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, yInset, 0);
        self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.size.width, self.scrollView.bounds.size.height+yInset);
    }];
}
@end
