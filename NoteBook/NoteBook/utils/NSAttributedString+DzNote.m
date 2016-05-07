//
//  NSAttributedString+DzNote.m
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NSAttributedString+DzNote.h"

@implementation NSAttributedString (DzNote)
+(NSDictionary*)getAtrributeDicOfAttributedStr:(NSAttributedString*)str {
    if ([[str string] isEqualToString:@""]) {
        return nil;
    }
    NSRange range = NSMakeRange(0, str.length);
    NSDictionary *attributeDic = [str attributesAtIndex:0 effectiveRange:&range];
    return attributeDic;
}

+(CGSize)getSizeOfAttributedStr:(NSAttributedString*)str withConstraints:(CGSize)size {
    return [self getSizeOfAttributedStr:str withConstraints:size context:nil];
}

+(CGSize)getSizeOfAttributedStr:(NSAttributedString*)str
                withConstraints:(CGSize)size
                        context:(NSStringDrawingContext *) context{
    if ([[str string] isEqualToString:@""]) {
        return CGSizeZero;
    }
    
    return [str boundingRectWithSize:size
                             options:NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                             context:context].size;
}

+(CGSize)getOneWordSizeOfAttributedString:(NSAttributedString *)atrributesString {
    if ([[atrributesString string] isEqualToString:@""]) {
        return CGSizeZero;
    }
    NSDictionary *attributeDic = [self getAtrributeDicOfAttributedStr:atrributesString];
    CGSize oneWordSize = [self getSizeOfAttributedStr:[[NSAttributedString alloc] initWithString:@"单" attributes:attributeDic] withConstraints:CGSizeMake(CGFLOAT_MAX, 50)];
    return oneWordSize;
}

+(CGSize)getOneLineSizeOfAttributedString:(NSAttributedString *)atrributesString withConstraints:(CGSize)size {
    return [self getOneLineSizeOfAttributedString:atrributesString
                                  withConstraints:size
                                          context:nil];
}

+(CGSize)getOneLineSizeOfAttributedString:(NSAttributedString *)atrributesString
                          withConstraints:(CGSize)size
                                  context:(NSStringDrawingContext *) context{
    if ([[atrributesString string] isEqualToString:@""]) {
        return CGSizeZero;
    }
    
    CGSize oneWordSize = [self getOneWordSizeOfAttributedString:atrributesString];
    CGSize onelineSize = [self getSizeOfAttributedStr:atrributesString
                                      withConstraints:CGSizeMake(size.width, oneWordSize.height)
                                              context:context];
    if (context) {
        onelineSize.height = context.actualScaleFactor * onelineSize.height;
    }
    return onelineSize;
}

+(CGSize)getTwoLineSizeOfAttributedString:(NSAttributedString *)attributedString withConstraints:(CGSize)size {
    return [self getTwoLineSizeOfAttributedString:attributedString
                                  withConstraints:size
                                          context:nil];
}

+(CGSize)getTwoLineSizeOfAttributedString:(NSAttributedString *)attributedString
                          withConstraints:(CGSize)size
                                  context:(NSStringDrawingContext *)context{
    if ([[attributedString string] isEqualToString:@""]) {
        return CGSizeZero;
    }
    
    NSRange range = NSMakeRange(0, attributedString.length);
    NSDictionary *attributeDic = [attributedString attributesAtIndex:0 effectiveRange:&range];
    
    CGSize oneWordSize = [self getOneWordSizeOfAttributedString:attributedString];
    CGFloat twolineHeight = [self getSizeOfAttributedStr:[[NSAttributedString alloc] initWithString:@"双g" attributes:attributeDic]
                                         withConstraints:CGSizeMake(oneWordSize.width, CGFLOAT_MAX)
                                                 context:context].height;
    CGSize twolineSize = CGSizeMake(size.width, twolineHeight);
    return twolineSize;
}

+(CGSize)getMaxTwoLineSizeOfAttributedString:(NSAttributedString *)attributedString
                             withConstraints:(CGSize)size {
    if ([[attributedString string] isEqualToString:@""]) {
        return CGSizeZero;
    }
    NSRange range = NSMakeRange(0, attributedString.length);
    NSDictionary *attributeDic = [attributedString attributesAtIndex:0 effectiveRange:&range];
    CGSize oneWordSize = [self getOneWordSizeOfAttributedString:attributedString];
    CGFloat twolineHeight = [self getSizeOfAttributedStr:[[NSAttributedString alloc] initWithString:@"双g" attributes:attributeDic] withConstraints:CGSizeMake(oneWordSize.width, CGFLOAT_MAX)].height;
    CGSize maxTwolineSize = [self getSizeOfAttributedStr:attributedString withConstraints:CGSizeMake(size.width, twolineHeight)];
    return maxTwolineSize;
}
@end
