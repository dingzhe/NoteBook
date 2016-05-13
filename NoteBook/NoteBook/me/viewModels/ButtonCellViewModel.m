//
//  ButtonCellViewModel.m
//  NoteBook
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "ButtonCellViewModel.h"
#import "NSAttributedString+DzNote.h"
#import "NSAttributedString+Ext.h"
#import "NSMutableAttributedString+Ext.h"

@implementation ButtonCellViewModel
@dynamic model;

- (instancetype) initWithModel:(ButtonCellModel *)model {
    if ((self = [super initWithModel:model])) {
        
        _title = [NSAttributedString string:model.title block:^(NSMutableAttributedString *mutableAttributedString, NSString *orignalString, NSRange range) {
            [mutableAttributedString replaceFont:[UIFont largeFont] inRange:range];
            [mutableAttributedString replaceColor:[UIColor vsBlueColor] inRange:range];
        }];
    }
    
    return self;
}

- (void) layout {
    [super layout];
    
    self.cellHeight = 40;
    
    _titleFrame = CGRectMake(0, 0,self.cellWidth, self.cellHeight);
}
@end
