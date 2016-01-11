//
//  WeeklyListTableViewCell.h
//  NoteBook
//
//  Created by dz on 16/1/11.
//  Copyright (c) 2016年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeeklyListTableViewCell : UITableViewCell
@property(nonatomic,strong)SWGWeekly *model;
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UILabel *autorLab;
@end
