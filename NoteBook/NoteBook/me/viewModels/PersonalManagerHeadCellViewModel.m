//
//  PersonalManagerHeadCellViewModel.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "PersonalManagerHeadCellViewModel.h"
#import "NSAttributedString+DzNote.h"
#import "NSMutableAttributedString+Ext.h"
#import "NSAttributedString+Ext.h"

@implementation PersonalManagerHeadCellViewModel
@dynamic model;

- (instancetype) initWithModel:(PersonalManagerHeadCellModel *)model {
    if ((self = [super initWithModel:model])) {
        _headImgUrl = model.headImgUrl;
        NSLog(@"username:%@ \n email:%@",UserModel.currentUser.username,UserModel.currentUser.email);
        _username = [NSAttributedString string:UserModel.currentUser.username block:^(NSMutableAttributedString *mutableAttributedString, NSString *orignalString, NSRange range) {
            [mutableAttributedString replaceFont:[UIFont largeFont] inRange:range];
            [mutableAttributedString replaceColor:[UIColor darkGrayTextColor] inRange:range];
        }];
        _email = [NSAttributedString string: UserModel.currentUser.email block:^(NSMutableAttributedString *mutableAttributedString, NSString *orignalString, NSRange range) {
            [mutableAttributedString replaceFont:[UIFont middleFontSmall] inRange:range];
            [mutableAttributedString replaceColor:[UIColor grayTextNormalColor] inRange:range];
        }];
    }
    
    return self;
}

- (void) layout {
    [super layout];
    
    UIEdgeInsets cOuterInset = UIEdgeInsetsMake(10, 30, 10, 30);
    self.cellHeight = self.cellWidth*347/640;
    
    _bgImgFrame = CGRectMake(0, 0, self.cellWidth, self.cellHeight);
    _previewBtnFrame = CGRectMake(cOuterInset.left, self.cellHeight-cOuterInset.bottom-30, 110, 30);
    _browseHistoryBtnFrame = CGRectMake(self.cellWidth-cOuterInset.right-110, self.cellHeight-cOuterInset.bottom-30, 110, 30);
    _headImgFrame = CGRectMake((self.cellWidth-89)/2, (self.cellHeight-89)/2-20, 89, 89);
    _photoImgFrame = CGRectMake(CGRectGetMaxX(_headImgFrame)-35, CGRectGetMaxY(_headImgFrame)-30, 35, 30);
    
    
    CGSize usrnameNameSize = [NSAttributedString getSizeOfAttributedStr:_username withConstraints:CGSizeMake(self.cellWidth-cOuterInset.left-cOuterInset.right, 20)];
    _usrnameFrame = CGRectMake((self.cellWidth - usrnameNameSize.width) / 2, CGRectGetMaxY(_headImgFrame) + 10, usrnameNameSize.width, usrnameNameSize.height);
    
    
    CGSize emailSize = [NSAttributedString getSizeOfAttributedStr:_email withConstraints:CGSizeMake(self.cellWidth-cOuterInset.left-cOuterInset.right, 20)];
    _emailFrame = CGRectMake((self.cellWidth - emailSize.width) / 2, CGRectGetMaxY(_usrnameFrame) + 10, emailSize.width, emailSize.height);
}
@end
