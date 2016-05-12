//
//  PersonalInformationViewController.m
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "PersonalInformationViewController.h"
#import "UIView+HUD.h"
#import "FeedViewController+Refresh.h"


@implementation PersonalInformationViewController
@dynamic viewModel;

+ (instancetype) viewController {
    PersonalInformationViewController *result = [[self alloc] initWithModel:[PersonalInformationViewModel viewModel]];
    result.hidesBottomBarWhenPushed = YES;
    return result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"个人信息";
    [self.viewModel loadAtHead];
    [self addFreshingControls];
    [self.viewModel reload];
    @weakify(self)
    [[self.viewModel.showHUDSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *text) {
        @strongify(self)
        //        [[ResumeManagerViewModel sharedViewModel] refreshResume];
        [self.view showHUDWithText:nil detailText:text autoDismiss:YES];
        
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)modifyModel:(CommonTextCellModel*)model withValue:(id)value {
    [self.viewModel modifyModel:model withValue:value];
}

- (void)save {
    [self.viewModel save];
}
@end
