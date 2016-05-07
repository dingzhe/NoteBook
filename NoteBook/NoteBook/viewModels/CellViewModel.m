//
//  CellViewModel.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "CellViewModel.h"

@implementation CellViewModel

@synthesize model = _model;
@synthesize cellWidth = _cellWidth;
@synthesize cellHeight = _cellHeight;
@synthesize selectable = _selectable;
@synthesize seperatorHidden = _seperatorHidden;
@synthesize seperatorInsets = _seperatorInsets;
@synthesize contentInsets = _contentInsets;
@synthesize backgroundColor = _backgroundColor;
@synthesize sectionHeader = _sectionHeader;

- (instancetype)initWithModel:(id)model {
    if (self = [super init]) {
        _model = model;
        _selectable = YES;
        
        _seperatorInsets = UIEdgeInsetsZero;
        _sectionHeader = NO;
    }
    return self;
}

- (BOOL) shouldHideCellSeperator {
    return self.seperatorHidden || (self.seperatorInsets.left > self.cellHeight || self.seperatorInsets.right < 0);
}

- (BOOL) layoutIfNeededWithCellWidth:(CGFloat) cellWidth {
    NSAssert(0 != cellWidth, @"Cell width MUST NOT be zero while layouting.");
    
    if (_cellWidth != cellWidth) {
        _cellWidth = cellWidth;
        [self layout];
        return YES;
    }
    
    return NO;
}

- (void) layout {
    NSAssert(0 != self.cellWidth, @"Cell width MUST NOT be zero while layouting.");
}

- (void) setNeedsLayout {
    if (self.cellWidth) {
        [super setNeedsLayout];
    }
}

@end
