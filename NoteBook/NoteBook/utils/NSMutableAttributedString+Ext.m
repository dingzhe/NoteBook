//
//  NSMutableAttributedString+Ext.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NSMutableAttributedString+Ext.h"
#import <CoreText/CoreText.h>

@implementation NSMutableAttributedString (Ext)
- (void) replaceFont:(UIFont *)font inRange:(NSRange)range {
    CTFontRef ctFont = CTFontCreateWithName((__bridge CFStringRef)font.fontName, font.pointSize, NULL);
    [self removeAttribute:(__bridge NSString *)kCTFontAttributeName range:range];
    [self addAttribute:(__bridge NSString *)kCTFontAttributeName value:(__bridge id)ctFont range:range];
}

- (void) replaceColor:(UIColor *)color inRange:(NSRange)range {
    // set text color for CoreText
    [self removeAttribute:(__bridge NSString *)kCTForegroundColorAttributeName range:range];
    [self addAttribute:(__bridge NSString*)kCTForegroundColorAttributeName value:color range:range];
    
    // set text color for UIKit
    [self removeAttribute:NSForegroundColorAttributeName range:range];
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
}

- (void) replaceParagraphStyle:(NSMutableParagraphStyle *)style inRange:(NSRange)range {
    [self removeAttribute:(__bridge NSString *)kCTParagraphStyleAttributeName range:range];
    [self addAttribute:(__bridge NSString *)kCTParagraphStyleAttributeName value:style range:range];
}

- (void) setLineSpace:(CGFloat)space lineHeightMultiple:(CGFloat)multiple inRange:(NSRange)range {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = space;
    style.lineHeightMultiple = multiple;
    
    [self addAttribute:(__bridge NSString *)kCTParagraphStyleAttributeName value:style range:range];
}

@end
