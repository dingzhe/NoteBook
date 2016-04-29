//
//  UIColor+Ext.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "UIColor+Ext.h"
#import "NSString+Ext.h"
@implementation UIColor (Ext)
+ (UIColor *)randomColor{
    
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        srandom((unsigned)time(NULL));
    });
    
    return [UIColor colorWithRed:(CGFloat)(random()%256)/255
                           green:(CGFloat)(random()%256)/255
                            blue:(CGFloat)(random()%256)/255
                           alpha:1.];
}

+ (UIColor *)colorWithCSSColorString:(NSString *)cssColor{
    UIColor *result = nil;
    
    if (8 != [cssColor length])
        return result;
    
    CGFloat red   = [[cssColor substringWithRange:NSMakeRange(0, 2)] hexInteger]/255.f;
    CGFloat green = [[cssColor substringWithRange:NSMakeRange(2, 2)] hexInteger]/255.f;
    CGFloat blue  = [[cssColor substringWithRange:NSMakeRange(4, 2)] hexInteger]/255.f;
    CGFloat alpha = [[cssColor substringWithRange:NSMakeRange(6, 2)] hexInteger]/255.f;
    
    result = [self colorWithRed:red green:green blue:blue alpha:alpha];
    
    return result;
}

- (NSString *)cssColorString{
    NSString *result = nil;
    
    const CGFloat *colorComponents = CGColorGetComponents(self.CGColor);
    
    int red   = colorComponents[0] * 255;
    int green = colorComponents[1] * 255;
    int blue  = colorComponents[2] * 255;
    int alpha = colorComponents[3] * 255;
    
    result = [NSString stringWithFormat:@"%.2x%.2x%.2x%.2x", red, green, blue, alpha];
    
    return result;
}

+ (UIColor *) cellSeperatorColor {
    return [UIColor colorWithRed:200/255.0 green:199/255.0 blue:204/255.0 alpha:1.0];
}

@end
