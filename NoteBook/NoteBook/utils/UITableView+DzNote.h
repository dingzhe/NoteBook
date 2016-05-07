//
//  UITableView+DzNote.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (DzNote)
// register tableview cell class or nib which is subclass of VSTableViewCell
- (void) registerVSTableViewCellClass:(Class)cellClass;

- (void) removeBottomPlaceHolderCells;

@end
