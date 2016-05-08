//
//  PersonalInformationViewModel.h
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "FeedViewModel.h"
#import "CommonTextCellViewModel.h"

@interface PersonalInformationViewModel : FeedViewModel

+ (instancetype) viewModel;

- (void)reload;
- (void)modifyModel:(CommonTextCellModel*)model withValue:(id)value;
- (void)save;

@end
