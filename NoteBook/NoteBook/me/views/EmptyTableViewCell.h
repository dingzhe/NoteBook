//
//  EmptyTableViewCell.h
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NBTableViewCell.h"
#import "EmptyCellViewModel.h"

@interface EmptyTableViewCell : NBTableViewCell

@property (nonatomic, strong, readonly) EmptyCellViewModel *viewModel;

@end
