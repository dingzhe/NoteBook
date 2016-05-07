//
//  FeedViewController+Refresh.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "FeedViewController.h"
#import "FeedViewModel+Refresh.h"
#import "MJRefresh.h"
#import "EmptyPlaceHolderView.h"

@interface FeedViewController (Refresh)
- (void) addFreshingControls;
- (void) addInitLoadingHUD;

@end

#pragma mark - PlaceHolder

@interface FeedViewController (PlaceHolder)

@property (nonatomic, strong) EmptyPlaceHolderView *placeHolderView;
@property (nonatomic, strong) NSNumber *placeHolderTopMargin;

- (void) setupEmptyPlaceHolder;
@end
