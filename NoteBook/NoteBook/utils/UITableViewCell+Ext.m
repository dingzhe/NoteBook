//
//  UITableViewCell+Ext.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "UITableViewCell+Ext.h"

@implementation UITableViewCell (Ext)

- (void) alignSeparatorToLeftBorder {
    [self updateSeperatorEdgeInset:UIEdgeInsetsZero];
}

- (void) hideSeperator {
    [self updateSeperatorEdgeInset:UIEdgeInsetsMake(0.f, self.bounds.size.width + 1.f, 0.f, 0.f)];
}

- (void) updateSeperatorEdgeInset:(UIEdgeInsets) inset {
    [self setSeparatorInset:inset];
    
    // iOS 8 only
    if ([self respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [self setPreservesSuperviewLayoutMargins:NO];
    }
    // Explictly set your cell's layout margins
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

@end
