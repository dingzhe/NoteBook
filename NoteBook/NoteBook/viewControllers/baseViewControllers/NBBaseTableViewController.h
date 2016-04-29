//
//  NBBaseTableViewController.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NBBaseTableViewController : UITableViewController
- (void) configNavBackBarButtonItem;
- (void) navBackBarButtonDidClick;
- (void) cleanBeforeDismiss;
@end
