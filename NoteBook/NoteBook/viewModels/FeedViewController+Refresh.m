//
//  FeedViewController+Refresh.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "FeedViewController+Refresh.h"
#import "UIView+HUD.h"
#import "Masonry.h"


@interface FeedViewController(Refresh_private)

@property (nonatomic, assign) BOOL loadingHead;
@property (nonatomic, assign) BOOL loadingFoot;

@end

#pragma mark -

@implementation FeedViewController(Refresh_private)

@dynamic loadingHead;
- (BOOL) loadingHead {
    NSNumber *num = GET_ASSOCIATED_OBJ();
    return num.boolValue;
}
- (void) setLoadingHead:(BOOL)b {
    NSNumber *loadingHead = @(b);
    SET_ASSOCIATED_OBJ_ASSIGN(loadingHead);
}

@dynamic loadingFoot;
- (BOOL) loadingFoot {
    NSNumber *num = GET_ASSOCIATED_OBJ();
    return num.boolValue;
}
- (void) setLoadingFoot:(BOOL)b {
    NSNumber *loadingFoot = @(b);
    SET_ASSOCIATED_OBJ_ASSIGN(loadingFoot);
}

- (void) _addHeadRefresh {
    @weakify(self)
    
    if (self.viewModel.headerExecuting) {
        [self.tableView addLegendHeaderWithRefreshingBlock:^{
            @strongify(self)
            
            // Can not refresh head while loading foot
            if (![self.viewModel shouldLoadAtHead] || self.loadingFoot) {
                [self.tableView.header endRefreshing];
                return;
            }
            
            if (self.loadingHead) {
                return;
            }
            
            [self.viewModel loadAtHead];
            [self.tableView.footer resetNoMoreData];
        }];
        
        [[self.viewModel.headerExecuting takeUntil:self.rac_willDeallocSignal]
         subscribeNext:^(NSNumber *value) {
             @strongify(self)
             
             self.loadingHead = value.boolValue;
             
             if (!value.boolValue) {
                 [self.tableView.header endRefreshing];
             }
         }];
    }
}

- (void) _addFootRefresh {
    @weakify(self)
    
    if (self.viewModel.footerExecuting) {
        if (!self.tableView.footer) {
            MJRefreshLegendFooter *footer =\
            [self.tableView addLegendFooterWithRefreshingBlock:^{
                @strongify(self)
                
                // Can not loading foot while refreshing head
                if (![self.viewModel shouldLoadAtFoot] || self.loadingHead) {
                    [self.tableView.footer endRefreshing];
                    return;
                }
                
                if (self.loadingFoot) {
                    return;
                }
                
                [self.viewModel loadAtFoot];
            }];
            
            [footer setTitle:@"~" forState:MJRefreshFooterStateNoMoreData];
        }
        
        [[self.viewModel.footerExecuting takeUntil:self.rac_willDeallocSignal]
         subscribeNext:^(NSNumber *value) {
             self.loadingFoot = value.boolValue;
         }];
        
        [[RACObserve(self.viewModel, loadMoreStatus) takeUntil:self.rac_willDeallocSignal]
         subscribeNext:^(NSNumber *value) {
             @strongify(self)
             
             if (FeedViewModelLoadMoreStatusMore == value.integerValue){
                 self.tableView.footer.hidden = NO;
                 [self.tableView.footer endRefreshing];
             }
             else if(FeedViewModelLoadMoreStatusNoMore == value.integerValue) {
                 self.tableView.footer.hidden = YES;
                 [self.tableView.footer noticeNoMoreData];
             }
             else if (FeedViewModelLoadMoreStatusEmpty == value.integerValue) {
                 self.tableView.footer.hidden = YES;
             }
         }];
        
        [[RACObserve(self.viewModel, footerAutoRefresh) takeUntil:self.rac_willDeallocSignal]
         subscribeNext:^(NSNumber* num) {
             @strongify(self)
             
             self.tableView.footer.automaticallyRefresh = num.boolValue;
         }];
        
        [[RACObserve(self.viewModel, emptyViewModels) takeUntil:self.rac_willDeallocSignal]
         subscribeNext:^(id _) {
             @strongify(self)
             
             if (self.viewModel.emptyViewModels) {
                 [self.viewModel updateLoadingMoreStatus:FeedViewModelLoadMoreStatusEmpty];
             }
         }];
    }
}

@end

#pragma mark -

@implementation FeedViewController(Refresh)

- (void) addFreshingControls {
    [self _addHeadRefresh];
    [self _addFootRefresh];
    
    [self addInitLoadingHUD];
}

- (void) addInitLoadingHUD {
    @weakify(self)
    
    [[RACObserve(self.viewModel, hudExecutingSignals) takeUntil:self.rac_willDeallocSignal]
     subscribeNext:^(id _) {
         @strongify(self)
         
         RACSignal *hudExecuting = nil;
         
         if ([self.viewModel.hudExecutingSignals count]) {
             hudExecuting = [RACSignal merge:self.viewModel.hudExecutingSignals];
         }
         else if (self.viewModel.headerExecuting) {
             hudExecuting = [self.viewModel.headerExecuting map:^id(NSNumber *isHeaderExecuting) {
                 @strongify(self)
                 
                 if (self.tableView.header) {
                     return @(isHeaderExecuting.boolValue && MJRefreshHeaderStateIdle == self.tableView.header.state);
                 }
                 else {
                     return isHeaderExecuting;
                 }
             }];
         }
         
         [self.view rebindHUDWithExecuting:hudExecuting];
     }];
}

@end

#pragma mark -

@implementation FeedViewController(PlaceHolder)

@dynamic placeHolderView;
@dynamic placeHolderTopMargin;

- (EmptyPlaceHolderView*) placeHolderView {
    return GET_ASSOCIATED_OBJ();
}

- (void) setPlaceHolderView:(EmptyPlaceHolderView *)placeHolderView {
    SET_ASSOCIATED_OBJ_RETAIN_NONATOMIC(placeHolderView);
}

- (NSNumber*) placeHolderTopMargin {
    return GET_ASSOCIATED_OBJ();
}

- (void) setPlaceHolderTopMargin:(NSNumber *)placeHolderTopMargin {
    SET_ASSOCIATED_OBJ_RETAIN_NONATOMIC(placeHolderTopMargin);
}


- (void) _showPlaceHolder:(NSString *)text{
    if (!self.placeHolderView) {
        EmptyPlaceHolderView *placeHolderView = [[EmptyPlaceHolderView alloc] initWithFrame:self.view.bounds];
        [self.view insertSubview:placeHolderView aboveSubview:self.tableView];
        placeHolderView.image = [UIImage imageNamed:@"pic_null"];
        placeHolderView.additionalTopOffset = -self.placeHolderTopMargin.floatValue;
        self.placeHolderView = placeHolderView;
    }
    
    @weakify(self)
    [self.placeHolderView mas_makeConstraints:^(MASConstraintMaker *make) {
        @strongify(self)
        make.top.equalTo(self.tableView.mas_top).offset(self.placeHolderTopMargin.floatValue);
        make.left.equalTo(self.tableView.mas_left);
        make.bottom.equalTo(self.tableView.mas_bottom);
        make.right.equalTo(self.tableView.mas_right);
    }];
    self.placeHolderView.string = text;
}

- (void) _dismissPlaceHolder {
    if (!self.placeHolderView) {
        return;
    }
    [self.placeHolderView removeFromSuperview];
    self.placeHolderView = nil;
}

- (void) setupEmptyPlaceHolder {
    [RACObserve(self.viewModel, showPlaceHolderView) subscribeNext:^(NSNumber *num) {
        if (num.boolValue) {
            [self _showPlaceHolder:self.viewModel.placeHolderText];
        }
        else {
            [self _dismissPlaceHolder];
        }
    }];
}

@end

