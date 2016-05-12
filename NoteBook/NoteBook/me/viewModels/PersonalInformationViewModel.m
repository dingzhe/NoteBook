//
//  PersonalInformationViewModel.m
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "PersonalInformationViewModel.h"
#import "FeedViewModel+MultipleSections.h"
#import "FeedViewController+Refresh.h"
#import "PersonalViewModel.h"


@interface PersonalInformationViewModel ()

@property (nonatomic,strong) SWGUser *baseInfo;
@property (nonatomic,strong) RACCommand *updateBaseCommand;
@property (nonatomic,strong) RACCommand *userInfoCommand;
@end

@implementation PersonalInformationViewModel

+ (instancetype) viewModel {
    return [[self alloc] initWithSectionCount:1];
}

- (instancetype) initWithSectionCount:(NSInteger) count {
    self = [super initWithSectionCount:count];
    if (self) {
//        if (UserModel.currentUser.profile == nil) {
//            _baseInfo = [[SWGUser alloc]init];
//        }else{
//            _baseInfo = [[SWGUser alloc]initWithDictionary:[UserModel.currentUser.profile toDictionary] error:nil];
////            _baseInfo = UserModel.currentUser.profile;
//        }
        
        
        _baseInfo = [[SWGUser alloc]init];
        
        @weakify(self)
        _userInfoCommand = [NoteBookWeeklyService.service userInfoCommandEnable:nil];
        [_userInfoCommand.responses subscribeNext:^(SWGUserInfoResponses *response) {
            @strongify(self)
//            [self.showHUDSignal sendNext:@"保存成功"];
            SWGUser *user = [self Models:response];
            
            if (user != nil) {
                _baseInfo = user;
                [self reload];
                [UserModel.currentUser updateProfile:user];
            }
        }];
        [_userInfoCommand.errors subscribeNext:^(NSError *error) {
//            [self.showHUDSignal sendNext:@"保存失败"];
            //            DDLogError(@"Error while update base:%@", error);
        }];
        _updateBaseCommand = [NoteBookWeeklyService.service updateUserInfoCommandEnable:nil];
        [_updateBaseCommand.responses subscribeNext:^(SWGUserInfoResponses *response) {
            @strongify(self)
            if (response.code.integerValue == 200) {
                [self.showHUDSignal sendNext:@"保存成功"];
                SWGUser *user = [self Models:response];
                if (user != nil) {
                    [self reload];
                    [UserModel.currentUser updateProfile:user];
                }
            }else{
                [self.showHUDSignal sendNext:response.message];
            }

        }];
        [_updateBaseCommand.errors subscribeNext:^(NSError *error) {
            [self.showHUDSignal sendNext:@"保存失败"];
//            DDLogError(@"Error while update base:%@", error);
        }];
        
        self.hudExecutingSignals = @[_updateBaseCommand.executing];
    }
    return self;
}
- (void)loadAtHead{
    SWGUserInfoRequest *request = [[SWGUserInfoRequest alloc] init];
    request.uid = UserModel.currentUser.uid;
    [_userInfoCommand execute:request];

}

- (SWGUser*)Models:(SWGUserInfoResponses *)response {
    NSDictionary *dict = response.toDictionary;
    id item_dict = dict[@"data"];
    if([item_dict isKindOfClass:[NSArray class]]) {
        if([(NSArray*)item_dict count] > 0) {
            for (NSDictionary* dict1 in (NSArray*)item_dict) {
                SWGUser* d = [[SWGUser alloc] initWithDictionary:dict1 error:nil];
                return d;
            }
        }
    }
    return nil;
}
- (void) registerCellViewModelClasses {
    [super registerCellViewModelClasses];
    
    [self registerCellViewModelClass:CommonTextCellViewModel.class forModelClass:CommonTextCellModel.class];
}

- (void)reload {
    
    NSMutableArray *modelAry = [NSMutableArray array];
    
    CommonTextCellModel *model0 = [[CommonTextCellModel alloc]init];
    model0.title = @"姓名";
    model0.showIndicator = YES;
    model0.editType = CommonTextCellEditTypeInputField;
    if (_baseInfo.username != nil) {
        model0.subTitle = _baseInfo.username;
    }else{
        model0.subTitle = @"必填";
    }
    [modelAry addObject:model0];
    
    CommonTextCellModel *model1 = [[CommonTextCellModel alloc]init];
    model1.title = @"性别";
    model0.showIndicator = YES;
    model0.editType = CommonTextCellEditTypeInputField;
    if (_baseInfo.sex != nil) {
        model1.subTitle = _baseInfo.sex;
    }else{
        model1.subTitle = @"必填";
    }
    [modelAry addObject:model1];
    
    CommonTextCellModel *model4 = [[CommonTextCellModel alloc]init];
    model4.title = @"邮箱";
    model4.showIndicator = YES;
    model4.editType = CommonTextCellEditTypeInputField;
    if (_baseInfo.email != nil) {
        model4.subTitle = _baseInfo.email;
    }else{
        model4.subTitle = @"必填";
    }
//    [modelAry addObject:model4];
    
    CommonTextCellModel *model5 = [[CommonTextCellModel alloc]init];
    model5.title = @"手机";
    model5.showIndicator = YES;
    model5.editType = CommonTextCellEditTypeInputField;
    if (_baseInfo.phone != nil && [_baseInfo.phone isKindOfClass:[NSString class]]) {
        model5.subTitle = _baseInfo.phone;
    }else{
        model5.subTitle = @"必填";
    }
    [modelAry addObject:model5];
    
    //TODO  about
    CommonTextCellModel *model9 = [[CommonTextCellModel alloc]init];
    model9.title = @"个人简介";
    model9.showIndicator = YES;
    model9.editType = CommonTextCellEditTypeTextView;
    if (_baseInfo.about != nil) {
        model9.detailText = _baseInfo.about;
    }else{
        model9.subTitle = @"必填";
    }
    [modelAry addObject:model9];
    [self setModels:modelAry inSection:0];
}

- (void)modifyModel:(CommonTextCellModel*)model withValue:(id)value {
    if ([model.title isEqualToString:@"姓名"]) {
        _baseInfo.username = (NSString*)value;
    }else if ([model.title isEqualToString:@"性别"]) {
        _baseInfo.sex = (NSString*)value;
    }else if ([model.title isEqualToString:@"手机"]) {
        _baseInfo.phone = (NSString*)value;
    }
    //    }else if ([model.title isEqualToString:@"邮箱"]) {
//        _baseInfo.email = (NSString*)value;
//    }
    else if ([model.title isEqualToString:@"个人简介"]) {
        _baseInfo.about = (NSString*)value;
    }
    [self reload];
}

- (void)save {
    SWGUserInfo *request = [[SWGUserInfo alloc]init];
    request.userid = UserModel.currentUser.uid;
    request.username = _baseInfo.username;
    request.sex = _baseInfo.sex;
    request.phone = _baseInfo.phone;
//    request.email = _baseInfo.email;
    request.about = _baseInfo.about;
    [_updateBaseCommand execute:request];
}


@end
