//
//  NSString+Ext.m
//  bolome_shared
//
//  Created by by on 3/13/15.
//  Copyright (c) 2015 bolome. All rights reserved.
//

#import "NSString+Ext.h"
#import "NSMutableString+Ext.h"
#import <CommonCrypto/CommonDigest.h>

@implementation NSString(Ext)

+ (NSString *)UUID{
    NSString *result = nil;
    
    CFUUIDRef   uuid;
    CFStringRef uuidStr;
    
    uuid = CFUUIDCreate(NULL);
    assert(uuid != NULL);
    
    uuidStr = CFUUIDCreateString(NULL, uuid);
    assert(uuidStr != NULL);
    
    result = [NSString stringWithString:(__bridge NSString *)uuidStr];
    
    CFRelease(uuidStr);
    CFRelease(uuid);
    
    return result;
}

- (unsigned)hexInteger{
    unsigned result = 0;
    
    NSScanner *scanner = [[NSScanner alloc] initWithString:self];
    if (![scanner scanHexInt:&result])
        result = 0;
    
    return result;
}

- (NSString *)md5{
    const char *zcSrc = [self UTF8String];
    
    unsigned char zcDes[16];
    CC_MD5( zcSrc, (CC_LONG)strlen(zcSrc), zcDes );
    
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            zcDes[0], zcDes[1], zcDes[2], zcDes[3],
            zcDes[4], zcDes[5], zcDes[6], zcDes[7],
            zcDes[8], zcDes[9], zcDes[10], zcDes[11],
            zcDes[12], zcDes[13], zcDes[14], zcDes[15]
            ]; 
}

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                                 NULL,
                                                                                 (__bridge CFStringRef) self,
                                                                                 NULL,
                                                                                 CFSTR("!*'();:@&=+$,/?%#[]\" "),
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding)));
}

- (NSString *)urlDecodeUsingEncoding:(NSStringEncoding)encoding {
    return [self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)xmlEncode{
    return [[NSMutableString stringWithString:self] mutableXmlEncode];
}
- (NSString *)xmlDecode{
    return [[NSMutableString stringWithString:self] mutableXmlDecode];
}

- (BOOL)isAllVisualChars{
    BOOL result = NO;
    
    if ([self length]) {
        NSCharacterSet *nonVisualCharset = [NSCharacterSet whitespaceAndNewlineCharacterSet];
        NSScanner *scanner = [NSScanner scannerWithString:self];
        [scanner scanCharactersFromSet:nonVisualCharset intoString:nil];
        result = ![scanner isAtEnd];
    }
    
    return result;
}

- (BOOL)isNotEmpty{
    return [self isKindOfClass:[NSString class]] && [self length] > 0;
}

- (NSDictionary *) queryStringDict {
    NSMutableDictionary *result = nil;
    
    NSArray *queries = [self componentsSeparatedByString:@"&"];
    
    if (queries.count > 0) {
        result = [NSMutableDictionary dictionaryWithCapacity:queries.count];
        [queries enumerateObjectsUsingBlock:^(NSString *queryPair, NSUInteger idx, BOOL *stop) {
            NSArray *keyVal = [queryPair componentsSeparatedByString:@"="];
            if (2 == keyVal.count) {
                [result setObject:keyVal[1] forKey:keyVal[0]];
            }
        }];
    }
    
    return result;
}

+(NSString *) urlStringWithDictionary:(NSDictionary *)dictionary {
    NSArray *array = [dictionary allKeys];
    
    NSArray *keyArray = [array sortedArrayUsingSelector:@selector(compare:)];
    
    NSMutableString *url = [[NSMutableString alloc]init];
    
    for (int i = 0; i < dictionary.count; i++) {
        NSMutableString *str = [[NSMutableString alloc]init];
        if (i!=0) {
            [str appendString:@"&"];
        }
        if ([[dictionary objectForKey:keyArray[i]] isKindOfClass:[NSString class]]) {
            NSString *valueStr = [dictionary objectForKey:keyArray[i]];
            valueStr = [valueStr urlEncodeUsingEncoding:NSUTF8StringEncoding];
            [str appendString:[NSString stringWithFormat:@"%@=%@",keyArray[i],valueStr]];
        }else if ([[dictionary objectForKey:keyArray[i]] isKindOfClass:[NSDictionary class]]){
            NSDictionary *info = (NSDictionary*)[dictionary objectForKey:keyArray[i]];
            for (NSString *key in info) {
                NSString *value = info[key];
                value = [value urlEncodeUsingEncoding:NSUTF8StringEncoding];
                NSString *encodeKey = [[NSString stringWithFormat:@"[%@]",key] urlEncodeUsingEncoding:NSUTF8StringEncoding];
                NSString *temStr;
                temStr = [NSString stringWithFormat:@"%@%@=%@&",keyArray[i],encodeKey,value];
                [str appendString:temStr];
            }
            [str deleteCharactersInRange:NSMakeRange(str.length-1, 1)];
            
        }
        [url appendString:str];
    }
    return url;
}


@end
