//
//  NoteSettingViewModel.m
//  NoteBook
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NoteSettingViewModel.h"
#import "FeedViewModel+MultipleSections.h"
#import "FeedViewController+Refresh.h"

@interface NoteSettingViewModel ()

@property (nonatomic,strong) RACCommand *getGroupNameCommand;
@property (nonatomic,strong) RACCommand *delWeeklyCommand;
@property (nonatomic,strong) SWGNoteGroupListResponses *noteGroupListResponses;
@property (nonatomic,strong) SWGNoteGroup *noteGroupModel;
@end



@implementation NoteSettingViewModel

+ (instancetype) viewModelWithModel:(SWGWeekly *)model {
    
    return [[self alloc] initWithSectionCount:1 Model:model];
}

- (instancetype) initWithSectionCount:(NSInteger) count Model:(SWGWeekly *)model{
    self = [super initWithSectionCount:count];
    if (self) {
        _model = model;
//        if (UserModel.currentUser.profile.resume == nil) {
//            _wishInfo = [[SWGWish alloc]init];
//        }else{
//            _wishInfo = [[SWGWish alloc] initWithDictionary:[UserModel.currentUser.profile.resume toDictionary] error:nil];
//        }
        
        @weakify(self)
        _getGroupNameCommand = [NoteBookWeeklyService.service noteGroupNameByIdCommandEnable:nil];
        [_getGroupNameCommand.responses subscribeNext:^(SWGNoteGroupNameByIdResponses *response) {
            @strongify(self)
            SWGNoteGroup *groupModel = [self Models:response];
            if (groupModel != nil) {
                _noteGroupModel = groupModel;
                [self reload];
            }
//            [self.showHUDSignal sendNext:@"保存成功"];
        }];
        [_getGroupNameCommand.errors subscribeNext:^(NSError *error) {
//            DDLogError(@"Error while update wish:%@", error);
        }];
//
        self.hudExecutingSignals = @[_getGroupNameCommand.executing];
    }
    return self;
}
- (SWGNoteGroup*)Models:(SWGNoteGroupNameByIdResponses *)response {
    NSDictionary *dict = response.toDictionary;
    id item_dict = dict[@"data"];
    if([item_dict isKindOfClass:[NSArray class]]) {
        if([(NSArray*)item_dict count] > 0) {
            for (NSDictionary* dict1 in (NSArray*)item_dict) {
                SWGNoteGroup* d = [[SWGNoteGroup alloc] initWithDictionary:dict1 error:nil];
                return d;
            }
        }
    }
    return nil;
}
- (void)setModel:(SWGWeekly *)model
{
    _model = model;
}
- (void) loadAtHead {
    SWGNoteGroupNameByIdRequest *request = [[SWGNoteGroupNameByIdRequest alloc] init];
    request.uid = UserModel.currentUser.uid;
    request.groupid = _model.groupid;
    [_getGroupNameCommand execute:request];
}
- (void) registerCellViewModelClasses {
    [super registerCellViewModelClasses];
    
    [self registerCellViewModelClass:CommonTextCellViewModel.class forModelClass:CommonTextCellModel.class];
}

- (void)reload {
    
    NSMutableArray *modelAry = [NSMutableArray array];
    
    CommonTextCellModel *model0 = [[CommonTextCellModel alloc]init];
    model0.title = @"笔记本";
    model0.showIndicator = YES;
    model0.editType = CommonTextCellEditTypeInputField;
    if (_noteGroupModel.groupname != nil) {
    
        model0.subTitle = _noteGroupModel.groupname;
    }else{
        model0.subTitle = @"未填写";
    }
    [modelAry addObject:model0];
    
    CommonTextCellModel *model1 = [[CommonTextCellModel alloc]initShowSwitch];
    model1.title = @"公开为博客";
    
//    model0.showIndicator = YES;
//    model0.editType = CommonTextCellEditTypeInputField;
//    if (_wishInfo.iid != nil && [_wishInfo.iidCn isKindOfClass:[NSString class]]) {
//        model1.subTitle = @"是";
//    }else{
//        model1.subTitle = @"未填写";
//    }
    [modelAry addObject:model1];
    
    [self setModels:modelAry inSection:0];
}

- (void)modifyModel:(CommonTextCellModel*)model withValue:(id)value {
    
    if ([model.title isEqualToString:@"笔记本"]) {
//        SWGVisionDict *dict = (SWGVisionDict*)value;
//        _wishInfo.areaid = [NSNumber numberWithInt:dict.value.intValue];
//        _wishInfo.areaidCn = dict.name;
    }else if ([model.title isEqualToString:@"公开为博客"]) {
//        SWGVisionDict *dict = (SWGVisionDict*)value;
//        _wishInfo.iid = [NSNumber numberWithInt:dict.value.intValue];
//        _wishInfo.iidCn = dict.name;
    }
    [self reload];
}

- (void)save {
    
//    SWGUpdateWishRequest *request = [[SWGUpdateWishRequest alloc]init];
//    
//    _wishInfo.created = nil;
//    _wishInfo.modified = nil;
//    
//    request.wish = _wishInfo;
//    request.uid = UserModel.currentUser.uid;
//    
//    [_updateWishCommand execute:request];
}

@end
