//
//  EmptyCellModel.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "EmptyCellModel.h"
#import "EmptyCellViewModel.h"
#import "NSObject+ViewModel.h"

#pragma mark -

@implementation EmptyCellModel

@synthesize cellHeight = _cellHeight;
@synthesize selectable = _selectable;
@synthesize seperatorHidden = _seperatorHidden;
@synthesize seperatorInsets = _seperatorInsets;
@synthesize contentInsets = _contentInsets;
@synthesize backgroundColor = _backgroundColor;
@synthesize sectionHeader = _sectionHeader;

+ (instancetype) modelWithCellHeight:(CGFloat) cellHeight
                     backgroundColor:(UIColor *) backgroundColor {
    EmptyCellModel *result = [self new];
    
    result.cellHeight = cellHeight;
    result.backgroundColor = backgroundColor;
    result.selectable = NO;
    
    return [result modelWithViewModelClass:EmptyCellViewModel.class];
}

+ (instancetype) seperatorModel {
    return [self modelWithCellHeight:8.f
                     backgroundColor:UIColor.grayBackgroundColor];
}

@end
