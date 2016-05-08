//
//  NoteTableViewCell.h
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NBTableViewCell.h"
#import "NoteCellViewModel.h"

@interface NoteTableViewCell : NBTableViewCell

@property (nonatomic,strong,readonly) NoteCellViewModel *viewModel;

@end
