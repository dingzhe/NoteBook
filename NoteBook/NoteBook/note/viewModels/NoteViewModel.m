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
@property (weak, nonatomic)  DataManager *db;


@end

@implementation NoteViewModel
+ (instancetype) viewModel {
    return [[self alloc] initWithSectionCount:1];
}
- (instancetype) initWithSectionCount:(NSInteger) count {
    self = [super initWithSectionCount:count];
    if (self) {
        @weakify(self) //@strongify(self)
        
        
        _db = [DataManager shareDataBase];
        
        _getweeklyListCommand = [NoteBookWeeklyService.service myWeeklyCommandEnable:nil];
        [_getweeklyListCommand.responses subscribeNext:^(SWGWeeklyListResponses *response) {
            @strongify(self)
            [self updateFromGetWeeklyListResponse:response];
            [self savaToDB:response];
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
        
        self.placeHolderText = @"暂无笔记";
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
- (void )savaToDB:(SWGWeeklyListResponses *)response {
    NSDictionary *dict = response.toDictionary;
    id item_dict = dict[@"data"];
    if([item_dict isKindOfClass:[NSArray class]]) {
        if([(NSArray*)item_dict count] > 0) {
            for (NSDictionary* dict1 in (NSArray*)item_dict) {
                SWGWeekly* w = [[SWGWeekly alloc] initWithDictionary:dict1 error:nil];
                if ([_db returnWeeklyById:w.weeklyid] != nil) {
                    [_db updateItemWithWeekly:w];
                }else{
                    [_db insertIntoDBWithItem:w];
                }
            }
        }
    }
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
