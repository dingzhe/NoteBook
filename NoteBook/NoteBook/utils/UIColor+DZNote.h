//
//  UIColor+DZNote.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DZNote)
+ (instancetype) halfWhite;
+ (instancetype) vsGrayColor;
+ (instancetype) vsLightGrayColor;

+ (instancetype) vsRedColor;
+ (instancetype) vsBlueColor;
+ (instancetype) vsGreenColor;
+ (instancetype) vsDisableColor;

+ (instancetype) seperatorColor;
+ (instancetype) grayBackgroundColor;

+ (instancetype) darkGrayTextColor;
+ (instancetype) lightGrayTextColor;
+ (instancetype) lightGray2TextColor;

+(instancetype) grayTextNormalColor;
+(instancetype) grayTextHighlightColor;
+(instancetype) grayTextDisableColor;

+ (instancetype) grayButtonNormalColor;
+ (instancetype) grayButtonDisableColor;
+ (instancetype) grayButtonHighlightColor;
+ (instancetype) noticeButtonNormalColor;
+ (instancetype) noticeButtonDisableColor;
+ (instancetype) noticeButtonHighlightColor;
@end
