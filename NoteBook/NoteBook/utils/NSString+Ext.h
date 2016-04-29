//
//  NSString+Ext.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Ext)
+ (NSString *)UUID;

- (unsigned)hexInteger;

- (NSString *)md5;

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding;
- (NSString *)urlDecodeUsingEncoding:(NSStringEncoding)encoding;

- (NSString *)xmlEncode;
- (NSString *)xmlDecode;

- (BOOL)isAllVisualChars;
- (BOOL)isNotEmpty;

- (NSDictionary *) queryStringDict;

+(NSString *) urlStringWithDictionary:(NSDictionary *)dictionary;
@end
