//
//  PersonalViewModel.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "PersonalViewModel.h"
#import "FeedViewModel+MultipleSections.h"
#import "FeedViewController+Refresh.h"
#import "EmptyCellViewModel.h"
#import "PermissionManager+DzNote.h"
#import "CommonTextCellViewModel.h"
#import "PersonalManagerHeadCellViewModel.h"
//#import "ViewController.h"
static PersonalViewModel *sharedInstance = nil;

@interface PersonalViewModel ()

@property (nonatomic,strong) RACCommand *uploadAvatarCommand;
@property (nonatomic,strong) RACCommand *updateAvatarCommand;

@end


@implementation PersonalViewModel
IMP_SINGLETON(sharedViewModel, PersonalViewModel)

- (instancetype) init {
    self = [super initWithSectionCount:1];
    if (self) {
        [self reload];
        @weakify(self)
        _refreshedSignal = [RACSubject subject];
        
        _queryResumeCommand = [NoteBookWeeklyService.service uploadFileCommandEnable:nil];
//        [_queryResumeCommand.responses subscribeNext:^(SWGQueryResumeResponse *response) {
//            @strongify(self)
//            [UserModel.currentUser updateProfile:response.item];
//            [_refreshedSignal sendNext:nil];
//            [self reload];
//            [self refreshResume];
//        }];
//        [_queryResumeCommand.errors subscribeNext:^(NSError *error) {
//            DDLogError(@"Error while query resume:%@", error);
//        }];
//        
        _uploadAvatarCommand = [NoteBookWeeklyService.service uploadFileCommandEnable:nil];
        [_uploadAvatarCommand.responses subscribeNext:^(SWGUploadFileResponse *response) {
            @strongify(self)
            [UserModel.currentUser updateHeadImage:response.url];
            [self reload];
            
//            SWGUpdateBaseIconRequest *request = [[SWGUpdateBaseIconRequest alloc]init];
//            request.uid = UserModel.currentUser.uid;
//            SWGUpdateBaseIconRequestData *icon = [[SWGUpdateBaseIconRequestData alloc]init];
//            icon.rid = UserModel.currentUser.rid;
//            icon.icon = response.url;
//            request.icon = icon;
//            [self.updateAvatarCommand execute:request];
//            [self refreshResume];
        }];
        [_uploadAvatarCommand.errors subscribeNext:^(NSError *error) {
//            DDLogError(@"Error while upload avatar:%@", error);
        }];
//
//        _updateAvatarCommand = [NoteBookSignService.service signInCommandEnable:nil];
//        [_updateAvatarCommand.responses subscribeNext:^(SWGUploadFileResponse *response) {
//            @strongify(self)
//            [self refreshResume];
//        }];
//        [_updateAvatarCommand.errors subscribeNext:^(NSError *error) {
//            DDLogError(@"Error while update avatar:%@", error);
//        }];
        
//        self.hudExecutingSignals = @[_queryResumeCommand.executing];
    }
    return self;
}

- (void) registerCellViewModelClasses {
    [super registerCellViewModelClasses];
    
    [self registerCellViewModelClass:CommonTextCellViewModel.class forModelClass:CommonTextCellModel.class];
//    [self registerCellViewModelClass:ResumeManagerInfoCellViewModel.class forModelClass:ResumeManagerInfoCellModel.class];
    [self registerCellViewModelClass:PersonalManagerHeadCellViewModel.class forModelClass:PersonalManagerHeadCellModel.class];
    
}

- (void)refreshResume {
    
    if (UserModel.currentUser.status == UserModelSignedOn) {
//        SWGQueryResumeRequest *request = [[SWGQueryResumeRequest alloc]init];
//        request.uid = UserModel.currentUser.uid;
//        request._id = UserModel.currentUser.rid;
//        [_queryResumeCommand execute:@[request]];
    }
}

- (void)reload {
    
    NSMutableArray *modelAry = [NSMutableArray array];
    
    PersonalManagerHeadCellModel *headModel = [[PersonalManagerHeadCellModel alloc]init];
    headModel.headImgUrl = UserModel.currentUser.headimage;
    [modelAry addObject:headModel];
    
    [modelAry addObject:[EmptyCellModel seperatorModel]];
    
//    ResumeManagerInfoCellModel *infoModel = [[ResumeManagerInfoCellModel alloc]init];
//    infoModel.complete = UserModel.currentUser.profile.resume.complete.integerValue;
//    infoModel.modifyTimeStr = UserModel.currentUser.profile.resume.modified;
//    [modelAry addObject:infoModel];
    
//    [modelAry addObject:[EmptyCellModel seperatorModel]];
//    
    CommonTextCellModel *model0 = [[CommonTextCellModel alloc]init];
    model0.title = @"个人信息";
    model0.showIndicator = YES;
    model0.destinationVC = @"PersonalInformationViewController";
    [modelAry addObject:model0];

    [modelAry addObject:[EmptyCellModel seperatorModel]];
    CommonTextCellModel *model1 = [[CommonTextCellModel alloc]init];
    model1.title = @"夜间模式";
    model1.showIndicator = YES;
    model1.destinationVC = @"PersonalInformationViewController";
//    [modelAry addObject:model1];

    
    CommonTextCellModel *model2 = [[CommonTextCellModel alloc]init];
    model2.title = @"设置";
    model2.showIndicator = YES;
    model2.destinationVC = @"SettingViewController";
    [modelAry addObject:model2];
//    [modelAry addObject:[EmptyCellModel seperatorModel]];
//
//    CommonTextCellModel *model3 = [[CommonTextCellModel alloc]init];
//    model3.title = @"教育经历";
//    model3.showIndicator = YES;
//    model3.destinationVC = @"EduExpViewController";
//    [modelAry addObject:model3];
//    
//    CommonTextCellModel *model4 = [[CommonTextCellModel alloc]init];
//    model4.title = @"培训经历";
//    model4.showIndicator = YES;
//    model4.destinationVC = @"TranExpViewController";
//    [modelAry addObject:model4];
//    
//    CommonTextCellModel *model5 = [[CommonTextCellModel alloc]init];
//    model5.title = @"职业技能";
//    model5.showIndicator = YES;
//    model5.destinationVC = @"SkillViewController";
//    [modelAry addObject:model5];
//    
//    CommonTextCellModel *model6 = [[CommonTextCellModel alloc]init];
//    model6.title = @"毕业证书";
//    model6.showIndicator = YES;
//    model6.destinationVC = @"EduCertViewController";
//    [modelAry addObject:model6];
//    
//    CommonTextCellModel *model7 = [[CommonTextCellModel alloc]init];
//    model7.title = @"资质证书";
//    model7.showIndicator = YES;
//    model7.destinationVC = @"CertViewController";
//    [modelAry addObject:model7];
//    
//    CommonTextCellModel *model9 = [[CommonTextCellModel alloc]init];
//    model9.title = @"语言能力";
//    model9.showIndicator = YES;
//    model9.destinationVC = @"LangViewController";
//    [modelAry addObject:model9];
//    
//    CommonTextCellModel *model10 = [[CommonTextCellModel alloc]init];
//    model10.title = @"自我评价";
//    model10.showIndicator = YES;
//    model10.destinationVC = @"EvalEditViewController";
//    [modelAry addObject:model10];
//    
    [self setModels:modelAry inSection:0];
}

- (void)updateAvatar:(UIImage *)avatarImage {
    SWGFile *imageFile = [[SWGFile alloc] initWithNameData:@"avatar.jpg"
                                                  mimeType:@"image/jpeg"
                                                      data:[avatarImage compressedJPEGData]];
    [_uploadAvatarCommand execute:@[UserModel.currentUser.uid,@"icon",imageFile]];
}

@end
