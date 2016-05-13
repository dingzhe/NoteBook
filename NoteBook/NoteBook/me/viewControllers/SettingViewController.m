//
//  SettingViewController.m
//  NoteBook
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "SettingViewController.h"
#import "AboutViewController.h"
#import "FeedbackViewController.h"

@implementation SettingViewController
@dynamic viewModel;

+ (instancetype) viewController {
    SettingViewController *result = [[self alloc] initWithModel:[SettingViewModel viewModel]];
    result.hidesBottomBarWhenPushed = YES;
    return result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"设置";
}


- (void) tableView:(UITableView *)tableView didSelectCellWithViewModel:(CellViewModel *)cellViewModel {
    if ([cellViewModel isKindOfClass:CommonTextCellViewModel.class]) {
        CommonTextCellModel *commonTextCellModel = (CommonTextCellModel*)cellViewModel.model;
        if ([commonTextCellModel.destinationVC isEqualToString:@"FeedbackViewController"]) {
            FeedbackViewController * vc = [[FeedbackViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        }else if ([commonTextCellModel.destinationVC isEqualToString:@"AboutViewController"]) {
            AboutViewController * aboutVc = [[AboutViewController alloc] init];
            [self.navigationController pushViewController:aboutVc animated:YES];
        }
    }
    else if ([cellViewModel isKindOfClass:ButtonCellViewModel.class]) {
        UIActionSheet *action = [[UIActionSheet alloc] initWithTitle:@"确定退出该账号的登录？"
                                                            delegate:nil
                                                   cancelButtonTitle:@"取消"
                                              destructiveButtonTitle:@"退出"
                                                   otherButtonTitles:nil];
        
        [[action.rac_buttonClickedSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSNumber *index) {
            if (0 == index.integerValue) {
                [UserModel.currentUser signout];
                
            }
        }];
        
        [action showInView:[UIApplication sharedApplication].keyWindow];
    }
}





@end
