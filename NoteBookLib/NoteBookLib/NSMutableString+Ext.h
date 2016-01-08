//
//  NSMutableString+Ext.h
//  bolome_shared
//
//  Created by by on 3/13/15.
//  Copyright (c) 2015 bolome. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableString(Ext)

- (NSMutableString *)mutableXmlEncode;
- (NSMutableString *)mutableXmlDecode;

@end
