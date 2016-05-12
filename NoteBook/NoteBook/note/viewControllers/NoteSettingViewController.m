//
//  NoteSettingViewController.m
//  NoteBook
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NoteSettingViewController.h"
#import "UIView+HUD.h"
#import "FeedViewController+Refresh.h"
#import "CommonTextCell.h"
#import "UISwitch+RACSignalSupport.h"
#import "NoteSetGroupViewController.h"


@interface NoteSettingViewController ()

@property (nonatomic, strong) RACCommand *setIsBlogCommand;
@property (nonatomic, strong) RACCommand *delWeeklyCommand;
@property (nonatomic, strong) RACCommand *getWeeklyCommand;

@property (nonatomic, strong) SWGWeeklyListResponses *weeklyListResponses;

@end



@implementation NoteSettingViewController
@dynamic viewModel;

//- (instancetype)initWithViewModel:(NoteSettingViewModel *)viewModel Model:(SWGWeekly *)model
//{
//    self = [super initWithModel:[NoteSettingViewModel viewModelWithModel:model]];
//    if (self) {
//        _model = model;
//
//    }
//    return self;
//}


+ (instancetype) viewControllerWithModel:(SWGWeekly *)model {
    NoteSettingViewController *result = [[self alloc] initWithModel:[NoteSettingViewModel viewModelWithModel:model]];
    result.model = model;
    result.hidesBottomBarWhenPushed = YES;
    return result;
}
- (instancetype) initWithModel:(NoteSettingViewModel *)model {
    self = [super initWithModel:model];
    if (self) {
        @weakify(self)
        
        _getWeeklyCommand = [NoteBookWeeklyService.service weeklyByIdCommandEnable:nil];
        
        [_getWeeklyCommand.responses subscribeNext:^(SWGWeeklyByIdResponses *response) {
            @strongify(self)
            //        SWGWeekly *weekly = (SWGWeekly *)response.data[0];
            SWGWeekly *weekly = [self Models:response];
            if (weekly != nil) {
                self.model = weekly;
                [self.viewModel setModel:self.model];
                [self.viewModel loadAtHead];
                [self.viewModel reload];
            }
            
            //        [self.viewModel showHUDMessage:@"设置成功"];
        }];
        [_getWeeklyCommand.errors subscribeNext:^(NSError *error) {
            //        [self.viewModel showHUDMessage:@"设置失败"];
        }];
        
        
        
        _setIsBlogCommand = [NoteBookWeeklyService.service isBlogCommandEnable:nil];
        
        [_setIsBlogCommand.responses subscribeNext:^(SWGIsBlogResponses *response) {
            @strongify(self)
            [self.viewModel showHUDMessage:@"设置成功"];
            [self updateModel];
        }];
        [_setIsBlogCommand.errors subscribeNext:^(NSError *error) {
            [self.viewModel showHUDMessage:@"设置失败"];
        }];
        
        
        
        
        
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    self.title = @"设置";
    [self updateModel];
    [self addFreshingControls];
    [self.viewModel loadAtHead];
    [self.viewModel reload];
    
    @weakify(self)
    [[self.viewModel.showHUDSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *text) {
        @strongify(self)
        //        [[ResumeManagerViewModel sharedViewModel] refreshResume];
        [self updateModel];
        [self.viewModel loadAtHead];
        [self.viewModel reload];
        [self.view showHUDWithText:nil detailText:text autoDismiss:YES];
    }];
}
- (SWGWeekly*)Models:(SWGWeeklyByIdResponses *)response {
    NSDictionary *dict = response.toDictionary;
    id item_dict = dict[@"data"];
//    NSMutableArray *modeSectionlAry = [NSMutableArray array];
    if([item_dict isKindOfClass:[NSArray class]]) {
        if([(NSArray*)item_dict count] > 0) {
            for (NSDictionary* dict1 in (NSArray*)item_dict) {
//                NSMutableArray *modelAry = [NSMutableArray array];
                SWGWeekly* d = [[SWGWeekly alloc] initWithDictionary:dict1 error:nil];
                return d;
//                CommonSectionHeadCellModel *headCellModel = [[CommonSectionHeadCellModel alloc]init];
//                headCellModel.title = [NSString stringWithFormat:@"%@",d.company];
//                if ([d.infos count] == 0) {
//                    
//                }else{
//                    [modelAry addObject:headCellModel];
//                }
//                
//                [modelAry addObjectsFromArray:d.infos];
//                [modeSectionlAry insertObject:modelAry atIndex:0];
            }
        }
    }
    return nil;
}
- (void)modifyModel:(CommonTextCellModel*)model withValue:(id)value {
    [self.viewModel modifyModel:model withValue:value];
}

- (void)save {
    [self.viewModel save];
}
- (void)updateModel{
    SWGWeeklyByIdRequest *request = [[SWGWeeklyByIdRequest alloc] init];
    request.weeklyid = _model.weeklyid;
    request.uid = _model.uid;
    [_getWeeklyCommand execute:request];
}

- (void) tableView:(UITableView *)tableView didSelectCellWithViewModel:(CellViewModel *)cellViewModel {
    if ([cellViewModel isKindOfClass:CommonTextCellViewModel.class]) {
        
        CommonTextCellModel * model = (CommonTextCellModel*)cellViewModel.model;
        if ([model.title isEqualToString:@"笔记本"]) {
            NoteSetGroupViewController *previewController = [NoteSetGroupViewController viewControllerWithModel:_model];
            @weakify(self)
            [[previewController.selectedSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(SWGNoteGroup *dict) {
                @strongify(self)
                [self updateModel];
//                self.viewModel.model = self.model;
//                [self.viewModel setModel:self.model];
//                [self.viewModel loadAtHead];
//                [self.viewModel reload];
                [self.navigationController popToViewController:self animated:YES];
            }];
            [self.navigationController pushViewController:previewController animated:YES];
        }
    }
}
- (NBTableViewCell*) tableView:(UITableView *)tableView cellForViewModel:(CellViewModel *)cellViewModel {
    NBTableViewCell *cell = [super tableView:tableView cellForViewModel:cellViewModel];
    
    @weakify(self)
    if ([cellViewModel isKindOfClass:CommonTextCellViewModel.class]) {
        CommonTextCell *sectionHeadCell = (CommonTextCell *)cell;
        
        if ([_model.isblog isEqualToString:@"1"]) {
            [sectionHeadCell.switchbtn setOn:YES];
        }else{
            [sectionHeadCell.switchbtn setOn:NO];
        }
        SWGIsBlogRequest *request = [[SWGIsBlogRequest alloc] init];
        [[sectionHeadCell.switchbtn rac_newOnChannel] subscribeNext:^(NSString *s) {
//            NSLog(@"UISwitch: %@", x);
//            NSString *str = (NSString *)s;
            NSString *str = [[NSString alloc] initWithFormat:@"%@",s];
            @strongify(self)
            if ([str isEqualToString:@"1"]) {
                request.isblog = @"1";
            }else{
                request.isblog = @"2";
            }
            request.uid = self.model.uid;
            request.weeklyid = self.model.weeklyid;
            [self.setIsBlogCommand execute:request];
        }];
//        sectionHeadCell.switchbtn.rac_command = [RACCommand commandWithBlock:^(id input) {
//            @strongify(self)
////            ReviewCompanyViewController *vc = [ReviewCompanyViewController viewControllerWithCompany:sectionHeadCell.viewModel.model];
////            [[vc.viewModel.reviewCompanyCommand.responses takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id x) {
////                @strongify(self)
////                [self.viewModel.showHUDSignal sendNext:@"评价成功"];
////                [self.viewModel loadAtHead];
////                
////                [self.navigationController popToViewController:self animated:YES];
//            }];
////            [self.navigationController pushViewController:vc animated:YES];
//        }];
    }
    
    return  cell;
}



@end
