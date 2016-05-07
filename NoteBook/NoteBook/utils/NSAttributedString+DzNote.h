//
//  NSAttributedString+DzNote.h
//  NoteBook
//
//  Created by Mac on 16/5/4.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSAttributedString (DzNote)

+(NSDictionary*)getAtrributeDicOfAttributedStr:(NSAttributedString*)str;

+(CGSize)getSizeOfAttributedStr:(NSAttributedString*)str withConstraints:(CGSize)size;
+(CGSize)getSizeOfAttributedStr:(NSAttributedString*)str
                withConstraints:(CGSize)size
                        context:(NSStringDrawingContext *) context;

+(CGSize)getOneLineSizeOfAttributedString:(NSAttributedString *)atrributesString
                          withConstraints:(CGSize)size;
+(CGSize)getOneLineSizeOfAttributedString:(NSAttributedString *)atrributesString
                          withConstraints:(CGSize)size
                                  context:(NSStringDrawingContext *) context;

+(CGSize)getTwoLineSizeOfAttributedString:(NSAttributedString *)attributedString
                          withConstraints:(CGSize)size;
+(CGSize)getTwoLineSizeOfAttributedString:(NSAttributedString *)attributedString
                          withConstraints:(CGSize)size
                                  context:(NSStringDrawingContext *)context;

+(CGSize)getMaxTwoLineSizeOfAttributedString:(NSAttributedString *)attributedString
                             withConstraints:(CGSize)size;


@end
