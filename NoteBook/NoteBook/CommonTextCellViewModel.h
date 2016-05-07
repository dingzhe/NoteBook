//
//  CommonTextCellViewModel.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "CellViewModel.h"
#import "CommonTextCellModel.h"

@interface CommonTextCellViewModel : CellViewModel

@property (nonatomic,strong,readonly) CommonTextCellModel *model;

@property (nonatomic,strong) NSAttributedString *title;
@property (nonatomic,strong) NSAttributedString *subTitle;
@property (nonatomic,strong) NSAttributedString *detailText;
@property (nonatomic,strong) NSAttributedString *imageUrl;
@property (nonatomic,strong) NSAttributedString *count;
@property (nonatomic,assign) BOOL showIndicator;

@property (nonatomic,assign) CGRect titleFrame;
@property (nonatomic,assign) CGRect subTitleFrame;
@property (nonatomic,assign) CGRect detailTextFrame;
@property (nonatomic,assign) CGRect imageFrame;
@property (nonatomic,assign) CGRect countFrame;
@end
