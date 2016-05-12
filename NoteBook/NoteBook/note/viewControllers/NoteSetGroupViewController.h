//
//  NoteSetGroupViewController.h
//  NoteBook
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "FeedViewController.h"
#import "NoteSetGroupViewModel.h"



@interface NoteSetGroupViewController : FeedViewController

@property (nonatomic,strong) NoteSetGroupViewModel *viewModel;
@property (nonatomic,strong,readonly) RACSubject *selectedSignal;
@property (nonatomic,strong) SWGWeekly *model;
+ (instancetype) viewControllerWithModel:(SWGWeekly *)model;
@end
