//
//  WeeklyListCell.h
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NBTableViewCell.h"
#import "WeeklyListCellViewModel.h"

@interface WeeklyListCell : NBTableViewCell

@property (nonatomic,strong,readonly) WeeklyListCellViewModel *viewModel;

@end
