//
//  NoteSetGroupViewController.m
//  NoteBook
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NoteSetGroupViewController.h"
#import "FeedViewController+Refresh.h"
#import "Masonry.h"
#import "UIView+HUD.h"
#import "FeedViewModel+MultipleSections.h"
#import "NoteGroupCellViewModel.h"

@interface NoteSetGroupViewController ()

@property (nonatomic, strong) RACCommand *setNoteGroupCommand;
@property (nonatomic, strong) RACCommand *delWeeklyCommand;
@property (nonatomic, strong) RACCommand *getWeeklyCommand;

@property (nonatomic, strong) SWGWeeklyListResponses *weeklyListResponses;

@end



@implementation NoteSetGroupViewController
@dynamic viewModel;

+ (instancetype) viewControllerWithModel:(SWGWeekly *)model {
    NoteSetGroupViewController *result = [[self alloc] initWithModel:[NoteSetGroupViewModel viewModel]];
    result.model = model;
    result.hidesBottomBarWhenPushed = YES;
    return result;
}
- (instancetype) initWithModel:(NoteSetGroupViewModel *)model {
    self = [super initWithModel:model];
    if (self) {
        _selectedSignal = [RACSubject subject];
        _setNoteGroupCommand = [NoteBookWeeklyService.service noteGroupCommandEnable:nil];
        @weakify(self)
        [_setNoteGroupCommand.responses subscribeNext:^(SWGNoteGroupResponses *response) {
            @strongify(self)
            //        SWGWeekly *weekly = (SWGWeekly *)response.data[0];
//            SWGWeekly *weekly = [self Models:response];
//            if (weekly != nil) {
//                _model = weekly;
//            }
//            
            //        [self.viewModel showHUDMessage:@"设置成功"];
        }];
        [_setNoteGroupCommand.errors subscribeNext:^(NSError *error) {
            //        [self.viewModel showHUDMessage:@"设置失败"];
        }];
        
        
        
        
        
        
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"笔记本";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onPreview:)];
    
    
    
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"test"
    //                                                                             style:UIBarButtonItemStylePlain
    //                                                                            target:self
    //                                                                            action:@selector(openTestView)];
    [self addFreshingControls];
    [self.viewModel loadAtHead];
}
- (void) tableView:(UITableView *)tableView didSelectCellWithViewModel:(CellViewModel *)cellViewModel {
    if ([cellViewModel isKindOfClass:NoteGroupCellViewModel.class]) {
        
        SWGNoteGroup * model = (SWGNoteGroup*)cellViewModel.model;
        SWGNoteGroupRequest *request = [SWGNoteGroupRequest new];
        request.weeklyid = _model.weeklyid;
        request.uid = _model.uid;
        request.groupid = model.groupid;
        [_setNoteGroupCommand execute:request];
//        @weakify(self)
//        [[self.selectedSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(SWGNoteGroup *obj) {
//            @strongify(self)
        [self.selectedSignal sendNext:model];
//        [self.navigationController popToViewController:self animated:YES];
//        }];
        
//        [self.navigationController pushViewController:self animated:YES];
//        [self.navigationController pushViewController:previewController
//                                             animated:YES];
        
        
        
    }
}

@end
