//
//  FeedViewModel.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "FeedViewModel.h"
#import "FeedViewModel+MultipleSections.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NSObject+ViewModel.h"


typedef void (^CompleteBlock)();

#define ASSERT_MAIN_THREAD NSAssert([NSThread isMainThread], @"This action must be called on main thread");

//static dispatch_queue_t cellViewModelsQueue = nil;
RACTargetQueueScheduler *cellViewModelsQueueScheduler = nil;

__attribute__((constructor))
static void initialize(void) {
    // cellViewModelsQueue must be serail, or the cellViewModels set/insert/remove sequence will be out of order.
    // Since the queue is serial, the delay for creating cell view models will be longer. But well, that's acceptable.
    dispatch_queue_t cellViewModelsQueue = dispatch_queue_create("me.bolo.cellViewModelsQueue", DISPATCH_QUEUE_SERIAL);
    
    cellViewModelsQueueScheduler = \
    [[RACTargetQueueScheduler alloc] initWithName:@"CellViewModelsQueueScheduler"
                                      targetQueue:cellViewModelsQueue];
}


#define CELL_VM_Q_ASYNC_BEGIN \
[self _beginAsync]; \
[cellViewModelsQueueScheduler schedule:^{

#define CELL_VM_Q_ASYNC_MAIN_BEGIN \
[RACScheduler.mainThreadScheduler schedule:^{

#define CELL_VM_Q_ASYNC_END \
[self _endAsync]; \
[self _notifyEmptyViewModelsChange]; \
}]; \
}];

#define CELL_VM_Q_ASYNC_ENQUEUE_BEGIN \
CELL_VM_Q_ASYNC_BEGIN \
CELL_VM_Q_ASYNC_MAIN_BEGIN \

#define CELL_VM_Q_ASYNC_ENQUEUE_END \
CELL_VM_Q_ASYNC_END

#pragma mark -

@interface FeedArray : NSObject

@property (nonatomic, strong) NSMutableArray *items;
@property (nonatomic, strong) NSMutableArray *headers;
@end

@implementation FeedArray

+ (instancetype) array {
    FeedArray *result = [[FeedArray alloc] init];
    result.items = [NSMutableArray arrayWithCapacity:8];
    result.headers = [NSMutableArray arrayWithCapacity:8];
    return result;
}

@end

#pragma mark -

@interface FeedViewModel() {
    NSMutableArray *_modelSections;
    NSMutableArray *_viewModelSections;
    
    NSInteger _asyncLoadingCount;
    BOOL _autoLoadViewModels;
    
    NSMutableDictionary *_cellViewModelsMapping;
}

@end

#pragma mark -

@implementation FeedViewModel(private)

- (BOOL) _shouldLoadCellViewModels {
    return self.autoLoadViewModels && self.cellWidth != 0;
}

- (void) _reloadCellViewModles {
    CELL_VM_Q_ASYNC_ENQUEUE_BEGIN
    
    if (_modelSections.count != [_viewModelSections count]) {
        NSMutableArray *viewModelSections = [NSMutableArray arrayWithCapacity:_modelSections.count];
        [_modelSections enumerateObjectsUsingBlock:^(NSArray * models, NSUInteger idx, BOOL *stop) {
            [viewModelSections addObject:[FeedArray array]];
        }];
        
        [self willChangeValueForKey:@"viewModelSections"];
        _viewModelSections = viewModelSections;
        [self didChangeValueForKey:@"viewModelSections"];
    }
    
    CELL_VM_Q_ASYNC_ENQUEUE_END
    
    [_modelSections enumerateObjectsUsingBlock:^(FeedArray * section, NSUInteger idx, BOOL *stop) {
        [self _enqueueToCreateVMForModels:section.items
                                inSection:idx
                                   change:NSKeyValueChangeSetting
                                  indexes:nil];
    }];
}

- (void) _beginAsync {
    BOOL notify = (0 == _asyncLoadingCount);
    
    if (notify) {
        [self willChangeValueForKey:@"asyncLoadingCellVM"];
    }
    
    ++_asyncLoadingCount;
    
    if (notify) {
        [self didChangeValueForKey:@"asyncLoadingCellVM"];
    }
}

- (void) _endAsync {
    BOOL notify = (1 == _asyncLoadingCount);
    
    if (notify) {
        [self willChangeValueForKey:@"asyncLoadingCellVM"];
    }
    
    --_asyncLoadingCount;
    
    if (notify) {
        [self didChangeValueForKey:@"asyncLoadingCellVM"];
    }
}

- (void) _enqueueToCreateVMForModels:(NSArray *)models
                           inSection:(NSInteger)section
                              change:(NSKeyValueChange)change
                             indexes:(NSIndexSet *)indexes {
    ASSERT_MAIN_THREAD
    
    if (NSKeyValueChangeSetting == change) {
        NSAssert(!indexes, @"indexes MUST be nil if change is NSKeyValueChangeSetting");
    }
    else if (NSKeyValueChangeRemoval == change) {
        NSAssert(!models, @"models MUST be nil if change is NSKeyValueChangeRemoval");
        NSAssert(indexes, @"indexes MUST NOT be nil if change is NSKeyValueChangeRemoval");
    }
    
    // do not enqueue if it is not allowable to load cell view models
    if (![self _shouldLoadCellViewModels]) {
        return;
    }
    
    // do not enqueue insert or replacement for empty models
    if (!models.count && (NSKeyValueChangeInsertion == change || NSKeyValueChangeReplacement == change)) {
        return;
    }
    
    __block NSMutableArray * viewModels = nil;
    __block NSMutableArray *heads = nil;
    
    CELL_VM_Q_ASYNC_BEGIN
    
    if (NSKeyValueChangeRemoval != change) {
        viewModels = [NSMutableArray arrayWithCapacity: models.count];
        heads = [NSMutableArray array];
        
        [models enumerateObjectsUsingBlock:^(id model, NSUInteger idx, BOOL *stop) {
            CellViewModel *viewModel = [self cellViewModelForModel:model];
            viewModel.active = YES;
            [viewModel layoutIfNeededWithCellWidth:self.cellWidth];
            
            NSAssert(viewModel, @"viewModel MUST NOT be nil");
            if (viewModel.sectionHeader == NO) {
                [viewModels addObject:viewModel];
            }else{
                [heads addObject:viewModel];
            }
        }];
    }
    
    CELL_VM_Q_ASYNC_MAIN_BEGIN
    
    FeedArray *feedArray = _viewModelSections[section];
    
    if (NSKeyValueChangeSetting == change) {
        feedArray.headers = heads;
        feedArray.items = viewModels;
    }
    else if (NSKeyValueChangeInsertion == change) {
        [[feedArray mutableArrayValueForKey:@"items"] insertObjects:viewModels atIndexes:indexes];
    }
    else if (NSKeyValueChangeRemoval == change) {
        [[feedArray mutableArrayValueForKey:@"items"] removeObjectsAtIndexes:indexes];
    }
    else if (NSKeyValueChangeReplacement == change) {
        [[feedArray mutableArrayValueForKey:@"items"] replaceObjectsAtIndexes:indexes withObjects:viewModels];
    }
    
    [self didCreateViewModels:feedArray.items
                    forModels:models
                    inSection:section];
    CELL_VM_Q_ASYNC_END
}

- (void) didCreateViewModels:(NSArray *)viewModels
                   forModels:(NSArray* )models
                   inSection:(NSInteger)section{
    
}

- (void) _notifyEmptyModelsChange {
    [self willChangeValueForKey:@"emptyModels"];
    [self didChangeValueForKey:@"emptyModels"];
}

- (void) _notifyEmptyViewModelsChange {
    [self willChangeValueForKey:@"emptyViewModels"];
    [self didChangeValueForKey:@"emptyViewModels"];
}

- (id) _modelInSections:(NSArray *)sections AtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= sections.count ) {
        return nil;
    }
    
    FeedArray *feedArray = sections[indexPath.section];
    if (indexPath.row >= feedArray.items.count) {
        return nil;
    }
    
    return feedArray.items[indexPath.row];
}

- (NSArray *) _modelsInSections:(NSArray *)sections section:(NSInteger)section {
    FeedArray *feedArray = sections[section];
    return feedArray.items;
}

- (NSIndexPath *) _indexPathForModelInSections:(NSArray *)sections
                                     findBlock:(BOOL(^)(id))compareBlock {
    __block NSIndexPath * indexPath = nil;
    
    [sections enumerateObjectsUsingBlock:^(FeedArray *sectionModels, NSUInteger sectionIndex, BOOL *sectionStop) {
        [sectionModels.items enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            *stop = compareBlock(obj);
            *sectionStop = *stop;
            if (*stop){
                indexPath = [NSIndexPath indexPathForRow: idx inSection: sectionIndex];
            }
        }];
    }];
    
    return indexPath;
}

@end

#pragma mark -

@implementation FeedViewModel(MultipleSections)

@dynamic sectionCount;
- (NSInteger) sectionCount {
    return _viewModelSections.count;
}

@dynamic staticCount;
- (NSInteger) staticCount {
    NSNumber *num = GET_ASSOCIATED_OBJ();
    return num.integerValue;
}
- (void) setStaticCount:(NSInteger)num {
    NSNumber *staticCount = @(num);
    SET_ASSOCIATED_OBJ_RETAIN_NONATOMIC(staticCount);
}

- (instancetype) init {
    return [self initWithSectionCount:1];
}

- (instancetype) initWithSectionCount:(NSInteger) count {
    return [self initWithSectionCount:count autoLoadViewModesl:YES];
}

- (instancetype) initWithStaticCount:(NSInteger)count {
    self.staticCount = count;
    return [self initWithSectionCount:count];
}

- (instancetype) initWithSectionCount:(NSInteger)count
                   autoLoadViewModesl:(BOOL) autoload {
    
    if (self = [super init]) {
        _asyncLoadingCount = 0;
        _autoLoadViewModels = autoload;
        
        _modelSections = [NSMutableArray arrayWithCapacity:count];
        _viewModelSections = [NSMutableArray arrayWithCapacity:count];
        
        _cellViewModelsMapping = [NSMutableDictionary dictionaryWithCapacity:8];
        
        for (int i =0; i!= count; ++i) {
            [_modelSections addObject:[FeedArray array]];
            [_viewModelSections addObject:[FeedArray array]];
        }
        
        [self registerCellViewModelClasses];
    }
    
    return self;
}

- (void) resetModelSections:(NSArray *)modelSections {
    
    @synchronized(_modelSections) {
        if (_modelSections == modelSections) {
            return;
        }
        
        NSMutableArray *mSections = [NSMutableArray arrayWithCapacity:modelSections.count];
        [modelSections enumerateObjectsUsingBlock:^(NSArray * models, NSUInteger idx, BOOL *stop) {
            FeedArray *modelsArray = [FeedArray array];
            modelsArray.items = [NSMutableArray arrayWithArray:models];
            [mSections addObject:modelsArray];
        }];
        
        [self willChangeValueForKey:@"modelSections"];
        _modelSections = mSections;
        [self didChangeValueForKey:@"modelSections"];
        
        [self _notifyEmptyModelsChange];
    }
    
    if (![self _shouldLoadCellViewModels]) {
        return;
    }
    
    [self _reloadCellViewModles];
}

- (void) setModels:(NSArray *)models fromSection:(NSInteger)fromSection {
    ASSERT_MAIN_THREAD
    
    // replace nil with empty array
    if (!models) {
        models = @[];
    }
    
    NSInteger toSection = fromSection+models.count-1;
    if (_modelSections.count-1<toSection) {
        return;
    }
    
    @synchronized(_modelSections) {
        
        for (NSInteger i = fromSection; i<=toSection; i++) {
            NSAssert(i < _modelSections.count, @"The section index should less than or equal to the models section count");
            NSArray *currentModels = [models objectAtIndex:(i-fromSection)];
            FeedArray *sectionModels = _modelSections[i];
            sectionModels.items = [NSMutableArray arrayWithArray:currentModels];
            [self _notifyEmptyModelsChange];
        }
        
    }
    
    for (NSInteger i= fromSection; i<=toSection; i++) {
        FeedArray *currentSectionModels = _modelSections[i];
        [self _enqueueToCreateVMForModels:currentSectionModels.items
                                inSection:i
                                   change:NSKeyValueChangeSetting
                                  indexes:nil];
    }
}

- (void) setModels:(NSArray *)models inSection:(NSInteger)section {
    ASSERT_MAIN_THREAD
    
    // replace nil with empty array
    if (!models) {
        models = @[];
    }
    
    @synchronized(_modelSections) {
        NSAssert(section < _modelSections.count, @"The section index should less than or equal to the models section count");
        
        FeedArray *sectionModels = _modelSections[section];
        sectionModels.items = [NSMutableArray arrayWithArray:models];
        
        [self _notifyEmptyModelsChange];
    }
    
    [self _enqueueToCreateVMForModels:models
                            inSection:section
                               change:NSKeyValueChangeSetting
                              indexes:nil];
}

- (void) insertModels:(NSArray*) models atIndex:(NSInteger)index inSection:(NSInteger)section {
    ASSERT_MAIN_THREAD
    
    NSIndexSet *indexes = nil;
    
    @synchronized(_modelSections) {
        NSAssert(section <= _modelSections.count, @"The section index should less than or equal to the models section count");
        
        FeedArray *sectionModels = _modelSections[section];
        NSAssert(index <= sectionModels.items.count, @"index should be not larger than models count in section");
        
        if (!models.count) {
            return;
        }
        
        indexes = [NSIndexSet indexSetWithIndexesInRange: NSMakeRange(index, models.count)];
        [[sectionModels mutableArrayValueForKey:@"items"] insertObjects:models atIndexes:indexes];
        
        [self _notifyEmptyModelsChange];
    }
    
    [self _enqueueToCreateVMForModels:models
                            inSection:section
                               change:NSKeyValueChangeInsertion
                              indexes:indexes];
}

- (void) appendModels:(NSArray *)models inSection:(NSInteger)section {
    NSMutableArray *lastModels = [NSMutableArray array];;
    [[self modelsInSection:section] enumerateObjectsUsingBlock:^(id model, NSUInteger idx, BOOL *stop) {
        CellViewModel *viewModel = [self cellViewModelForModel:model];
        if (viewModel.sectionHeader == NO) {
            [lastModels addObject:model];
        }
    }];
    [self insertModels:models atIndex:lastModels.count inSection:section];
}

- (void) removeModelsAtIndexes:(NSIndexSet *)indexes inSection:(NSInteger)section {
    ASSERT_MAIN_THREAD
    
    @synchronized(_modelSections) {
        NSAssert(section < _modelSections.count, @"The section index should less than or equal to the models section count");
        
        FeedArray * sectionModels = _modelSections[section];
        NSAssert(indexes.firstIndex >= 0 && indexes.lastIndex <= sectionModels.items.count, @"indexes is out of range");
        
        [[sectionModels mutableArrayValueForKey:@"items"] removeObjectsAtIndexes:indexes];
        
        [self _notifyEmptyModelsChange];
    }
    
    [self _enqueueToCreateVMForModels:nil
                            inSection:section
                               change:NSKeyValueChangeRemoval
                              indexes:indexes];
}

- (void) replaceModels:(NSArray *)models atIndexes:(NSIndexSet *)indexes inSection:(NSInteger)section {
    ASSERT_MAIN_THREAD
    
    @synchronized(_modelSections) {
        NSAssert(section <= _modelSections.count, @"section index should less or equal to the number of sections");
        
        FeedArray *sectionModels = _modelSections[section];
        
        [[sectionModels mutableArrayValueForKey:@"items"] replaceObjectsAtIndexes:indexes withObjects:models];
        
        [self _notifyEmptyModelsChange];
    }
    
    [self _enqueueToCreateVMForModels:models
                            inSection:section
                               change:NSKeyValueChangeReplacement
                              indexes:indexes];
}

- (void) insertSectionAtIndex:(NSInteger)section withModels:(NSArray*)models {
    ASSERT_MAIN_THREAD
    
    @synchronized(_modelSections) {
        NSAssert(section <= _modelSections.count, @"section index should less or equal to the number of sections");
        
        FeedArray *sectionModels = [FeedArray array];
        if (models.count) {
            sectionModels.items = [NSMutableArray arrayWithArray:models];
        }
        
        [[self mutableArrayValueForKey:@"modelSections"] insertObject:sectionModels atIndex:section];
        
        [self _notifyEmptyModelsChange];
    }
    
    if (![self _shouldLoadCellViewModels]) {
        return;
    }
    
    CELL_VM_Q_ASYNC_ENQUEUE_BEGIN
    
    FeedArray *sectionViewModels = [FeedArray array];
    [[self mutableArrayValueForKey:@"viewModelSections"] insertObject:sectionViewModels atIndex:section];
    
    CELL_VM_Q_ASYNC_ENQUEUE_END
    
    [self _enqueueToCreateVMForModels:models
                            inSection:section
                               change:NSKeyValueChangeSetting
                              indexes:nil];
}

- (void) removeSectionAtIndex:(NSInteger)section {
    ASSERT_MAIN_THREAD
    
    @synchronized(_modelSections) {
        NSAssert(section < _modelSections.count , @"section index should less than the number of sections");
        [[self mutableArrayValueForKey:@"modelSections"] removeObjectAtIndex:section];
        
        [self _notifyEmptyModelsChange];
    }
    
    if (![self _shouldLoadCellViewModels]) {
        return;
    }
    
    CELL_VM_Q_ASYNC_ENQUEUE_BEGIN
    [[self mutableArrayValueForKey:@"viewModelSections"] removeObjectAtIndex:section];
    CELL_VM_Q_ASYNC_ENQUEUE_END
}

- (id) modelAtIndexPath:(NSIndexPath *)indexPath {
    @synchronized(_modelSections) {
        return [self _modelInSections:_modelSections AtIndexPath:indexPath];
    }
}

- (CellViewModel *) viewModelAtIndexPath:(NSIndexPath *)indexPath {
    ASSERT_MAIN_THREAD
    
    return [self _modelInSections:_viewModelSections AtIndexPath:indexPath];
}

- (NSArray *) headViewModelAtSection:(NSInteger)section {
    ASSERT_MAIN_THREAD
    if (section >= _viewModelSections.count ) {
        return nil;
    }
    FeedArray *feedArray = _viewModelSections[section];
    return feedArray.headers;
}

- (NSArray*) modelsInSection:(NSInteger)section {
    @synchronized(_modelSections) {
        return [self _modelsInSections:_modelSections section:section];
    }
}

- (NSArray*) viewModelsInSection:(NSInteger)section {
    ASSERT_MAIN_THREAD
    return [self _modelsInSections:_viewModelSections section:section];
}

- (NSIndexPath *) indexPathForModel:(id)model {
    @synchronized(_modelSections) {
        return [self _indexPathForModelInSections:_modelSections findBlock:^BOOL(id object) {
            return [model isEqual:object];
        }];
    }
}

- (NSIndexPath *) indexPathForViewModel:(id)viewModel {
    ASSERT_MAIN_THREAD
    
    return [self _indexPathForModelInSections:_viewModelSections findBlock:^BOOL(id object) {
        return [viewModel isEqual:object];
    }];
}

- (NSIndexPath *) indexPathForModelFindBlock:(BOOL(^)(id))compareBlock {
    @synchronized(_modelSections) {
        return [self _indexPathForModelInSections:_modelSections findBlock:compareBlock];
    }
}

- (NSIndexPath *) indexPathForViewModelFindBlock:(BOOL(^)(id))compareBlock {
    ASSERT_MAIN_THREAD
    
    return [self _indexPathForModelInSections:_viewModelSections findBlock:compareBlock];
}

#pragma mark - rac kvo

#define DEFAULT_KVO_OPTIONS ( NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld )

- (RACSignal *)rac_valuesAndChangesForModelSections {
    return [self rac_valuesAndChangesForModelSectionsOptions:DEFAULT_KVO_OPTIONS];
}

- (RACSignal *)rac_valuesAndChangesForViewModelSections {
    return [self rac_valuesAndChangesForViewModelSectionsOptions:DEFAULT_KVO_OPTIONS];
}

- (RACSignal *)rac_valuesAndChangesForModelSectionsOptions:(NSKeyValueObservingOptions)options {
    return [self rac_valuesAndChangesForKeyPath:@"modelSections"
                                        options:options
                                       observer:nil];
}

- (RACSignal *)rac_valuesAndChangesForViewModelSectionsOptions:(NSKeyValueObservingOptions)options {
    return [self rac_valuesAndChangesForKeyPath:@"viewModelSections"
                                        options:options
                                       observer:nil];
}

- (RACSignal *)rac_valuesAndChangesForModelsInSection:(NSInteger)section {
    return [self rac_valuesAndChangesForModelsInSection:section
                                                options:DEFAULT_KVO_OPTIONS];
}

- (RACSignal *)rac_valuesAndChangesForViewModelsInSection:(NSInteger)section {
    return [self rac_valuesAndChangesForViewModelsInSection:section
                                                    options:DEFAULT_KVO_OPTIONS];
}

- (RACSignal *)rac_valuesAndChangesForModelsInSection:(NSInteger)section
                                              options:(NSKeyValueObservingOptions)options {
    FeedArray *array = [_modelSections objectAtIndex:section];
    return [array rac_valuesAndChangesForKeyPath:@"items"
                                         options:options
                                        observer:nil];
}
- (RACSignal *)rac_valuesAndChangesForViewModelsInSection:(NSInteger)section
                                                  options:(NSKeyValueObservingOptions)options {
    FeedArray *array = [_viewModelSections objectAtIndex:section];
    return [array rac_valuesAndChangesForKeyPath:@"items"
                                         options:options
                                        observer:nil];
}

@end

#pragma mark -

@implementation FeedViewModel

@synthesize cellWidth = _cellWidth;
- (void) setCellWidth:(CGFloat)cellWidth {
    if (_cellWidth == cellWidth) {
        return;
    }
    
    _cellWidth = cellWidth;
    
    if ([self _shouldLoadCellViewModels]) {
        [self _reloadCellViewModles];
    }
}

@dynamic asyncLoadingCellVM;
- (BOOL) isAsyncLoadingCellVM {
    ASSERT_MAIN_THREAD
    return _asyncLoadingCount;
}

@dynamic emptyModels;
- (BOOL) isEmptyModels {
    ASSERT_MAIN_THREAD
    
    __block NSInteger modelsCount = 0;
    [_modelSections enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        modelsCount += [self modelsInSection:idx].count;
        if (modelsCount) {
            *stop = YES;
        }
    }];
    
    return !modelsCount;
}

@dynamic emptyViewModels;
- (BOOL) isEmptyViewModels {
    ASSERT_MAIN_THREAD
    
    BOOL result = YES;
    
    if (_viewModelSections.count > 1) {
        result = NO;
    }
    else if (_viewModelSections.count == 1) {
        result = [self viewModelsInSection:0].count == 0;
    }
    
    return result;
}

@synthesize autoLoadViewModels = _autoLoadViewModels;
- (void) setAutoLoadViewModels:(BOOL)autoLoadViewModels {
    if (_autoLoadViewModels == autoLoadViewModels) {
        return;
    }
    
    _autoLoadViewModels = autoLoadViewModels;
    
    if ([self _shouldLoadCellViewModels]) {
        [self _reloadCellViewModles];
    }
}

- (void) registerCellViewModelClasses {
}

- (void) registerCellViewModelClass:(Class)cellModelClass forModelClass:(Class)modelClass {
    if (cellModelClass && ![cellModelClass isSubclassOfClass:CellViewModel.class]) {
        [[NSException exceptionWithName:NSInvalidArgumentException
                                 reason:@"cellModelClass MUST be subclass of CellViewModel"
                               userInfo:nil] raise];
    }
    
    [_cellViewModelsMapping setValue:cellModelClass
                              forKey:NSStringFromClass(modelClass)];
}

- (Class) getRegisteredCellViewModelClassForClass:(Class)modelClass {
    // NSString private class
    if ([modelClass isSubclassOfClass:NSString.class]) {
        modelClass = NSString.class;
    }
    
    return [_cellViewModelsMapping valueForKey:NSStringFromClass(modelClass)];
}

- (Class) cellViewModelClassForModel:(NSObject *) model {
    return model.viewModelClass ? model.viewModelClass : [self getRegisteredCellViewModelClassForClass:model.class];
}

- (CellViewModel *) cellViewModelForModel:(NSObject *)model {
    CellViewModel *result = nil;
    
    Class cellViewModelClass = [self cellViewModelClassForModel:model];
    if (cellViewModelClass) {
        result = [[cellViewModelClass alloc] initWithModel:model];
    }
    
    return result;
}

- (void) setActive:(BOOL)active {
    [super setActive: active];
    [_viewModelSections enumerateObjectsUsingBlock:^(FeedArray *section, NSUInteger idx, BOOL *stop) {
        [section.items enumerateObjectsUsingBlock:^(CellViewModel *obj, NSUInteger idx, BOOL *stop) {
            obj.active = active;
        }];
    }];
}
@end
