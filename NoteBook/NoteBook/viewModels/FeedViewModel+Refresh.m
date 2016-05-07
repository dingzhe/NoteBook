//
//  FeedViewModel+Refresh.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "FeedViewModel+Refresh.h"

@interface FeedViewModel(Refresh_private)

@property (nonatomic, strong) RACCompoundDisposable *asyncLoadingKVODisposable;

@end

#pragma mark -

@implementation FeedViewModel(Refresh_private)

@dynamic asyncLoadingKVODisposable;
- (RACCompoundDisposable *) asyncLoadingKVODisposable {
    return GET_ASSOCIATED_OBJ();
}
- (void) setAsyncLoadingKVODisposable:(RACCompoundDisposable *)asyncLoadingKVODisposable {
    if (self.asyncLoadingKVODisposable) {
        [self.asyncLoadingKVODisposable dispose];
        [self.rac_deallocDisposable removeDisposable:self.asyncLoadingKVODisposable];
    }
    
    if (asyncLoadingKVODisposable) {
        [self.rac_deallocDisposable addDisposable:asyncLoadingKVODisposable];
    }
    
    SET_ASSOCIATED_OBJ_RETAIN_NONATOMIC(asyncLoadingKVODisposable);
}

- (void) setLoadMoreStatus:(FeedViewModelLoadMoreStatus)result {
    NSNumber *loadMoreStatus = @(result);
    SET_ASSOCIATED_OBJ_RETAIN_NONATOMIC(loadMoreStatus);
}

- (void)_updateLoadMoreStatus:(FeedViewModelLoadMoreStatus)loadMoreStatus
 watingForTableViewRefreshing:(BOOL)waiting {
    if (!waiting) {
        self.loadMoreStatus = loadMoreStatus;
    }
    else {
        @weakify(self)
        
        RACCompoundDisposable *disposable = [RACCompoundDisposable compoundDisposable];
        
        [disposable addDisposable:
         [RACObserve(self, asyncLoadingCellVM) subscribeNext:^(NSNumber *async) {
            @strongify(self)
            
            if (!async.boolValue) {
                // delay updating load more status to wait for ui updating complete,
                // e.g. UITableView cells completely inserted and content sized updated. If not,
                // duplicated footer refreshing action will fire at the same time.
                [RACScheduler.mainThreadScheduler afterDelay:0.1f schedule:^{
                    self.loadMoreStatus = loadMoreStatus;
                }];
                
                self.asyncLoadingKVODisposable = nil;
            }
        }]
         ];
        
        self.asyncLoadingKVODisposable = disposable;
    }
}

@end

#pragma mark -

@implementation FeedViewModel(Refresh)

@dynamic headerExecuting;
- (RACSignal *) headerExecuting {
    return GET_ASSOCIATED_OBJ();
}
- (void) setHeaderExecuting:(RACSignal *)headerExecuting {
    SET_ASSOCIATED_OBJ_RETAIN_NONATOMIC(headerExecuting);
}

@dynamic footerExecuting;
- (RACSignal *) footerExecuting {
    return GET_ASSOCIATED_OBJ();
}
- (void) setFooterExecuting:(RACSignal *)footerExecuting {
    SET_ASSOCIATED_OBJ_RETAIN_NONATOMIC(footerExecuting);
}

@dynamic hudExecutingSignals;
- (NSArray *) hudExecutingSignals {
    return GET_ASSOCIATED_OBJ();
}
- (void) setHudExecutingSignals:(NSArray *)hudExecutingSignals {
    SET_ASSOCIATED_OBJ_RETAIN_NONATOMIC(hudExecutingSignals);
}

@dynamic loadMoreStatus;
- (FeedViewModelLoadMoreStatus) loadMoreStatus {
    NSNumber *num = GET_ASSOCIATED_OBJ();
    return num.integerValue;
}

@dynamic footerAutoRefresh;
- (BOOL) footerAutoRefresh {
    NSNumber *num = GET_ASSOCIATED_OBJ();
    return num.boolValue;
}
- (void) setFooterAutoRefresh:(BOOL)b {
    NSNumber *footerAutoRefresh = @(b);
    SET_ASSOCIATED_OBJ_RETAIN_NONATOMIC(footerAutoRefresh);
}

@dynamic viewAppeared;
- (BOOL) viewAppeared {
    NSNumber *num = GET_ASSOCIATED_OBJ();
    return num.boolValue;
}
- (void) setViewAppeared:(BOOL)b {
    NSNumber *viewAppeared = @(b);
    SET_ASSOCIATED_OBJ_RETAIN_NONATOMIC(viewAppeared);
}

- (void) addHudExecuting:(RACSignal *)executing {
    if ([self.hudExecutingSignals containsObject:executing]) {
        return;
    }
    
    NSMutableArray *signals = [NSMutableArray arrayWithCapacity:self.hudExecutingSignals.count + 1];
    if (self.hudExecutingSignals.count) {
        [signals addObjectsFromArray:self.hudExecutingSignals];
    }
    
    [signals addObject:executing];
    
    self.hudExecutingSignals = signals;
}

- (void) removeHudExecuting:(RACSignal *)executing {
    if (![self.hudExecutingSignals containsObject:executing]) {
        return;
    }
    
    NSMutableArray *signals = [NSMutableArray arrayWithCapacity:self.hudExecutingSignals.count];
    [signals removeObject:executing];
    
    self.hudExecutingSignals = signals;
}

- (void) loadAtHead:(BOOL)init {
    // to override
}

- (void) loadAtFoot {
    // to override
}

- (BOOL) shouldLoadAtHead {
    return YES;
}

- (BOOL) shouldLoadAtFoot {
    return YES;
}

- (void) updateLoadingMoreStatus:(FeedViewModelLoadMoreStatus) status {
    [self updateLoadingMoreStatus:status footerAutoRefresh:YES];
}

- (void) updateLoadingMoreStatus:(FeedViewModelLoadMoreStatus) status
               footerAutoRefresh:(BOOL)autoRefresh {
    [self _updateLoadMoreStatus:status watingForTableViewRefreshing:NO];
    self.footerAutoRefresh = autoRefresh;
}

- (void) updateLoadingMoreStatusAtPage:(NSInteger)page
                              pageSize:(NSInteger)pageSize
                          responseSize:(NSInteger)responseSize {
    if (0 == page && 0 == responseSize) {
        [self _updateLoadMoreStatus:FeedViewModelLoadMoreStatusEmpty
       watingForTableViewRefreshing:NO];
    }
    
    else {
        FeedViewModelLoadMoreStatus status = \
        (responseSize >= pageSize) ? FeedViewModelLoadMoreStatusMore : FeedViewModelLoadMoreStatusNoMore;
        BOOL waiting = responseSize > 0;
        
        [self _updateLoadMoreStatus:status watingForTableViewRefreshing:waiting];
    }
    
    self.footerAutoRefresh = YES;
}

- (BOOL) shouldInitLoad {
    BOOL result = NO;
    
    if (self.loadMoreStatus != FeedViewModelLoadMoreStatusNoMore && !self.viewAppeared && self.emptyModels) {
        result = YES;
    }
    self.viewAppeared = YES;
    
    return result;
}

- (void) initLoad {
    if ([self shouldInitLoad]) {
        [self loadAtHead];
    }
}

@end

#pragma mark - PlaceHolder

@implementation FeedViewModel (PlaceHolder)

@dynamic placeHolderText;
- (NSString *) placeHolderText {
    return GET_ASSOCIATED_OBJ();
}
- (void) setPlaceHolderText:(NSString *)placeHolderText {
    SET_ASSOCIATED_OBJ_RETAIN_NONATOMIC(placeHolderText);
}

@dynamic showPlaceHolderView;
- (BOOL) showPlaceHolderView {
    NSNumber *num = GET_ASSOCIATED_OBJ();
    return num.boolValue;
}
- (void) setShowPlaceHolderView:(BOOL)b {
    NSNumber *showPlaceHolderView = @(b);
    SET_ASSOCIATED_OBJ_RETAIN_NONATOMIC(showPlaceHolderView);
}

@end
