//
//  NSMutableAttributedString+Ext.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableAttributedString (Ext)
- (void) replaceFont:(UIFont *)font inRange:(NSRange)range;
- (void) replaceColor:(UIColor *)color inRange:(NSRange)range;
- (void) replaceParagraphStyle:(NSMutableParagraphStyle *)style inRange:(NSRange)range;

- (void) setLineSpace:(CGFloat)space lineHeightMultiple:(CGFloat)multiple inRange:(NSRange)range;
@end
