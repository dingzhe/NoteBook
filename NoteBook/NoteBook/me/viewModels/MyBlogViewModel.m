//
//  MyBlogViewModel.m
//  NoteBook
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "MyBlogViewModel.h"
#import "FeedViewModel+MultipleSections.h"
#import "FeedViewController+Refresh.h"
#import "NoteCellViewModel.h"

@interface MyBlogViewModel ()

@property (nonatomic,strong) RACCommand *getBlogListCommand;
@property (nonatomic,strong) SWGMyBlogListResponses *myBlogListResponses;

@end

@implementation MyBlogViewModel


+ (instancetype) viewModel {
    return [[self alloc] initWithSectionCount:1];
}
- (instancetype) initWithSectionCount:(NSInteger) count {
    self = [super initWithSectionCount:count];
    if (self) {
        @weakify(self) //@strongify(self)
        
        _getBlogListCommand = [NoteBookWeeklyService.service myBlogListCommandEnable:nil];
        [_getBlogListCommand.responses subscribeNext:^(SWGMyBlogListResponses *response) {
            @strongify(self)
            [self updateFromGetBlogListResponse:response];
        }];
        [_getBlogListCommand.errors subscribeNext:^(NSError *error) {
            //            DDLogError(@"Error while get resume browse history:%@", error);
        }];
        self.headerExecuting = _getBlogListCommand.executing;
        self.hudExecutingSignals = @[_getBlogListCommand.executing];
        
        self.placeHolderText = @"暂无博客";
        [[RACSignal combineLatest:@[RACObserve(self, myBlogListResponses)]] subscribeNext:^(id _) {
            @strongify(self)
            NSInteger requestCount = ((self.myBlogListResponses.data!=nil)?[self.myBlogListResponses.data count]:0);
            self.showPlaceHolderView = (requestCount == 0);
        }];
        
    }
    return self;
}

- (void) loadAtHead {
    SWGMyBlogListRequest *request = [[SWGMyBlogListRequest alloc] init];
    request.uid = UserModel.currentUser.uid;
    [_getBlogListCommand execute:request];
}

- (void)updateFromGetBlogListResponse:(SWGMyBlogListResponses*)response {
    self.myBlogListResponses = response;
    [self resetModelSections:@[[self MyBlogListModels]]];
}

- (NSMutableArray*)MyBlogListModels {
    NSMutableArray *modelAry = [NSMutableArray array];
    
    [modelAry addObjectsFromArray:_myBlogListResponses.data];
    
    return modelAry;
}

- (void) registerCellViewModelClasses {
    [super registerCellViewModelClasses];
    
    [self registerCellViewModelClass:NoteCellViewModel.class forModelClass:SWGWeekly.class];
}

@end
