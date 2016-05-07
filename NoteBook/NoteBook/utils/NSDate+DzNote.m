//
//  NSDate+DzNote.m
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NSDate+DzNote.h"

#define NANO_SECOND(nano) (int)((nano)/50000000.f * 3)

@implementation NSDate (DzNote)

- (NSString *) countDownTextToDate_YYMMddHHmmsss:(NSDate *)date {
    NSString *result = nil;
    
    long long miliSeconds = (long long)([date timeIntervalSinceDate:self] * 10);
    int year = (int)(miliSeconds / 315360000);
    int month = (miliSeconds % 315360000) / 25920000;
    int day = (miliSeconds % 25920000) / 864000;
    int hour = (miliSeconds % 864000) / 36000;
    int minute = (miliSeconds % 36000) / 600;
    int second = (miliSeconds % 600) / 10;
    int miliSecond = miliSeconds % 10;
    
    if (year > 0) {
        result = [NSString stringWithFormat:@"%02d年%02d月%02d天%02d时%02d分%02d秒%d",
                  year,
                  month,
                  day,
                  hour,
                  minute,
                  second,
                  miliSecond];
    }
    else if (month > 0) {
        result = [NSString stringWithFormat:@"%02d月%02d天%02d时%02d分%02d秒%d",
                  month,
                  day,
                  hour,
                  minute,
                  second,
                  miliSecond];
    }
    else if (day > 0) {
        result = [NSString stringWithFormat:@"%02d天%02d时%02d分%02d秒%d",
                  day,
                  hour,
                  minute,
                  second,
                  miliSecond];
    }
    else if (hour > 0) {
        result = [NSString stringWithFormat:@"%02d时%02d分%02d秒%d",
                  hour,
                  minute,
                  second,
                  miliSecond];
    }
    else {
        result = [NSString stringWithFormat:@"%02d分%02d秒%d",
                  (int)MAX(minute, 0),
                  (int)MAX(second, 0),
                  MAX(miliSecond, 0)];
    }
    
    return result;
}

- (NSString *) countDownTextToDate_YYMMddHHmmss:(NSDate *)date {
    NSString *result = nil;
    
    long long miliSeconds = [date timeIntervalSinceDate:self];
    int year = (int)(miliSeconds / 31536000);
    int month = (miliSeconds % 31536000) / 2592000;
    int day = (miliSeconds % 2592000) / 86400;
    int hour = (miliSeconds % 86400) / 3600;
    int minute = (miliSeconds % 3600) / 60;
    int second = miliSeconds % 60;
    
    if (year > 0) {
        result = [NSString stringWithFormat:@"%02d年%02d月%02d天%02d时%02d分%02d秒",
                  year,
                  month,
                  day,
                  hour,
                  minute,
                  second];
    }
    else if (month > 0) {
        result = [NSString stringWithFormat:@"%02d月%02d天%02d时%02d分%02d秒",
                  month,
                  day,
                  hour,
                  minute,
                  second];
    }
    else if (day > 0) {
        result = [NSString stringWithFormat:@"%02d天%02d时%02d分%02d秒",
                  day,
                  hour,
                  minute,
                  second];
    }
    else if (hour > 0) {
        result = [NSString stringWithFormat:@"%02d时%02d分%02d秒",
                  hour,
                  minute,
                  second];
    }
    else {
        result = [NSString stringWithFormat:@"%02d分%02d秒",
                  (int)MAX(minute, 0),
                  (int)MAX(second, 0)];
    }
    
    return result;
}

- (NSString *) dateString_specialMdHHmm
{
    NSString *formattedDate;
    NSDateComponents *descomps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:self];
    NSDateComponents *systemcomps = [[NSCalendar currentCalendar] components:NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit fromDate:[NSDate date]];
    if ([descomps year] == [systemcomps year] && [descomps month] == [systemcomps month]&& [descomps day] == [systemcomps day])
    {
        formattedDate = [NSString stringWithFormat:@"今天 %@",[self timeString_HHmm]];
    }else if ([descomps year] == [systemcomps year] && [descomps month] == [systemcomps month]&& [descomps day] == [systemcomps day]-1)
    {
        formattedDate = [NSString stringWithFormat:@"昨天 %@",[self timeString_HHmm]];
    }else if ([descomps year] == [systemcomps year] && [descomps month] == [systemcomps month]&& [descomps day] == [systemcomps day]-2)
    {
        formattedDate = [NSString stringWithFormat:@"前天 %@",[self timeString_HHmm]];
    }else
    {
        formattedDate = [self dateTimeString_MdHHmm];
    }
    return formattedDate;
}

- (NSString *) dateTimeString_yyyyMMddHHmmss {
    static NSDateFormatter *formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    }
    return [formatter stringFromDate:self];
}

- (NSString *) dateTimeString_MdHHmm {
    static NSDateFormatter *formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"M月d日 HH:mm";
    }
    return [formatter stringFromDate:self];
}

- (NSString *) dateString_MMdd {
    static NSDateFormatter *formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"MM月dd日";
    }
    return [formatter stringFromDate:self];
}

- (NSString *) timeString_HHmm {
    static NSDateFormatter *formatter = nil;
    if (!formatter) {
        formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"HH:mm";
    }
    return [formatter stringFromDate:self];
}



@end
