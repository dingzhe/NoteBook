//
//  UIColor+DZNote.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "UIColor+DZNote.h"
#import "UIColor+Ext.h"
@implementation UIColor (DZNote)
+ (instancetype) halfWhite {
    return [UIColor colorWithCSSColorString:@"ffffff5f"];
}

+ (instancetype) vsGrayColor {
    return [UIColor colorWithCSSColorString:@"898989ff"];
}

+ (instancetype) vsLightGrayColor {
    return [UIColor colorWithCSSColorString:@"eaeaeaff"];
}

+ (instancetype) vsRedColor {
    return [UIColor colorWithCSSColorString:@"da3939ff"];
}

+ (instancetype) vsBlueColor {
    return [UIColor colorWithCSSColorString:@"0d3d85ff"];
}

+ (instancetype) vsGreenColor {
    return [UIColor colorWithCSSColorString:@"3ebb5bff"];
}

+ (instancetype) vsDisableColor
{
    return [UIColor colorWithCSSColorString:@"d2d2d2ff"];
}

+ (instancetype) seperatorColor
{
    return [UIColor colorWithCSSColorString:@"d2d2d2ff"];
}

+ (instancetype) grayBackgroundColor
{
    return [UIColor colorWithCSSColorString:@"eeeeeeff"];
}

+ (instancetype) darkGrayTextColor
{
    return [UIColor colorWithCSSColorString:@"313131ff"];
}
+ (instancetype) lightGrayTextColor
{
    return [UIColor colorWithCSSColorString:@"959595ff"];
}
+ (instancetype) lightGray2TextColor
{
    return [UIColor colorWithCSSColorString:@"7f7f7fff"];
}

+(instancetype) grayTextNormalColor
{
    return [UIColor colorWithCSSColorString:@"65657bff"];
}

+(instancetype) grayTextHighlightColor
{
    return [UIColor colorWithCSSColorString:@"b9b9c0ff"];
}

+(instancetype) grayTextDisableColor
{
    return [UIColor colorWithCSSColorString:@"d2d2d2ff"];
}

+ (instancetype) grayButtonNormalColor
{
    return [UIColor colorWithCSSColorString:@"65657bff"];
}
+ (instancetype) grayButtonDisableColor
{
    return [UIColor colorWithCSSColorString:@"d2d2d2ff"];
}
+ (instancetype) grayButtonHighlightColor
{
    return [UIColor colorWithCSSColorString:@"65657bff"];
}
+ (instancetype) noticeButtonNormalColor
{
    return [UIColor colorWithCSSColorString:@"da3939ff"];
}
+ (instancetype) noticeButtonDisableColor
{
    return [UIColor colorWithCSSColorString:@"feaaaaff"];
}
+ (instancetype) noticeButtonHighlightColor
{
    return [UIColor colorWithCSSColorString:@"da3939ff"];
}
@end
