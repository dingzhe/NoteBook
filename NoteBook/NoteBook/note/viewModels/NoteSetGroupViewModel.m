//
//  NoteSetGroupViewModel.m
//  NoteBook
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NoteSetGroupViewModel.h"
#import "FeedViewModel+MultipleSections.h"
#import "FeedViewController+Refresh.h"
#import "NoteGroupCellViewModel.h"
@interface NoteSetGroupViewModel ()

@property (nonatomic,strong) RACCommand *getNoteGroupListCommand;
@property (nonatomic,strong) RACCommand *delWeeklyCommand;
@property (nonatomic,strong) SWGNoteGroupListResponses *noteGroupListResponses;

@end

@implementation NoteSetGroupViewModel
+ (instancetype) viewModel {
    return [[self alloc] initWithSectionCount:1];
}
- (instancetype) initWithSectionCount:(NSInteger) count {
    self = [super initWithSectionCount:count];
    if (self) {
        @weakify(self) //@strongify(self)
        
        _getNoteGroupListCommand = [NoteBookWeeklyService.service noteGroupListCommandEnable:nil];
        [_getNoteGroupListCommand.responses subscribeNext:^(SWGNoteGroupListResponses *response) {
            @strongify(self)
            [self updateFromGetNoteGroupListResponse:response];
        }];
        [_getNoteGroupListCommand.errors subscribeNext:^(NSError *error) {
            //            DDLogError(@"Error while get resume browse history:%@", error);
        }];
        _delWeeklyCommand = [NoteBookWeeklyService.service delWeeklyCommandEnable:nil];
        [_delWeeklyCommand.responses subscribeNext:^(SWGResponses *response) {
            @strongify(self)
            //            [[self tableView] reloadData];
            [self loadAtHead];
        }];
        self.headerExecuting = _getNoteGroupListCommand.executing;
        self.hudExecutingSignals = @[_getNoteGroupListCommand.executing];
        
        self.placeHolderText = @"暂无笔记本";
        [[RACSignal combineLatest:@[RACObserve(self, noteGroupListResponses)]] subscribeNext:^(id _) {
            @strongify(self)
            NSInteger requestCount = ((self.noteGroupListResponses.data!=nil)?[self.noteGroupListResponses.data count]:0);
            self.showPlaceHolderView = (requestCount == 0);
        }];
        
    }
    return self;
}

- (void) loadAtHead {
    SWGNoteGroupListRequest *request = [[SWGNoteGroupListRequest alloc] init];
    request.uid = UserModel.currentUser.uid;
    [_getNoteGroupListCommand execute:request];
}

- (void)updateFromGetNoteGroupListResponse:(SWGNoteGroupListResponses*)response {
    self.noteGroupListResponses = response;
    [self resetModelSections:@[[self NoteGroupListModels]]];
}

- (NSMutableArray*)NoteGroupListModels {
    NSMutableArray *modelAry = [NSMutableArray array];
    
    [modelAry addObjectsFromArray:_noteGroupListResponses.data];
    
    return modelAry;
}


- (void)deleteWeekly:(NSString *)weeklyid {
    SWGDelWeeklyRequest *request = [[SWGDelWeeklyRequest alloc] init];
    request.weeklyid = weeklyid;
    request.uid = UserModel.currentUser.uid;
    [_delWeeklyCommand execute:request];
}





- (void) registerCellViewModelClasses {
    [super registerCellViewModelClasses];
    
    [self registerCellViewModelClass:NoteGroupCellViewModel.class forModelClass:SWGNoteGroup.class];
}
@end