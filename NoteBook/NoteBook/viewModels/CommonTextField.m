//
//  CommonTextField.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "CommonTextField.h"

@implementation CommonTextField(private)
- (void) _init {
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 1.0f/[UIScreen mainScreen].scale;
    self.layer.cornerRadius = 3;
    self.clearsOnBeginEditing = NO;
    self.borderStyle = UITextBorderStyleNone;
    self.font = [UIFont largeFont];
}

@end

@implementation CommonTextField

- (id) initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self _init];
    }
    return self;
}

- (id) initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self _init];
    }
    return self;
}

- (CGRect)textRectForBounds:(CGRect)bounds {
    CGRect result = [super textRectForBounds:bounds];
    
    CGFloat offset = RIGHT_MARGIN;
    result.origin.x += offset;
    result.size.width -= offset ;
    return result;
}

- (CGRect)placeholderRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}

- (CGRect)clearButtonRectForBounds:(CGRect)bounds {
    CGRect result = [super clearButtonRectForBounds:bounds];
    result.origin.x -= 8.f;
    return result;
}

- (CGRect)leftViewRectForBounds:(CGRect)bounds {
    return CGRectMake(0, 0, LEFT_MARGIN, LEFT_MARGIN);
}

- (CGRect)rightViewRectForBounds:(CGRect)bounds {
    CGRect result = [super rightViewRectForBounds:bounds];
    result.origin.x -= 0;
    return result;
}

@end
