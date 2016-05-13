//
//  SettingViewModel.m
//  NoteBook
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "SettingViewModel.h"
#import "FeedViewModel+MultipleSections.h"
#import "EmptyCellViewModel.h"
#import "ButtonCellViewModel.h"



@implementation SettingViewModel
+ (instancetype) viewModel {
    return [[self alloc] initWithSectionCount:1];
}

- (instancetype) initWithSectionCount:(NSInteger) count {
    self = [super initWithSectionCount:count];
    if (self) {
        [self reload];
    }
    return self;
}

- (void) registerCellViewModelClasses {
    [super registerCellViewModelClasses];
    
    [self registerCellViewModelClass:CommonTextCellViewModel.class forModelClass:CommonTextCellModel.class];
    [self registerCellViewModelClass:ButtonCellViewModel.class forModelClass:ButtonCellModel.class];
}

- (void)reload {
    
    NSMutableArray *modelAry = [NSMutableArray array];
    [modelAry addObject:[EmptyCellModel modelWithCellHeight:8 backgroundColor:[UIColor whiteColor]]];
//    CommonTextCellModel *model0 = [[CommonTextCellModel alloc]init];
//    model0.title = @"修改密码";
//    model0.showIndicator = YES;
//    model0.destinationVC = @"ResetPasswordViewController";
//    [modelAry addObject:model0];
    
    CommonTextCellModel *model1 = [[CommonTextCellModel alloc]init];
    model1.title = @"  反馈";
    model1.showIndicator = YES;
    model1.destinationVC = @"FeedbackViewController";
    [modelAry addObject:model1];
    
    CommonTextCellModel *model2 = [[CommonTextCellModel alloc]init];
    model2.title = @"  关于";
    model2.showIndicator = YES;
    model2.destinationVC = @"AboutViewController";
    [modelAry addObject:model2];
    
    [modelAry addObject:[EmptyCellModel modelWithCellHeight:8 backgroundColor:[UIColor whiteColor]]];
    
    ButtonCellModel *buttonCellModel = [[ButtonCellModel alloc]init];
    buttonCellModel.title = @"退出登录";
    [modelAry addObject:buttonCellModel];
    
    [self setModels:modelAry inSection:0];
}

@end
