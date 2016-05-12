//
//  MyFavoriteViewController.h
//  NoteBook
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "FeedViewController.h"
#import "MyFavoriteViewModel.h"

@interface MyFavoriteViewController : FeedViewController

@property (nonatomic,strong) MyFavoriteViewModel *viewModel;

@end
