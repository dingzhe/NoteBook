//
//  EmptyTableViewCell.m
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "EmptyTableViewCell.h"

@implementation EmptyTableViewCell

@dynamic viewModel;

- (void) updateWithViewModel:(CellViewModel *)viewModel {
    [super updateWithViewModel:viewModel];
    
    self.contentView.backgroundColor = self.viewModel.backgroundColor;
}

@end
