//
//  UIView+Ext.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>


#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH >= 568.0 && SCREEN_MAX_LENGTH < 667.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH >= 667.0 && SCREEN_MAX_LENGTH < 736.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH >= 736.0)

#define VIEW_MARGIN (IS_IPHONE_6P?16.0f:(IS_IPHONE_6?12.0f:8.0f))
#define VIEW_MARGIN_HALF (IS_IPHONE_6P?8.0f:(IS_IPHONE_6?6.0f:4.0f))

/*
 * Can only show while define DEBUG
 
 * C functions can be totally erased by the compiler, if DEUBG is not defined.
 */
void debugHighlightViewBorderColorWidth(UIView *view, UIColor *color, CGFloat width);
void debugHighlightViewBorder(UIView *view);
void debugHighlightViewBkgColor(UIView *view);

@interface UIView(Ext)

- (void) printViewHierarchy;
- (void) printSuperViewHierarchy;

+ (UIViewAnimationOptions) animationOptionsWithCurve:(UIViewAnimationCurve)curve;

+ (instancetype) viewFromClassNib;

@end
