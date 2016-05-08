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

@end

@implementation PersonalInformationViewModel

+ (instancetype) viewModel {
    return [[self alloc] initWithSectionCount:1];
}

- (instancetype) initWithSectionCount:(NSInteger) count {
    self = [super initWithSectionCount:count];
    if (self) {
        if (UserModel.currentUser.profile == nil) {
            _baseInfo = [[SWGUser alloc]init];
        }else{
            _baseInfo = [[SWGUser alloc]initWithDictionary:[UserModel.currentUser.profile toDictionary] error:nil];
        }
        
        @weakify(self)
        //        _updateBaseCommand = [VisionResumeService.service updateBaseCommandEnable:nil];
        //        [_updateBaseCommand.responses subscribeNext:^(SWGUpdateBaseResponse *response) {
        //            @strongify(self)
        //            [self.showHUDSignal sendNext:@"保存成功"];
        //            [[ResumeManagerViewModel sharedViewModel] refreshResume];
        //        }];
        //        [_updateBaseCommand.errors subscribeNext:^(NSError *error) {
        //            DDLogError(@"Error while update base:%@", error);
        //        }];
        
//        self.hudExecutingSignals = @[_updateBaseCommand.executing];
    }
    return self;
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
    if (_baseInfo.username != nil && [_baseInfo.username isKindOfClass:[NSString class]]) {
        model0.subTitle = _baseInfo.username;
    }else{
        model0.subTitle = @"必填";
    }
    [modelAry addObject:model0];
    
    CommonTextCellModel *model1 = [[CommonTextCellModel alloc]initWithDictType:@"com" pcode:@"sex"];
    model1.title = @"性别";
    if (_baseInfo.sex != nil && [_baseInfo.sex isKindOfClass:[NSString class]]) {
        model1.subTitle = _baseInfo.sex;
    }else{
        model1.subTitle = @"必填";
    }
    [modelAry addObject:model1];
    
    //    CommonTextCellModel *model2 = [[CommonTextCellModel alloc]init];
    //    model2.title = @"身份证号";
    //    model2.showIndicator = YES;
    //    model2.editType = CommonTextCellEditTypeInputField;
    //    if (_baseInfo.idcard != nil && [_baseInfo.idcard isKindOfClass:[NSString class]]) {
    //        model2.subTitle = _baseInfo.idcard;
    //    }else{
    //        model2.subTitle = @"必填";
    //    }
    //    [modelAry addObject:model2];
    
    //    CommonTextCellModel *model3 = [[CommonTextCellModel alloc]init];
    //    model3.title = @"出生日期";
    //    model3.showIndicator = YES;
    //    model3.editType = CommonTextCellEditTypeDatePickerView;
    //    if (_baseInfo.birthday != nil && [_baseInfo.birthday isKindOfClass:[NSString class]]) {
    //        model3.subTitle = _baseInfo.birthday;
    //    }else{
    //        model3.subTitle = @"未填写";
    //    }
    //    [modelAry addObject:model3];
    
    CommonTextCellModel *model4 = [[CommonTextCellModel alloc]init];
    model4.title = @"邮箱";
    model4.showIndicator = YES;
    model4.editType = CommonTextCellEditTypeInputField;
    if (_baseInfo.email != nil && [_baseInfo.email isKindOfClass:[NSString class]]) {
        model4.subTitle = _baseInfo.email;
    }else{
        model4.subTitle = @"必填";
    }
    [modelAry addObject:model4];
    
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
    
    //    CommonTextCellModel *model6 = [[CommonTextCellModel alloc]initWithDictType:@"com" pcode:@"marriage"];
    //    model6.title = @"婚姻状况";
    //    if (_baseInfo.isMarry != nil && [_baseInfo.isMarryCn isKindOfClass:[NSString class]]) {
    //        model6.subTitle = _baseInfo.isMarryCn;
    //    }else{
    //        model6.subTitle = @"未填写";
    //    }
    //    [modelAry addObject:model6];
    
    //    CommonTextCellModel *model7 = [[CommonTextCellModel alloc]initWithDictType:@"city" pcode:@"-1"];
    //    model7.title = @"户口所在地";
    //    if (_baseInfo.homeCity != nil && [_baseInfo.homeCityCn isKindOfClass:[NSString class]]) {
    //        model7.subTitle = _baseInfo.homeCityCn;
    //    }else{
    //        model7.subTitle = @"未填写";
    //    }
    //    [modelAry addObject:model7];
    
    //    CommonTextCellModel *model8 = [[CommonTextCellModel alloc]initWithDictType:@"city" pcode:@"-1"];
    //    model8.title = @"居住地";
    //    if (_baseInfo.livingCity != nil && [_baseInfo.livingCityCn isKindOfClass:[NSString class]]) {
    //        model8.subTitle = _baseInfo.livingCityCn;
    //    }else{
    //        model8.subTitle = @"未填写";
    //    }
    //    [modelAry addObject:model8];
    
    
    //TODO  about
    //    CommonTextCellModel *model9 = [[CommonTextCellModel alloc]init];
    //    model9.title = @"详细地址";
    //    model9.showIndicator = YES;
    //    model9.editType = CommonTextCellEditTypeTextView;
    //    if (_baseInfo.address != nil && [_baseInfo.address isKindOfClass:[NSString class]]) {
    //        model9.detailText = _baseInfo.address;
    //    }else{
    //        model9.subTitle = @"必填";
    //    }
    //    [modelAry addObject:model9];
    //
        [self setModels:modelAry inSection:0];
}

- (void)modifyModel:(CommonTextCellModel*)model withValue:(id)value {
    if ([model.title isEqualToString:@"姓名"]) {
        _baseInfo.username = (NSString*)value;
    }else if ([model.title isEqualToString:@"性别"]) {
        //        SWGVisionDict *dict = (SWGVisionDict*)value;
        _baseInfo.sex = (NSString*)value;
        //        _baseInfo.sexCn = dict.name;
        //    }else if ([model.title isEqualToString:@"身份证号"]) {
        //        _baseInfo.idcard = (NSString*)value;
        //    }else if ([model.title isEqualToString:@"出生日期"]) {
        //        _baseInfo.birthday = (NSString*)value;
    }else if ([model.title isEqualToString:@"手机"]) {
        _baseInfo.phone = (NSString*)value;
    }else if ([model.title isEqualToString:@"邮箱"]) {
        _baseInfo.email = (NSString*)value;
    }
    //    }else if ([model.title isEqualToString:@"婚姻状况"]) {
    //        SWGVisionDict *dict = (SWGVisionDict*)value;
    //        _baseInfo.isMarry = [NSNumber numberWithInt:dict.value.intValue];
    //        _baseInfo.isMarryCn = dict.name;
    //    }else if ([model.title isEqualToString:@"户口所在地"]) {
    //        SWGVisionDict *dict = (SWGVisionDict*)value;
    //        _baseInfo.homeCity = [NSNumber numberWithInt:dict.value.intValue];
    //        _baseInfo.homeCityCn = dict.name;
    //    }else if ([model.title isEqualToString:@"居住地"]) {
    //        SWGVisionDict *dict = (SWGVisionDict*)value;
    //        _baseInfo.livingCity = [NSNumber numberWithInt:dict.value.intValue];
    //        _baseInfo.livingCityCn = dict.name;
    //    }else if ([model.title isEqualToString:@"详细地址"]) {
    //        _baseInfo.address = (NSString*)value;
    //    }
    [self reload];
}

- (void)save {
    //    SWGUpdateBaseRequest *request = [[SWGUpdateBaseRequest alloc]init];
    //    
    //    _baseInfo.created = nil;
    //    _baseInfo.modified = nil;
    //    
    //    request.base = _baseInfo;
    //    request.uid = UserModel.currentUser.uid;
    //    request.rid = UserModel.currentUser.rid;
    //    [_updateBaseCommand execute:request];
}


@end
