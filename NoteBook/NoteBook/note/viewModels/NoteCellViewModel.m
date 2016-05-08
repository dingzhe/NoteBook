//
//  NoteCellViewModel.m
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NoteCellViewModel.h"
#import "NSAttributedString+DzNote.h"
#import "NSMutableAttributedString+Ext.h"
#import "NSAttributedString+Ext.h"
#import "NSDate+DzNote.h"

@implementation NoteCellViewModel
@dynamic model;

- (instancetype) initWithModel:(SWGWeekly *)model {
    if ((self = [super initWithModel:model])) {
        _titleName = [NSAttributedString string:model.title block:^(NSMutableAttributedString *mutableAttributedString, NSString *orignalString, NSRange range) {
            [mutableAttributedString replaceFont:[UIFont largeFont] inRange:range];
            [mutableAttributedString replaceColor:[UIColor darkGrayTextColor] inRange:range];
        }];
//        _authorName = [NSAttributedString string:[NSString stringWithFormat:@"作者：%@",model.username] block:^(NSMutableAttributedString *mutableAttributedString, NSString *orignalString, NSRange range) {
//            [mutableAttributedString replaceFont:[UIFont middleFontSmall] inRange:range];
//            [mutableAttributedString replaceColor:[UIColor grayTextNormalColor] inRange:range];
//        }];
        
        NSDate * data = [[NSDate alloc] initWithTimeIntervalSince1970:model.dateline.floatValue];
        
        //        NSString * str = [data dateTimeString_yyyyMMddHHmmss];
        
        _updateTime = [NSAttributedString string:[NSString stringWithFormat:@"更新时间：%@",[data dateTimeString_yyyyMMddHHmmss]] block:^(NSMutableAttributedString *mutableAttributedString, NSString *orignalString, NSRange range) {
            [mutableAttributedString replaceFont:[UIFont middleFontSmall] inRange:range];
            [mutableAttributedString replaceColor:[UIColor grayTextNormalColor] inRange:range];
        }];
        //        _companyIndustry = [NSAttributedString string:model.companyIndustry block:^(NSMutableAttributedString *mutableAttributedString, NSString *orignalString, NSRange range) {
        //            [mutableAttributedString replaceFont:[UIFont middleFontSmall] inRange:range];
        //            [mutableAttributedString replaceColor:[UIColor grayTextNormalColor] inRange:range];
        //        }];
        //        _jobid = model.jobId;
    }
    
    return self;
}

- (void) layout {
    [super layout];
    
    UIEdgeInsets cOuterInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    
    CGSize titleNameSize = [NSAttributedString getSizeOfAttributedStr:_titleName withConstraints:CGSizeMake(self.cellWidth-cOuterInset.left-cOuterInset.right, 20)];
    _titleNameFrame = CGRectMake(cOuterInset.left, cOuterInset.top, titleNameSize.width, titleNameSize.height);
    
    
//    CGSize authorNameSize = [NSAttributedString getSizeOfAttributedStr:_authorName withConstraints:CGSizeMake(self.cellWidth-cOuterInset.left-cOuterInset.right, 20)];
//    _authorNameFrame = CGRectMake(CGRectGetMaxX(_titleNameFrame) + _titleNameFrame.origin.x, CGRectGetMinY(_titleNameFrame) + (titleNameSize.height - authorNameSize.height), authorNameSize.width, authorNameSize.height);
    
    CGSize updateTimeSize = [NSAttributedString getSizeOfAttributedStr:_updateTime withConstraints:CGSizeMake(self.cellWidth-cOuterInset.left-cOuterInset.right, 20)];
    _updateTimeFrame = CGRectMake(_titleNameFrame.origin.x, _titleNameFrame.origin.y + titleNameSize.height + 15, updateTimeSize.width, updateTimeSize.height);
    //    self.cellHeight = _updateTimeFrame.origin.y + cOuterInset.bottom;
    self.cellHeight = 60;
    //    CGSize companyIndustrySize = [NSAttributedString getSizeOfAttributedStr:_companyIndustry withConstraints:CGSizeMake(self.cellWidth-cOuterInset.left-cOuterInset.right, 20)];
    //    _companyIndustryFrame = CGRectMake(CGRectGetMinX(_companyNameFrame) + _companyNameFrame.size.width + 10,CGRectGetMinY(_companyNameFrame),companyIndustrySize.width, companyIndustrySize.height);
}
@end
