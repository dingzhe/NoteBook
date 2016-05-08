//
//  WeeklyListCellViewModel.h
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "CellViewModel.h"

@interface WeeklyListCellViewModel : CellViewModel

@property (nonatomic,strong,readonly) SWGWeekly *model;

@property (nonatomic,strong,readonly) NSAttributedString *titleName;
@property (nonatomic,strong,readonly) NSAttributedString *authorName;
@property (nonatomic,strong,readonly) NSAttributedString *updateTime;
//@property (nonatomic,strong,readonly) NSAttributedString *jobName;
//@property (nonatomic,strong,readonly) NSNumber *jobid;

@property (nonatomic,assign,readonly) CGRect titleNameFrame;
@property (nonatomic,assign,readonly) CGRect authorNameFrame;
@property (nonatomic,assign,readonly) CGRect updateTimeFrame;
//@property (nonatomic,assign,readonly) CGRect jobNameFrame;


@end
