//
//  NBBaseViewController.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NBBaseViewController.h"
#import "UIViewController+DzNote.h"
@implementation NBBaseViewController
+ (instancetype) viewController {
    return [[self alloc] initWithNibName:nil bundle:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor grayBackgroundColor];
    [self configNavBackBarButtonItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear: animated];
    [self.viewWillDisappearSignal sendNext:nil];
}

- (void) cleanBeforeDismiss {
    
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void) configNavBackBarButtonItem {
    if (self.navBackBarButtonHidden) {
        self.navigationItem.backBarButtonItem = nil;
    }
    else {
        @weakify(self)
        
        [self configNavBackBarButtonItemWithAction:^{
            @strongify(self)
            
            [self cleanBeforeDismiss];
            [self navBackBarButtonDidClick];
        }];
    }
}

- (void) navBackBarButtonDidClick {
    
}

@synthesize viewWillDisappearSignal = _viewWillDisappearSignal;
- (RACSubject *) viewWillDisappearSignal {
    if (!_viewWillDisappearSignal) {
        @synchronized(self) {
            if (!_viewWillDisappearSignal) {
                _viewWillDisappearSignal = [RACSubject subject];
            }
        }
    }
    return _viewWillDisappearSignal;
}

@end
