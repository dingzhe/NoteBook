//
//  NSAttributedString+Ext.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NSAttributedString+Ext.h"

@implementation NSAttributedString (Ext)
+ (instancetype) string:(NSString *)string {
    return [self string:string block:nil];
}

+ (instancetype) string:(NSString *)string
                  block:(AttributedStringBlock)block {
    if (!string) {
        return nil;
    }
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] initWithString:string attributes:nil];
    
    if (block) {
        block(result, string, NSMakeRange(0, string.length));
    }
    
    return result;
}

@end
