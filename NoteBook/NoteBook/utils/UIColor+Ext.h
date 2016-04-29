//
//  UIColor+Ext.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Ext)
+ (UIColor *)randomColor;

+ (UIColor *)colorWithCSSColorString:(NSString *)cssColor;
- (NSString *)cssColorString;

+ (UIColor *) cellSeperatorColor;
@end
