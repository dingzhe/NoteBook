//
//  FeedViewModel.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "ViewModel.h"
#import "CellViewModel.h"

@interface FeedViewModel : ViewModel

@property (nonatomic, strong) NSString *title;

@property (nonatomic, assign) CGFloat cellWidth;
@property (nonatomic, assign, readonly, getter=isAsyncLoadingCellVM) BOOL asyncLoadingCellVM;
@property (nonatomic, assign, readonly, getter=isEmptyModels) BOOL emptyModels;
@property (nonatomic, assign, readonly, getter=isEmptyViewModels) BOOL emptyViewModels;
@property (nonatomic, readwrite) BOOL autoLoadViewModels;

// override to register cell view model classes
- (void) registerCellViewModelClasses;

- (void) registerCellViewModelClass:(Class)cellModelClass forModelClass:(Class)modelClass;

- (Class) getRegisteredCellViewModelClassForClass:(Class)modelClass;

// Override to return cell view model class for complex logic
- (Class) cellViewModelClassForModel:(NSObject *) model;

// Override to do extra setting for CellViewModel, called on background threads
- (CellViewModel *) cellViewModelForModel:(NSObject *)model;
@end
