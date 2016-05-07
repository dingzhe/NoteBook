//
//  UITableView+DzNote.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "UITableView+DzNote.h"
#import "NBTableViewCell.h"

@interface UITableView(DzNote_private)

@property (nonatomic, strong, readonly) NSMutableSet *registeredCellClasses;

@end

#pragma mark -

@implementation UITableView(DzNote_private)

@dynamic registeredCellClasses;
- (NSMutableSet *) registeredCellClasses {
    NSMutableSet *registeredCellClasses = GET_ASSOCIATED_OBJ();
    
    if (!registeredCellClasses) {
        @synchronized(self) {
            registeredCellClasses = GET_ASSOCIATED_OBJ();
            
            if (!registeredCellClasses) {
                registeredCellClasses = [NSMutableSet setWithCapacity:8];
                SET_ASSOCIATED_OBJ_RETAIN_NONATOMIC(registeredCellClasses);
            }
        }
    }
    
    return registeredCellClasses;
}

@end

#pragma mark -

@implementation UITableView(DzNote)

- (void) registerVSTableViewCellClass:(Class)cellClass {
    NSAssert([cellClass isSubclassOfClass:NBTableViewCell.class], @"registered class must be subclass of VSTableViewCell.");
    
    if ([self.registeredCellClasses containsObject:cellClass]) {
        return;
    }
    
    NSString *nibName = NSStringFromClass(cellClass);
    NSString *cellReuseIdentifer = [cellClass cellReuseIdentifier];
    if ([[NSBundle mainBundle] pathForResource:nibName ofType:@"nib"]) {
        [self registerNib:[UINib nibWithNibName:nibName bundle:nil] forCellReuseIdentifier:cellReuseIdentifer];
    }
    else {
        [self registerClass:cellClass forCellReuseIdentifier:cellReuseIdentifer];
    }
    
    [self.registeredCellClasses addObject:cellClass];
}

- (void) removeBottomPlaceHolderCells {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    view.backgroundColor = [UIColor clearColor];
    [self setTableFooterView:view];
}
@end
