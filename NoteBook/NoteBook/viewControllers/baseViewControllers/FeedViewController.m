//
//  FeedViewController.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedViewModel+MultipleSections.h"
#import "FeedViewController+Refresh.h"
#import "FeedViewModel+MultipleSections.h"
#import "Masonry.h"
#import "FeedViewModel+Refresh.h"
#import "FeedViewController+CellMapping.h"
#import "UIView+HUD.h"
#import "UITableView+DzNote.h"
#import "EmptyPlaceHolderView.h"
#import "IconTextCellModel.h"
#import "UITableViewCell+Ext.h"


@interface FeedViewController () {
    FeedViewModel *_viewModel;
    
    NSMutableArray *_viewSectionsDisposables;
    
    NSMutableDictionary *_cellsMapping;
}

@end

#pragma mark -

@implementation FeedViewController(private)


- (NSArray *) _indexPathsFromSection:(NSInteger)section indexes:(NSIndexSet *)indexes {
    NSMutableArray *result = [NSMutableArray array];
    
    [indexes enumerateIndexesUsingBlock:^(NSUInteger row, BOOL *stop) {
        [result addObject:[NSIndexPath indexPathForRow:row inSection:section]];
    }];
    
    return result;
}

- (void) _addSectionDisposable:(RACDisposable *)disposable {
    [self _insertSectionDisposable:disposable atIndex:_viewSectionsDisposables.count];
}

- (void) _insertSectionDisposable:(RACDisposable *)disposable atIndex:(NSInteger)index {
    [_viewSectionsDisposables insertObject:disposable atIndex:index];
}

- (void) _replaceSectionDisposable:(RACDisposable *)disposable atIndex:(NSInteger)index {
    RACDisposable *oldDisposable = _viewSectionsDisposables[index];
    [oldDisposable dispose];
    
    [_viewSectionsDisposables replaceObjectAtIndex:index withObject:disposable];
}

- (void) _removeSectionDisposableAtIndex:(NSInteger)index {
    RACDisposable *oldDisposable = _viewSectionsDisposables[index];
    [oldDisposable dispose];
    
    [_viewSectionsDisposables removeObjectAtIndex:index];
}

- (void) _removeAllSectionDisposables {
    [_viewSectionsDisposables enumerateObjectsUsingBlock:^(RACDisposable *disposable, NSUInteger idx, BOOL *stop) {
        [disposable dispose];
    }];
    
    [_viewSectionsDisposables removeAllObjects];
}

- (RACDisposable *) _bindSectionAtIndex:(NSInteger)section {
    @weakify(self)
    
    // No need to observe NSKeyValueObservingOptionInitial, since it will realod the entire section(s) while init.
    RACDisposable *result = \
    [[self.viewModel rac_valuesAndChangesForViewModelsInSection:section
                                                        options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld]
     subscribeNext:^(RACTuple *changes) {
         @strongify(self)
         
         NSDictionary *change = changes[1];
         NSNumber *kind = change[NSKeyValueChangeKindKey];
         
         [UIView setAnimationsEnabled:NO];
         
         if (NSKeyValueChangeSetting == kind.integerValue) {
             NSIndexSet *indexes = [NSIndexSet indexSetWithIndex:section];
             [self.tableView reloadSections:indexes
                           withRowAnimation:UITableViewRowAnimationNone];
             [self tableViewDidReloadSections:indexes];
         }
         else if (NSKeyValueChangeInsertion == kind.integerValue ||
                  NSKeyValueChangeRemoval == kind.integerValue) {
             NSArray *indexPaths = [self _indexPathsFromSection:section indexes:change[NSKeyValueChangeIndexesKey]];
             
             if (NSKeyValueChangeInsertion == kind.integerValue) {
                 [self.tableView insertRowsAtIndexPaths:indexPaths
                                       withRowAnimation:UITableViewRowAnimationNone];
                 [self tableViewDidInsertRowsAtIndexPaths:indexPaths];
             }
             else {
                 [self.tableView deleteRowsAtIndexPaths:indexPaths
                                       withRowAnimation:UITableViewRowAnimationNone];
                 [self tableViewDidDeleteRowsAtIndexPaths:indexPaths];
             }
         }
         else if (NSKeyValueChangeReplacement == kind.integerValue) {
             NSArray *indexPaths = [self _indexPathsFromSection:section indexes:change[NSKeyValueChangeIndexesKey]];
             
             [self.tableView reloadRowsAtIndexPaths:indexPaths
                                   withRowAnimation:UITableViewRowAnimationNone];
             [self tableViewDidReloadRowsAtIndexPaths:indexPaths];
         }
         
         [UIView setAnimationsEnabled:YES];
     }];
    
    return result;
}

- (void) _bindViewModel:(FeedViewModel *)viewModel {
    [self _removeAllSectionDisposables];
    RAC_DISPOSABLE(self, viewModelDisposable) = nil;
    
    if (!viewModel) {
        return;
    }
    
    @weakify(self)
    
    RACCompoundDisposable *compoundDisposable = [RACCompoundDisposable compoundDisposable];
    
    [compoundDisposable addDisposable:
     [[self.viewModel rac_valuesAndChangesForViewModelSections]
      subscribeNext:^(RACTuple *changes) {
          @strongify(self)
          
          NSDictionary *change = changes[1];
          NSNumber *kind = change[NSKeyValueChangeKindKey];
          
          [UIView setAnimationsEnabled:NO];
          
          if (NSKeyValueChangeSetting == kind.integerValue) {
              if (change[NSKeyValueChangeNewKey] != change[NSKeyValueChangeOldKey]) {
                  [self _removeAllSectionDisposables];
                  
                  NSArray *viewModelSections = change[NSKeyValueChangeNewKey];
                  [viewModelSections enumerateObjectsUsingBlock:^(id _, NSUInteger section, BOOL *stop) {
                      RACDisposable *disposable = [self _bindSectionAtIndex:section];
                      [self _addSectionDisposable:disposable];
                  }];
                  
                  [self.tableView reloadData];
                  [self tableViewDidReloadData];
              }
          }
          else if (NSKeyValueChangeInsertion == kind.integerValue) {
              NSIndexSet *indexes = change[NSKeyValueChangeIndexesKey];
              
              RACDisposable *disposable = [self _bindSectionAtIndex:indexes.firstIndex];
              [self _insertSectionDisposable:disposable atIndex:indexes.firstIndex];
              
              [self.tableView insertSections:indexes withRowAnimation:UITableViewRowAnimationNone];
              [self tableViewDidInsertSections:indexes];
          }
          else if (NSKeyValueChangeRemoval == kind.integerValue) {
              NSIndexSet *indexes = change[NSKeyValueChangeIndexesKey];
              [self _removeSectionDisposableAtIndex:indexes.firstIndex];
              
              [self.tableView deleteSections:indexes withRowAnimation:UITableViewRowAnimationNone];
              [self tableViewDidDeleteSections:indexes];
          }
          else if (NSKeyValueChangeReplacement == kind.integerValue) {
              NSIndexSet *indexes = change[NSKeyValueChangeIndexesKey];
              
              if (change[NSKeyValueChangeNewKey] != change[NSKeyValueChangeOldKey]) {
                  RACDisposable *disposable = [self _bindSectionAtIndex:indexes.firstIndex];
                  [self _replaceSectionDisposable:disposable atIndex:indexes.firstIndex];
                  
                  [self.tableView reloadSections:indexes withRowAnimation:UITableViewRowAnimationNone];
                  [self tableViewDidReloadSections:indexes];
              }
          }
          
          [UIView setAnimationsEnabled:YES];
      }]];
    
    [compoundDisposable addDisposable:[self.viewModel.showHUDSignal subscribeNext:^(NSString* message) {
        @strongify(self)
        [self.view showHUDWithText:nil detailText:message autoDismiss:YES];
    }]];
    
    [compoundDisposable addDisposable:
     [RACObserve(self.viewModel, asyncLoadingCellVM) subscribeNext:^(NSNumber *async) {
        @strongify(self)
        if (!async.boolValue){
            [self tableViewDidEndAsycLoading];
        }
    }]];
    
    RAC_DISPOSABLE(self, viewModelDisposable) = compoundDisposable;
}

- (void) _setupViewModel {
    if (_viewModel) {
        _viewModel.cellWidth = self.view.bounds.size.width;
    }
}

@end

#pragma mark -

@implementation FeedViewController

@synthesize tableView = _tableView;
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.scrollsToTop = YES;
        _tableView.separatorColor = [UIColor seperatorColor];
        
        [_tableView removeBottomPlaceHolderCells];
    }
    
    return _tableView;
}

@synthesize viewModel = _viewModel;
- (void)setViewModel:(FeedViewModel *)viewModel {
    _viewModel = viewModel;
    
    [self _bindViewModel:self.viewModel];
    [self _setupViewModel];
}

- (instancetype) initWithModel:(FeedViewModel *)model {
    if (self = [super init]) {
        self.title = model.title;
        
        _viewModel = model;
        _viewSectionsDisposables = [NSMutableArray arrayWithCapacity:8];
        
        _cellsMapping = [NSMutableDictionary dictionaryWithCapacity:8];
    }
    
    return self;
}

- (void) loadView {
    [super loadView];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
    [self overrideDefaultCellMappings];
    [self _bindViewModel:self.viewModel];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self _setupViewModel];
    [self.viewModel setActive:YES];
}

- (void) viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self _setupViewModel];
    [self setupEmptyPlaceHolder];
}
- (void) viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.viewModel setActive:NO];
}

- (void) registerVSTableViewCellClass:(Class) cellClass
                forCellViewModelClass:(Class) cellViewModelClass {
    if (cellClass && ![cellClass isSubclassOfClass:NBTableViewCell.class]) {
        [[NSException exceptionWithName:NSInvalidArgumentException
                                 reason:@"cellClass must be subclass of VSTableViewCell"
                               userInfo:nil] raise];
    }
    
    if (![cellViewModelClass isSubclassOfClass:CellViewModel.class]) {
        [[NSException exceptionWithName:NSInvalidArgumentException
                                 reason:@"cellViewModelClass be subclass of CellViewModel"
                               userInfo:nil] raise];
    }
    
    [_cellsMapping setValue:cellClass forKey:NSStringFromClass(cellViewModelClass)];
}

- (Class) getRegisteredVSTableViewCellClassForClass:(Class) cellViewModelClass {
    Class result = [_cellsMapping valueForKey:NSStringFromClass(cellViewModelClass)];
    
    if (!result) {
        result = [FeedViewController getDefaultRegisteredCellClassForViewModelClass:cellViewModelClass];
    }
    
    if (result) {
        [self.tableView registerVSTableViewCellClass:result];
    }
    
    return result;
}

- (void) overrideDefaultCellMappings {
}

- (NBTableViewCell *) tableView:(UITableView *)tableView cellForViewModel:(CellViewModel *)cellViewModel {
    NBTableViewCell *result = nil;
    
    Class cellClass = [self getRegisteredVSTableViewCellClassForClass:cellViewModel.class];
    if (cellClass) {
        result = [self.tableView dequeueReusableCellWithIdentifier:[cellClass cellReuseIdentifier]];
    }
    
    return result;
}

- (void) tableViewDidEndAsycLoading {
    
}

- (void) tableViewDidReloadData {
    
}

- (void) tableViewDidInsertSections:(NSIndexSet *)sections {
}

- (void) tableViewDidDeleteSections:(NSIndexSet *)sections {
}

- (void) tableViewDidReloadSections:(NSIndexSet *)sections {
}

- (void) tableViewDidInsertRowsAtIndexPaths:(NSArray *)indexPaths {
}

- (void) tableViewDidDeleteRowsAtIndexPaths:(NSArray *)indexPaths {
}

- (void) tableViewDidReloadRowsAtIndexPaths:(NSArray *)indexPaths {
}

- (void) showFooterViewWithImage:(NSString *)imageName seperator:(BOOL)hasSeperator{
    CGFloat width = self.tableView.bounds.size.width - VIEW_MARGIN * 2;
    UIImage *image = [UIImage imageNamed:imageName];
    UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.bounds.size.width, width * image.size.height/image.size.width+VIEW_MARGIN)];
    
    UIImageView *guideFooterView = [[UIImageView alloc] initWithImage:image];
    guideFooterView.contentMode = UIViewContentModeScaleAspectFit;
    
    guideFooterView.frame = CGRectMake(VIEW_MARGIN,
                                       VIEW_MARGIN,
                                       width,
                                       width * image.size.height/image.size.width);
    [footView addSubview:guideFooterView];
    
    if (hasSeperator == YES) {
        UIView *seperatorLine = [[UIView alloc]initWithFrame:CGRectMake(0,0, width+VIEW_MARGIN * 2, 1.0f/[UIScreen mainScreen].scale)];
        [seperatorLine setBackgroundColor:[UIColor seperatorColor]];
        [footView addSubview:seperatorLine];
    }
    
    self.tableView.tableFooterView = footView;
    
    UIEdgeInsets inset = self.tableView.contentInset;
    if (inset.bottom < VIEW_MARGIN) {
        inset.bottom = VIEW_MARGIN;
    }
    self.tableView.contentInset = inset;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return _viewModel.sectionCount;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger numbersOfrow = [_viewModel viewModelsInSection:section].count;
    return numbersOfrow;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSArray *headers = [self.viewModel headViewModelAtSection:section];
    
    if (headers!=nil && [headers count]>0) {
        UIView *result = [[UIView alloc] initWithFrame:CGRectZero];
        result.backgroundColor = [UIColor clearColor];
        
        __block CGFloat originY = 0;
        __block CGFloat width = 0;
        [headers enumerateObjectsUsingBlock:^(CellViewModel *obj, NSUInteger idx, BOOL *stop) {
            NBTableViewCell *cell = [self tableView:tableView cellForViewModel:obj];
            [cell updateWithViewModel:obj];
            UIEdgeInsets seperatorInsets = \
            [obj shouldHideCellSeperator] ? UIEdgeInsetsMake(0.f, self.tableView.frame.size.width + 1.f, 0.f, 0.f) : obj.seperatorInsets;
            [cell updateSeperatorEdgeInset:seperatorInsets];
            [result addSubview:cell];
            [cell setFrame:CGRectMake(0, originY, obj.cellWidth, obj.cellHeight)];
            originY += obj.cellHeight-0.5;
            width = obj.cellWidth;
        }];
        
        [result setFrame:CGRectMake(0, 0, width, originY)];
        
        return result;
    }
    
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = [self.viewModel viewModelAtIndexPath:indexPath];
    
    NBTableViewCell *result = [self tableView:tableView cellForViewModel:cellViewModel];
    [result updateWithViewModel:cellViewModel];
    
    UIEdgeInsets seperatorInsets = \
    [cellViewModel shouldHideCellSeperator] ? UIEdgeInsetsMake(0.f, self.tableView.frame.size.width + 1.f, 0.f, 0.f) : cellViewModel.seperatorInsets;
    [result updateSeperatorEdgeInset:seperatorInsets];
    
    return result;
}

- (void) tableView:(UITableView *)tableView didSelectCellWithViewModel:(CellViewModel *)cellViewModel {
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView
        editingStyleForCellWithViewModel:(CellViewModel *)cellViewModel {
    return UITableViewCellEditingStyleNone;
}

- (BOOL) tableView:(UITableView *)tableView canEditCellWithViewModel:(CellViewModel *)cellViewModel {
    return NO;
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forCellWithViewModel:(CellViewModel *)cellViewModel {
}

- (NSArray*) tableView:(UITableView *)tableView editActionsForCellWithViewModel:(CellViewModel *)cellViewModel {
    return nil;
}

#pragma mark - UITableViewDelegate & UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    NSArray *headers = [self.viewModel headViewModelAtSection:section];
    if (headers!=nil&& [headers count]>0) {
        __block CGFloat height = 0;
        [headers enumerateObjectsUsingBlock:^(CellViewModel *obj, NSUInteger idx, BOOL *stop) {
            height += [obj shouldHideCellSeperator] ? obj.cellHeight : obj.cellHeight + 0.5f;
        }];
        return height;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *viewModel = [self.viewModel viewModelAtIndexPath:indexPath];
    return [viewModel shouldHideCellSeperator] ? viewModel.cellHeight : viewModel.cellHeight + 0.5f;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView heightForRowAtIndexPath:indexPath];
}

- (NSIndexPath *)tableView:(UITableView *)tableView
  willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self tableView:tableView shouldHighlightRowAtIndexPath:indexPath] ? indexPath : nil;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = [self.viewModel viewModelAtIndexPath:indexPath];
    return cellViewModel.selectable;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = [self.viewModel viewModelAtIndexPath:indexPath];
    [self tableView:tableView didSelectCellWithViewModel:cellViewModel];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = [self.viewModel viewModelAtIndexPath:indexPath];
    return [self tableView:tableView editingStyleForCellWithViewModel:cellViewModel];
}

- (BOOL) tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = [self.viewModel viewModelAtIndexPath:indexPath];
    return [self tableView:tableView canEditCellWithViewModel:cellViewModel];
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = [self.viewModel viewModelAtIndexPath:indexPath];
    [self tableView:tableView commitEditingStyle:editingStyle forCellWithViewModel:cellViewModel];
}

- (NSArray*) tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    CellViewModel *cellViewModel = [self.viewModel viewModelAtIndexPath:indexPath];
    return [self tableView:tableView editActionsForCellWithViewModel:cellViewModel];
}

#pragma mark - UIScrollViewDelegate

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.feedDidScrollBlock) {
        self.feedDidScrollBlock();
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView
{
    return YES;
}

@end
