//
//  MyBlogViewController.h
//  NoteBook
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "FeedViewController.h"
#import "MyBlogViewModel.h"


@interface MyBlogViewController : FeedViewController

@property (nonatomic,strong) MyBlogViewModel *viewModel;

@end
