//
//  PersonalManagerHeadCellViewModel.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CellViewModel.h"
#import "PersonalManagerHeadCellModel.h"
@interface PersonalManagerHeadCellViewModel : CellViewModel

@property (nonatomic,strong,readonly) PersonalManagerHeadCellModel *model;

@property (nonatomic,strong,readonly) NSString *headImgUrl;
@property (nonatomic,strong,readonly) NSAttributedString *username;
@property (nonatomic,strong,readonly) NSAttributedString *email;


@property (nonatomic,assign,readonly) CGRect usrnameFrame;
@property (nonatomic,assign,readonly) CGRect emailFrame;

@property (nonatomic,assign,readonly) CGRect bgImgFrame;
@property (nonatomic,assign,readonly) CGRect headImgFrame;
@property (nonatomic,assign,readonly) CGRect photoImgFrame;
@property (nonatomic,assign,readonly) CGRect previewBtnFrame;
@property (nonatomic,assign,readonly) CGRect browseHistoryBtnFrame;


@end
