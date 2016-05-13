//
//  ButtonCell.h
//  NoteBook
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NBTableViewCell.h"
#import "ButtonCellViewModel.h"


@interface ButtonCell : NBTableViewCell

@property (nonatomic,strong,readonly) ButtonCellViewModel *viewModel;

@end
