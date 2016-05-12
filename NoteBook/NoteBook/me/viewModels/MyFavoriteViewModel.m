//
//  MyFavoriteViewModel.m
//  NoteBook
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "MyFavoriteViewModel.h"

#import "WeeklyListCellViewModel.h"
#import "FeedViewModel+MultipleSections.h"
#import "FeedViewController+Refresh.h"
#import "DDLog.h"

@interface MyFavoriteViewModel ()

@property (nonatomic,strong) RACCommand *getFavoriteBlogListCommand;
@property (nonatomic,strong) SWGFavoriteBlogListResponses *favoriteBlogListResponses;

@end

@implementation MyFavoriteViewModel

+ (instancetype) viewModel {
    return [[self alloc] initWithSectionCount:1];
}
- (instancetype) initWithSectionCount:(NSInteger) count {
    self = [super initWithSectionCount:count];
    if (self) {
        @weakify(self)
        _getFavoriteBlogListCommand = [NoteBookWeeklyService.service favoriteBlogListCommandEnable:nil];
        [_getFavoriteBlogListCommand.responses subscribeNext:^(SWGFavoriteBlogListResponses *response) {
            @strongify(self)
            [self updateFromGetFavoriteBlogListResponse:response];
        }];
        [_getFavoriteBlogListCommand.errors subscribeNext:^(NSError *error) {
            //            DDLogError(@"Error while get resume browse history:%@", error);
        }];
        
        self.headerExecuting = _getFavoriteBlogListCommand.executing;
        self.hudExecutingSignals = @[_getFavoriteBlogListCommand.executing];
        
        self.placeHolderText = @"暂无收藏";
        [[RACSignal combineLatest:@[RACObserve(self, favoriteBlogListResponses)]] subscribeNext:^(id _) {
            @strongify(self)
            NSInteger requestCount = ((self.favoriteBlogListResponses.data!=nil)?[self.favoriteBlogListResponses.data count]:0);
            self.showPlaceHolderView = (requestCount == 0);
        }];
        
    }
    return self;
}

- (void) loadAtHead {
    SWGFavoriteBlogListRequest *request = [[SWGFavoriteBlogListRequest alloc] init];
    request.uid = UserModel.currentUser.uid;
    [_getFavoriteBlogListCommand execute:request];
}

- (void)updateFromGetFavoriteBlogListResponse:(SWGFavoriteBlogListResponses*)response {
    self.favoriteBlogListResponses = response;
    [self resetModelSections:@[[self FavoriteBlogListModels]]];
}

- (NSMutableArray*)FavoriteBlogListModels {
    NSMutableArray *modelAry = [NSMutableArray array];
    
    [modelAry addObjectsFromArray:_favoriteBlogListResponses.data];
    
    return modelAry;
}



- (void) registerCellViewModelClasses {
    [super registerCellViewModelClasses];
    
    [self registerCellViewModelClass:WeeklyListCellViewModel.class forModelClass:SWGWeekly.class];
}


@end