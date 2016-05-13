//
//  AboutViewModel.m
//  NoteBook
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "AboutViewModel.h"
#import "FeedViewModel+MultipleSections.h"
#import "FeedViewModel+Refresh.h"
//#import "AboutAppCellViewModel.h"

@interface AboutViewModel()

@property (nonatomic,strong) RACCommand *getAboutAppCommand;
//@property (nonatomic,strong) SWGAboutResponse *getAboutAppresponse;

@end
@implementation AboutViewModel
+ (instancetype) viewModel {
    return [[self alloc] initWithSectionCount:1];
}
- (instancetype) initWithSectionCount:(NSInteger) count {
    self = [super initWithSectionCount:count];
    if (self) {
        
//        @weakify(self)
//        _getAboutAppCommand = [VisionOtherService.service getAboutAPPCommandEnable:nil];
//        [_getAboutAppCommand.responses subscribeNext:^(SWGAboutResponse *response) {
//            @strongify(self)
//            [self updateFromGetMassageResponse:response];
//        }];
//        [_getAboutAppCommand.errors subscribeNext:^(NSError *error) {
//            DDLogError(@"Error while get about app info:%@", error);
//        }];
        
//        self.hudExecutingSignals = @[_getAboutAppCommand.executing];
    }
    return self;
}

- (void) loadAtHead {
    
//    SWGAboutRequest *request = [[SWGAboutRequest alloc]init];
//    [_getAboutAppCommand execute:request];
    
}

- (void) registerCellViewModelClasses {
    [super registerCellViewModelClasses];
    
//    [self registerCellViewModelClass:AboutAppCellViewModel.class forModelClass:SWGAboutResponseItem.class];
}

//- (void)updateFromGetMassageResponse:(SWGAboutResponse*)response {
//    
//    self.getAboutAppresponse = response;
//    [self resetModelSections:@[[self messageListModels]]];
//}

//- (NSMutableArray*)messageListModels {
//    NSMutableArray *modelAry = [NSMutableArray array];
//    
//    [modelAry addObject:_getAboutAppresponse.item];
//    
//    return modelAry;
//}
@end
