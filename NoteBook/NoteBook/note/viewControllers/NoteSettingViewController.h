//
//  NoteSettingViewController.h
//  NoteBook
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "FeedViewController.h"
#import "NoteSettingViewModel.h"

@interface NoteSettingViewController : FeedViewController

@property (nonatomic,strong) NoteSettingViewModel *viewModel;
@property (nonatomic,strong) SWGWeekly *model;
+ (instancetype) viewControllerWithModel:(SWGWeekly *)model;
@end
