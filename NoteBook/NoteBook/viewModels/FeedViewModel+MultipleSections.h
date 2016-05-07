//
//  FeedViewModel+MultipleSections.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "FeedViewModel.h"

@interface FeedViewModel (MultipleSections)
@property (nonatomic, assign, readonly) NSInteger sectionCount;
@property (nonatomic, assign) NSInteger staticCount;

- (id) initWithSectionCount:(NSInteger) count;
- (id) initWithStaticCount:(NSInteger) count;

- (void) resetModelSections:(NSArray *)modelSections;

- (void) setModels:(NSArray *)models fromSection:(NSInteger)fromSection ;
- (void) setModels:(NSArray *)models inSection:(NSInteger)section;
- (void) insertModels:(NSArray *)models atIndex:(NSInteger)row inSection:(NSInteger)section;
- (void) appendModels:(NSArray *)models inSection:(NSInteger)section;
- (void) removeModelsAtIndexes:(NSIndexSet *)indexes inSection:(NSInteger)section;
- (void) replaceModels:(NSArray *)models atIndexes:(NSIndexSet *)indexes inSection:(NSInteger)section;

- (void) insertSectionAtIndex:(NSInteger)section withModels:(NSArray*)models;
- (void) removeSectionAtIndex:(NSInteger)section;

// return nil, if model/viewModel at index path does not exsit.
- (id) modelAtIndexPath: (NSIndexPath *)indexPath;
- (CellViewModel *) viewModelAtIndexPath: (NSIndexPath *)indexPath;
- (NSArray *) headViewModelAtSection:(NSInteger)section;

- (NSArray*) modelsInSection:(NSInteger)section;
- (NSArray*) viewModelsInSection:(NSInteger)section;

- (NSIndexPath *) indexPathForModel:(id)model;
- (NSIndexPath *) indexPathForViewModel:(id)viewModel;
- (NSIndexPath *) indexPathForModelFindBlock:(BOOL(^)(id))findBlock;
- (NSIndexPath *) indexPathForViewModelFindBlock:(BOOL(^)(id))findBlock;

- (RACSignal *)rac_valuesAndChangesForModelSections;
- (RACSignal *)rac_valuesAndChangesForViewModelSections;
- (RACSignal *)rac_valuesAndChangesForModelSectionsOptions:(NSKeyValueObservingOptions)options;
- (RACSignal *)rac_valuesAndChangesForViewModelSectionsOptions:(NSKeyValueObservingOptions)options;

- (RACSignal *)rac_valuesAndChangesForModelsInSection:(NSInteger)section;
- (RACSignal *)rac_valuesAndChangesForViewModelsInSection:(NSInteger)section;
- (RACSignal *)rac_valuesAndChangesForModelsInSection:(NSInteger)section
                                              options:(NSKeyValueObservingOptions)options;
- (RACSignal *)rac_valuesAndChangesForViewModelsInSection:(NSInteger)section
                                                  options:(NSKeyValueObservingOptions)options;
@end
