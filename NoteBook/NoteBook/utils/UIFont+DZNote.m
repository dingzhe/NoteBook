//
//  UIFont+DZNote.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "UIFont+DZNote.h"

@implementation UIFont (DZNote)
+ (instancetype) xsmallFont
{
    return [UIFont systemFontOfSize:7.5];
}
+ (instancetype) smallFont
{
    return [UIFont systemFontOfSize:9];
}
+ (instancetype) middleFontSmall
{
    return [UIFont systemFontOfSize:10];
}
+ (instancetype) middleFont
{
    return [UIFont systemFontOfSize:11];
}
+ (instancetype) middleFontLarge {
    return [UIFont systemFontOfSize:12];
}
+ (instancetype) boldMiddleFont
{
    return [UIFont boldSystemFontOfSize:11];
}
+ (instancetype) largeFont
{
    return [UIFont systemFontOfSize:14];
}
+ (instancetype) boldLargeFont
{
    return [UIFont boldSystemFontOfSize:14];
}
+ (instancetype) xlargeFont
{
    return [UIFont systemFontOfSize:16];
}
+ (instancetype) xxlargeFont
{
    return [UIFont systemFontOfSize:18];
}
+ (instancetype) xxxlargeFont
{
    return [UIFont systemFontOfSize:23];
}
+ (instancetype) xxxlargeFontPlus
{
    return [UIFont systemFontOfSize:25];
}
+ (instancetype) xxxxlargeFont
{
    return [UIFont systemFontOfSize:30];
}

@end
