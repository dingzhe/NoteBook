//
//  NoteViewModel.h
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "FeedViewModel.h"

@interface NoteViewModel : FeedViewModel

+ (instancetype) viewModel;
- (void)deleteWeekly:(SWGWeekly *)weekly;
- (void)reload;

@end
