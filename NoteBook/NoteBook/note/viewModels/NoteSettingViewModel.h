//
//  NoteSettingViewModel.h
//  NoteBook
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "FeedViewModel.h"
#import "CommonTextCellViewModel.h"

@interface NoteSettingViewModel : FeedViewModel
@property (nonatomic,strong) SWGWeekly *model;
+ (instancetype) viewModel;
+ (instancetype) viewModelWithModel:(SWGWeekly *)model;
- (void)reload;
- (void)modifyModel:(CommonTextCellModel*)model withValue:(id)value;
- (void)save;
- (void)setModel:(SWGWeekly *)model;
@end
