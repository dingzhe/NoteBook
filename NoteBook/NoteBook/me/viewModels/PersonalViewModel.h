//
//  PersonalViewModel.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "FeedViewModel.h"
#import "CommonTextCellModel.h"
#import "PersonalManagerInfoCellViewModel.h"
#import "PersonalManagerHeadCellViewModel.h"

@interface PersonalViewModel : FeedViewModel
@property(nonatomic,strong) RACCommand *queryResumeCommand;
@property(nonatomic,strong) RACSubject *refreshedSignal;

DEF_SINGLETON(sharedViewModel)

- (void)reload;
- (void)refreshResume;
- (void)updateAvatar:(UIImage *)avatarImage;


@end
