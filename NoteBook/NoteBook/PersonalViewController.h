//
//  PersonalViewController.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeedViewController.h"
#import "PersonalViewModel.h"

@interface PersonalViewController : FeedViewController

@property (nonatomic, strong)PersonalViewModel *viewModel;

+ (instancetype) viewController;

@end
