//
//  ButtonCellViewModel.h
//  NoteBook
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "CellViewModel.h"
#import "ButtonCellModel.h"


@interface ButtonCellViewModel : CellViewModel

@property (nonatomic,strong,readonly) ButtonCellModel *model;

@property (nonatomic,strong,readonly) NSAttributedString *title;

@property (nonatomic,assign,readonly) CGRect titleFrame;

@end
