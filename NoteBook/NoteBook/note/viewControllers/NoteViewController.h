//
//  NoteViewController.h
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "FeedViewController.h"
#import "NoteViewModel.h"

@interface NoteViewController : FeedViewController

@property (nonatomic,strong) NoteViewModel *viewModel;

@end
