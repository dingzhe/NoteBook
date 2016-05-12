//
//  NoteSetGroupViewModel.h
//  NoteBook
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "FeedViewModel.h"

@interface NoteSetGroupViewModel : FeedViewModel

+ (instancetype) viewModel;
- (void)deleteNoteGroup:(SWGNoteGroup *)NoteGroup;
- (void)reload;

@end
