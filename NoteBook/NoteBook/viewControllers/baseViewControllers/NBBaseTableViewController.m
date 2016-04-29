//
//  NBBaseTableViewController.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NBBaseTableViewController.h"
#import "UIViewController+DzNote.h"
@interface NBBaseTableViewController ()

@end
@implementation NBBaseTableViewController
- (void) cleanBeforeDismiss {
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear: animated];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.separatorColor = [UIColor seperatorColor];
    
    [self configNavBackBarButtonItem];
}

- (UIStatusBarStyle) preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void) configNavBackBarButtonItem {
    @weakify(self)
    
    [self configNavBackBarButtonItemWithAction:^{
        @strongify(self)
        
        [self navBackBarButtonDidClick];
    }];
}

- (void) navBackBarButtonDidClick {
}

@end
