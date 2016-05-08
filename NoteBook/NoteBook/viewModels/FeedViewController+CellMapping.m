//
//  FeedViewController+CellMapping.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "FeedViewController+CellMapping.h"
#import "NBTableViewCell.h"
#import "PersonalManagerHeadCell.h"
#import "PersonalManagerHeadCellViewModel.h"
#import "WeeklyListCellViewModel.h"
#import "WeeklyListCell.h"
#import "NoteCellViewModel.h"
#import "NoteTableViewCell.h"
#import "CommonTextCell.h"
#import "CommonTextCellViewModel.h"
#import "EmptyTableViewCell.h"
#import "EmptyCellViewModel.h"

#pragma mark -

#define REG_CELL_VIEWMODEL(cellClass, cellViewModelClass) \
NSAssert(cellClass.class && [cellClass.class isSubclassOfClass:NBTableViewCell.class], @"cellClass MUST be subClass of NBTableViewCell"); \
NSAssert(cellViewModelClass.class && [cellViewModelClass.class isSubclassOfClass:CellViewModel.class], @"cellViewModelClass MUST be subclass of CellViewModel"); \
[globalCellsMapping setValue:cellClass.class forKey:NSStringFromClass(cellViewModelClass.class)];

#pragma mark -
static NSMutableDictionary *globalCellsMapping = nil;

#pragma mark -

@implementation FeedViewController (CellMapping)
+ (void) initialize {
    [super initialize];
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        globalCellsMapping = [NSMutableDictionary dictionaryWithCapacity:128];
        REG_CELL_VIEWMODEL(EmptyTableViewCell, EmptyCellViewModel);
        REG_CELL_VIEWMODEL(PersonalManagerHeadCell,PersonalManagerHeadCellViewModel);
        REG_CELL_VIEWMODEL(WeeklyListCell,WeeklyListCellViewModel);
        REG_CELL_VIEWMODEL(NoteTableViewCell,NoteCellViewModel);
        REG_CELL_VIEWMODEL(CommonTextCell, CommonTextCellViewModel);
    });
}

+ (Class) getDefaultRegisteredCellClassForViewModelClass:(Class)cellVieModelClass {
    return [globalCellsMapping objectForKey:NSStringFromClass(cellVieModelClass)];
}

@end
