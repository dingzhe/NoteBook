//
//  CommonTextCellViewModel.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "CommonTextCellViewModel.h"
#import "NSAttributedString+DzNote.h"
#import "NSAttributedString+Ext.h"
#import "NSMutableAttributedString+Ext.h"
@implementation CommonTextCellViewModel
@dynamic model;

- (instancetype) initWithModel:(CommonTextCellModel *)model {
    if ((self = [super initWithModel:model])) {
        
        BOOL  isDisable = (model.editType == CommonTextCellEditTypeDisable);
        
        _title = [NSAttributedString string:model.title block:^(NSMutableAttributedString *mutableAttributedString, NSString *orignalString, NSRange range) {
            [mutableAttributedString replaceFont:[UIFont largeFont] inRange:range];
            [mutableAttributedString replaceColor:isDisable?[UIColor lightGray2TextColor]:[UIColor darkGrayTextColor] inRange:range];
        }];
        
        _subTitle = [NSAttributedString string:model.subTitle block:^(NSMutableAttributedString *mutableAttributedString, NSString *orignalString, NSRange range) {
            [mutableAttributedString replaceFont:[UIFont largeFont] inRange:range];
            [mutableAttributedString replaceColor:isDisable?[UIColor lightGray2TextColor]:[UIColor lightGrayTextColor] inRange:range];
        }];
        
        _detailText = [NSAttributedString string:model.detailText block:^(NSMutableAttributedString *mutableAttributedString, NSString *orignalString, NSRange range) {
            [mutableAttributedString replaceFont:[UIFont largeFont] inRange:range];
            [mutableAttributedString replaceColor:isDisable?[UIColor lightGray2TextColor]:[UIColor lightGrayTextColor] inRange:range];
        }];
        
        _count = [NSAttributedString string:model.count block:^(NSMutableAttributedString *mutableAttributedString, NSString *orignalString, NSRange range) {
            [mutableAttributedString replaceFont:[UIFont largeFont] inRange:range];
            [mutableAttributedString replaceColor:isDisable?[UIColor lightGray2TextColor]:[UIColor whiteColor] inRange:range];
        }];
        _showSwitch = model.showSwitch;
        _showIndicator = model.showIndicator;
        _isblog = model.isBlog;
        if (model.editType == CommonTextCellEditTypeDisable) {
            _showIndicator = NO;
        }
        
        self.selectable = (model.editType != CommonTextCellEditTypeDisable);
    }
    
    return self;
}

- (void) layout {
    [super layout];
    
    UIEdgeInsets cOuterInset = UIEdgeInsetsMake(20, 20, 20, 20);
    CGFloat oneLineHeight = 40;
    
    CGSize titleSize = [NSAttributedString getSizeOfAttributedStr:_title withConstraints:CGSizeMake(self.cellWidth-cOuterInset.left-(_showIndicator==YES?40:cOuterInset.right), 20)];
    _titleFrame = CGRectMake(cOuterInset.left, 0, titleSize.width, oneLineHeight);
    
    CGSize subTitleSize = [NSAttributedString getSizeOfAttributedStr:_subTitle withConstraints:CGSizeMake(self.cellWidth-cOuterInset.left-(_showIndicator==YES?40:cOuterInset.right)-titleSize.width, 20)];
    _subTitleFrame = CGRectMake(self.cellWidth-(_showIndicator==YES?40:cOuterInset.right)-subTitleSize.width, 0, subTitleSize.width, oneLineHeight);
    
    CGSize detailTextSize = [NSAttributedString getSizeOfAttributedStr:_detailText withConstraints:CGSizeMake(self.cellWidth-cOuterInset.left-(_showIndicator==YES?40:cOuterInset.right), CGFLOAT_MAX)];
    _detailTextFrame = CGRectMake(cOuterInset.left,oneLineHeight,detailTextSize.width,detailTextSize.height);
    
    _switchBtnFrame = CGRectMake(self.cellWidth-(_showSwitch==YES?40:cOuterInset.right)- 30, 0,120, self.cellHeight);
    if (_detailText.length>0) {
        self.cellHeight = CGRectGetMaxY(_detailTextFrame)+(oneLineHeight-titleSize.height)/2;
    }else{
        self.cellHeight = oneLineHeight;
    }
    
}

@end
