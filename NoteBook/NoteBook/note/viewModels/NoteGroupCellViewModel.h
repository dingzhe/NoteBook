//
//  NoteGroupCellViewModel.h
//  NoteBook
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "CellViewModel.h"

@interface NoteGroupCellViewModel : CellViewModel
@property (nonatomic,strong,readonly) SWGNoteGroup *model;

@property (nonatomic,strong,readonly) NSAttributedString *titleName;
//@property (nonatomic,strong,readonly) NSAttributedString *authorName;
@property (nonatomic,strong,readonly) NSAttributedString *updateTime;
//@property (nonatomic,strong,readonly) NSAttributedString *jobName;
//@property (nonatomic,strong,readonly) NSNumber *jobid;

@property (nonatomic,assign,readonly) CGRect titleNameFrame;
//@property (nonatomic,assign,readonly) CGRect authorNameFrame;
@property (nonatomic,assign,readonly) CGRect updateTimeFrame;
@end
