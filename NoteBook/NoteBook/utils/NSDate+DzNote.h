//
//  NSDate+DzNote.h
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (DzNote)

- (NSString *) countDownTextToDate_YYMMddHHmmsss:(NSDate *)date;

- (NSString *) countDownTextToDate_YYMMddHHmmss:(NSDate *)date;

- (NSString *) dateString_specialMdHHmm;
- (NSString *) dateTimeString_yyyyMMddHHmmss;
- (NSString *) dateTimeString_MdHHmm;
- (NSString *) dateString_MMdd;
- (NSString *) timeString_HHmm;

@end
