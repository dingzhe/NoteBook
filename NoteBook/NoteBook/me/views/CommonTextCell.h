//
//  CommonTextCell.h
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NBTableViewCell.h"
#import "CommonTextCellViewModel.h"



@interface CommonTextCell : NBTableViewCell

@property (nonatomic,strong) UISwitch *switchbtn;
@property (nonatomic,strong,readonly) CommonTextCellViewModel *viewModel;

@end
