//
//  CommonEditViewController.m
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "CommonEditViewController.h"
#import "CommonTextCellViewModel.h"
//#import "DictViewController.h"
#import "TextViewViewController.h"
#import "InputFieldViewController.h"
#import "TextViewViewController.h"
//#import "DatePickerActionView.h"
//#import "ChangeImageViewController.h"
#define PICKER_HEIGHT 200

@implementation CommonEditViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navSaveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_navSaveBtn setBackgroundColor:[UIColor clearColor]];
    [_navSaveBtn setFrame:CGRectMake(self.navigationController.navigationBar.frame.size.width - 44, 0, 44, 44)];
    [_navSaveBtn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [_navSaveBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_navSaveBtn setTitle:@"保存" forState:UIControlStateNormal];
    @weakify(self)
    _navSaveBtn.rac_command = [RACCommand commandWithBlock:^(id input) {
        @strongify(self)
        [self save];
    }];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_navSaveBtn];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) tableView:(UITableView *)tableView didSelectCellWithViewModel:(CellViewModel *)cellViewModel {
    if ([cellViewModel isKindOfClass:CommonTextCellViewModel.class]) {
        CommonTextCellModel *commonTextCellModel = (CommonTextCellModel*)cellViewModel.model;
        
        if (commonTextCellModel.editType == CommonTextCellEditTypeDictSelect) {
            NSLog(@"CommonTextCellEditTypeDictSelect");
//            DictViewController *dictVC = [DictViewController viewControllerWithType:commonTextCellModel.dictType pcode:commonTextCellModel.dictPcode];
//            dictVC.title = [NSString stringWithFormat:@"选择%@",commonTextCellModel.title];
//            @weakify(self)
//            [[dictVC.selectedSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(SWGVisionDict *dict) {
//                @strongify(self)
//                [self modifyModel:commonTextCellModel withValue:dict];
//                [self.navigationController popToViewController:self animated:YES];
//            }];
//            [self.navigationController pushViewController:dictVC animated:YES];
        }
        
        else if (commonTextCellModel.editType == CommonTextCellEditTypeInputField) {
            InputFieldViewController *inputVC = [InputFieldViewController viewController];
            inputVC.text = commonTextCellModel.subTitle;
            inputVC.title = [NSString stringWithFormat:@"编辑%@",commonTextCellModel.title];
            @weakify(self)
            [[inputVC.completeSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *text) {
                @strongify(self)
                [self modifyModel:commonTextCellModel withValue:text];
                [self.navigationController popToViewController:self animated:YES];
            }];
            [self.navigationController pushViewController:inputVC animated:YES];
        }
        
        else if (commonTextCellModel.editType == CommonTextCellEditTypeTextView){
            TextViewViewController *inputVC = [TextViewViewController viewController];
            inputVC.text = commonTextCellModel.detailText;
            inputVC.title = [NSString stringWithFormat:@"编辑%@",commonTextCellModel.title];
            @weakify(self)
            [[inputVC.completeSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *text) {
                @strongify(self)
                [self modifyModel:commonTextCellModel withValue:text];
                [self.navigationController popToViewController:self animated:YES];
            }];
            [self.navigationController pushViewController:inputVC animated:YES];
        }
        
        else if (commonTextCellModel.editType == CommonTextCellEditTypeDatePickerView) {
//            DatePickerActionView *datePicker = [[DatePickerActionView alloc]initWithDateStr:commonTextCellModel.subTitle];
//            @weakify(self)
//            [[datePicker.dateChangedSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *dateStr) {
//                @strongify(self)
//                [self modifyModel:commonTextCellModel withValue:dateStr];
//            }];
//            [datePicker showAnimated:YES];
        }
        
        else if (commonTextCellModel.editType == CommonTextCellEditTypeImageUpload) {
            
//            ChangeImageViewController *inputVC = [ChangeImageViewController viewControllerWithImgType:commonTextCellModel.imageType imgUrl:commonTextCellModel.imageUrl];
//            inputVC.title = [NSString stringWithFormat:@"编辑%@",commonTextCellModel.title];
//            @weakify(self)
//            [[inputVC.completeSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString *text) {
//                @strongify(self)
//                [self modifyModel:commonTextCellModel withValue:text];
//                [self.navigationController popToViewController:self animated:YES];
//            }];
//            [self.navigationController pushViewController:inputVC animated:YES];
        }
    }
}

- (void)modifyModel:(CommonTextCellModel*)model withValue:(id)value {
    
}

- (void)save {
    
}
@end
