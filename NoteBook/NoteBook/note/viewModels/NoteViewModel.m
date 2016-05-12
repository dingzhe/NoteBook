//
//  NoteViewModel.m
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NoteViewModel.h"
#import "FeedViewModel+MultipleSections.h"
#import "FeedViewController+Refresh.h"
#import "NoteCellViewModel.h"
@interface NoteViewModel ()

@property (nonatomic,strong) RACCommand *getweeklyListCommand;
@property (nonatomic,strong) RACCommand *delWeeklyCommand;
@property (nonatomic,strong) SWGWeeklyListResponses *weeklyListResponses;

@end

@implementation NoteViewModel
+ (instancetype) viewModel {
    return [[self alloc] initWithSectionCount:1];
}
- (instancetype) initWithSectionCount:(NSInteger) count {
    self = [super initWithSectionCount:count];
    if (self) {
        @weakify(self) //@strongify(self)

        _getweeklyListCommand = [NoteBookWeeklyService.service myWeeklyCommandEnable:nil];
        [_getweeklyListCommand.responses subscribeNext:^(SWGWeeklyListResponses *response) {
            @strongify(self)
            [self updateFromGetWeeklyListResponse:response];
            [self showHUDMessage:@"同步成功"];
        }];
        [_getweeklyListCommand.errors subscribeNext:^(NSError *error) {
            //            DDLogError(@"Error while get resume browse history:%@", error);
        }];
        _delWeeklyCommand = [NoteBookWeeklyService.service delWeeklyCommandEnable:nil];
        [_delWeeklyCommand.responses subscribeNext:^(SWGResponses *response) {
            @strongify(self)
//            [[self tableView] reloadData];
            [self loadAtHead];
        }];
        self.headerExecuting = _getweeklyListCommand.executing;
        self.hudExecutingSignals = @[_getweeklyListCommand.executing];
        
        self.placeHolderText = @"暂无博客";
        [[RACSignal combineLatest:@[RACObserve(self, weeklyListResponses)]] subscribeNext:^(id _) {
            @strongify(self)
            NSInteger requestCount = ((self.weeklyListResponses.data!=nil)?[self.weeklyListResponses.data count]:0);
            self.showPlaceHolderView = (requestCount == 0);
        }];
        
    }
    return self;
}

- (void) loadAtHead {
    SWGWeeklyListRequest *request = [[SWGWeeklyListRequest alloc] init];
    request.uid = UserModel.currentUser.uid;
    [_getweeklyListCommand execute:request];
}

- (void)updateFromGetWeeklyListResponse:(SWGWeeklyListResponses*)response {
    self.weeklyListResponses = response;
    [self resetModelSections:@[[self WeeklyListModels]]];
}

- (NSMutableArray*)WeeklyListModels {
    NSMutableArray *modelAry = [NSMutableArray array];
    
    [modelAry addObjectsFromArray:_weeklyListResponses.data];
    
    return modelAry;
}


- (void)deleteWeekly:(SWGWeekly *)weekly {
    SWGDelWeeklyRequest *request = [[SWGDelWeeklyRequest alloc] init];
    request.weeklyid = weekly.weeklyid;
    request.uid = UserModel.currentUser.uid;
    [_delWeeklyCommand execute:request];
}





- (void) registerCellViewModelClasses {
    [super registerCellViewModelClasses];
    
    [self registerCellViewModelClass:NoteCellViewModel.class forModelClass:SWGWeekly.class];
}
@end
