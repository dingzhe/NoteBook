//
//  UITextField+Ext.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextField (Ext)
@property (nonatomic, assign) NSInteger maxLength;

- (NSString *) textIfChangeTextInRange:(NSRange)range
                       replacementText:(NSString *)text;


- (NSInteger) textLengthIfChangeTextInRange:(NSRange)range
                            replacementText:(NSString *)text;

@end
