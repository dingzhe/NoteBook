//
//  WeeklyListTableViewCell.m
//  NoteBook
//
//  Created by dz on 16/1/11.
//  Copyright (c) 2016年 dz. All rights reserved.
//

#import "WeeklyListTableViewCell.h"

@implementation WeeklyListTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    if (!self.model) {
        self.titleLab = [[UILabel alloc] init];
        [self.titleLab setText:self.model.title];
        self.autorLab = [[UILabel alloc] init];
        [self.autorLab setText:self.model.uid];
    };
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
    
    
}



@end
