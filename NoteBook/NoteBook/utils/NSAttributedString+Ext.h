//
//  NSAttributedString+Ext.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef void(^AttributedStringBlock)(NSMutableAttributedString *mutableAttributedString, NSString *orignalString, NSRange range);

@interface NSAttributedString(Ext)

+ (instancetype) string:(NSString *)string;

+ (instancetype) string:(NSString *)string
                  block:(AttributedStringBlock)block;

@end
