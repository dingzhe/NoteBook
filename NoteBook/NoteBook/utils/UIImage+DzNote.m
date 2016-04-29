//
//  UIImage+DzNote.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "UIImage+DzNote.h"

@implementation UIImage (DzNote)
+ (UIImage *)placeHolderImage {
    UIImage *img = [UIImage imageNamed:@"bg_placeholder.png"];
    return img;
}

+ (UIImage *)userPlaceHolderImage {
    UIImage *img = [UIImage imageNamed:@"ic_resume_head.png"];
    return img;
}

+ (UIImage *)greenBtnNormalImage {
    UIImage *img = [UIImage imageNamed:@"btn_bg_green_normal.png"];
    img = [img stretchableImageWithLeftCapWidth:2 topCapHeight:2];
    return img;
}

+ (UIImage *)greenBtnDisableImage {
    UIImage *img = [UIImage imageNamed:@"btn_bg_green_disable.png"];
    img = [img stretchableImageWithLeftCapWidth:2 topCapHeight:2];
    return img;
}

+ (UIImage *)grayBtnNormalImage {
    UIImage *img = [UIImage imageNamed:@"btn_bg_gray_normal.png"];
    img = [img stretchableImageWithLeftCapWidth:2 topCapHeight:2];
    return img;
}

+ (UIImage *)strokeBlueNormalImage {
    UIImage *img = [UIImage imageNamed:@"btn_stroke_blue_normal.png"];
    img = [img stretchableImageWithLeftCapWidth:3 topCapHeight:3];
    return img;
}

@end
