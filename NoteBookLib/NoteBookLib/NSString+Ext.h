//
//  NSString+Ext.h
//  bolome_shared
//
//  Created by by on 3/13/15.
//  Copyright (c) 2015 bolome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString(Ext)

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
