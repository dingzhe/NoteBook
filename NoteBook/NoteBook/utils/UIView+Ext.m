//
//  UIView+Ext.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "UIView+Ext.h"

#import "UIColor+Ext.h"

void debugHighlightViewBorderColorWidth(UIView *view, UIColor *color, CGFloat width){
#if DEBUG
    CALayer *layer = [view layer];
    layer.borderColor = color.CGColor;
    layer.borderWidth = width;
#endif
}
void debugHighlightViewBorder(UIView *view){
#if DEBUG
    debugHighlightViewBorderColorWidth(view, [UIColor randomColor], 2);
#endif
}
void debugHighlightViewBkgColor(UIView *view){
#if DEBUG
    CALayer *theLayer = [view layer];
    theLayer.backgroundColor = [UIColor randomColor].CGColor;
#endif
}

@implementation UIView(Ext_private)

- (void) _printViewHierarchyWithIndentLevel:(NSUInteger)indentLevel{
    
    NSMutableString *indentSpaces = [NSMutableString stringWithCapacity:indentLevel];
    for (int i = 0; i < indentLevel; ++i) {
        [indentSpaces appendString:@" "];
    }
    
    for (UIView *subView in self.subviews) {
        [subView _printViewHierarchyWithIndentLevel:indentLevel + 2];
    }
}

- (void)_printSuperViewHierarchyWithIndentLevel:(NSUInteger)indentLevel{
    NSMutableString *indentSpaces = [NSMutableString stringWithCapacity:indentLevel];
    for (int i = 0; i < indentLevel; ++i) {
        [indentSpaces appendString:@" "];
    }
    
    UIView *superView = self.superview;
    if (superView) {
        [superView _printSuperViewHierarchyWithIndentLevel: indentLevel + 2];
    }
}

@end

@implementation UIView(Ext)

- (void) printViewHierarchy{
    [self _printViewHierarchyWithIndentLevel:0];
}

- (void)printSuperViewHierarchy{
    [self _printSuperViewHierarchyWithIndentLevel:0];
}

+ (UIViewAnimationOptions) animationOptionsWithCurve:(UIViewAnimationCurve)curve {
    switch (curve) {
        case UIViewAnimationCurveEaseInOut:
            return UIViewAnimationOptionCurveEaseInOut;
        case UIViewAnimationCurveEaseIn:
            return UIViewAnimationOptionCurveEaseIn;
        case UIViewAnimationCurveEaseOut:
            return UIViewAnimationOptionCurveEaseOut;
        case UIViewAnimationCurveLinear:
            return UIViewAnimationOptionCurveLinear;
    }
    return 0;
}

+ (instancetype) viewFromClassNib {
    UINib *nib = [UINib nibWithNibName:NSStringFromClass(self.class) bundle:nil];
    return [nib instantiateWithOwner:nil options:nil][0];
}

@end