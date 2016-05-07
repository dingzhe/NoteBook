//
//  UITableViewCell+Ext.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Ext)

- (void) alignSeparatorToLeftBorder;
- (void) hideSeperator;

- (void) updateSeperatorEdgeInset:(UIEdgeInsets) inset;

@end
