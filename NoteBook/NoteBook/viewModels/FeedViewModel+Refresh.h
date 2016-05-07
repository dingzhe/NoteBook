//
//  FeedViewModel+Refresh.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "FeedViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

typedef NS_ENUM(NSInteger, FeedViewModelLoadMoreStatus) {
    FeedViewModelLoadMoreStatusEmpty,
    FeedViewModelLoadMoreStatusMore,
    FeedViewModelLoadMoreStatusNoMore
};

@interface FeedViewModel(Refresh)

@property (nonatomic, strong) RACSignal *headerExecuting;
@property (nonatomic, strong) RACSignal *footerExecuting;
@property (nonatomic, strong) NSArray *hudExecutingSignals;

@property (nonatomic, assign, readonly) FeedViewModelLoadMoreStatus loadMoreStatus;
@property (nonatomic, assign, readonly) BOOL footerAutoRefresh;

@property (nonatomic, assign) BOOL viewAppeared;

- (void) addHudExecuting:(RACSignal *)executing;
- (void) removeHudExecuting:(RACSignal *)executing;

@end

@interface FeedViewModel(Refresh_Override)

- (void) loadAtHead;
- (void) loadAtFoot;

- (BOOL) shouldLoadAtHead;
- (BOOL) shouldLoadAtFoot;

- (void) updateLoadingMoreStatus:(FeedViewModelLoadMoreStatus) status; // set footerAutoRefresh to YES
- (void) updateLoadingMoreStatus:(FeedViewModelLoadMoreStatus) status
               footerAutoRefresh:(BOOL) autoRefresh;
- (void) updateLoadingMoreStatusAtPage:(NSInteger)page
                              pageSize:(NSInteger)pageSize
                          responseSize:(NSInteger)responseSize;

- (BOOL) shouldInitLoad;
- (void) initLoad;

@end

#pragma mark - PlaceHolder

@interface FeedViewModel (PlaceHolder)

@property (nonatomic, strong) NSString *placeHolderText;
@property (nonatomic, assign) BOOL showPlaceHolderView;
@end
