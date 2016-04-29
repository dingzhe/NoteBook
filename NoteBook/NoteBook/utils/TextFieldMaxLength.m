//
//  TextFieldMaxLength.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "TextFieldMaxLength.h"

@implementation TextFieldMaxLength
- (instancetype) init {
    if (self = [super init]) {
        // unlimited by default
        self.maxLength = NSIntegerMax;
    }
    return self;
}

#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *) textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger oldLength = [textField.text length];
    NSUInteger replacementLength = [string length];
    NSUInteger rangeLength = range.length;
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [string rangeOfString: @"\n"].location != NSNotFound;
    BOOL result = newLength <= self.maxLength || returnKey;
    
    if (result) {
        if ([self.textFieldNext respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            result = [self.textFieldNext textField:textField shouldChangeCharactersInRange:range replacementString:string];
        }
    }
    
    return result;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if ([self.textFieldNext respondsToSelector:@selector(textFieldShouldBeginEditing:)]) {
        return [self.textFieldNext textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([self.textFieldNext respondsToSelector:@selector(textFieldDidBeginEditing:)]) {
        [self.textFieldNext textFieldDidBeginEditing:textField];
    }
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([self.textFieldNext respondsToSelector:@selector(textFieldShouldEndEditing:)]) {
        return [self.textFieldNext textFieldShouldEndEditing:textField];
    }
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    if ([self.textFieldNext respondsToSelector:@selector(textFieldDidEndEditing:)]) {
        [self.textFieldNext textFieldDidEndEditing:textField];
    }
}

- (BOOL)textFieldShouldClear:(UITextField *)textField {
    if ([self.textFieldNext respondsToSelector:@selector(textFieldShouldClear:)]) {
        return [self.textFieldNext textFieldShouldClear:textField];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([self.textFieldNext respondsToSelector:@selector(textFieldShouldReturn:)]) {
        return [self.textFieldNext textFieldShouldReturn:textField];
    }
    return YES;
}

#pragma mark UITextViewDelegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    NSUInteger oldLength = [textView.text length];
    NSUInteger replacementLength = [text length];
    NSUInteger rangeLength = range.length;
    NSUInteger newLength = oldLength - rangeLength + replacementLength;
    
    BOOL returnKey = [text rangeOfString: @"\n"].location != NSNotFound;
    BOOL result = newLength <= self.maxLength || returnKey;
    
    if (result) {
        if ([self.textViewNext respondsToSelector:@selector(textField:shouldChangeCharactersInRange:replacementString:)]) {
            result = [self.textViewNext textView:textView shouldChangeTextInRange:range replacementText:text];
        }
    }
    
    return result;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if ([self.textViewNext respondsToSelector:@selector(textViewShouldBeginEditing:)]) {
        return [self.textViewNext textViewShouldBeginEditing:textView];
    }
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([self.textViewNext respondsToSelector:@selector(textViewShouldEndEditing:)]) {
        return [self.textViewNext textViewShouldEndEditing:textView];
    }
    return YES;
}

- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([self.textViewNext respondsToSelector:@selector(textViewDidBeginEditing:)]) {
        [self.textViewNext textViewDidBeginEditing:textView];
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if ([self.textViewNext respondsToSelector:@selector(textViewDidEndEditing:)]) {
        [self.textViewNext textViewDidEndEditing:textView];
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    if ([self.textViewNext respondsToSelector:@selector(textViewDidChange:)]) {
        [self.textViewNext textViewDidChange:textView];
    }
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    if ([self.textViewNext respondsToSelector:@selector(textViewDidChangeSelection:)]) {
        [self.textViewNext textViewDidChangeSelection:textView];
    }
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    if ([self.textViewNext respondsToSelector:@selector(textView:shouldInteractWithURL:inRange:)]) {
        return [self.textViewNext textView:textView shouldInteractWithURL:URL inRange:characterRange];
    }
    return YES;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithTextAttachment:(NSTextAttachment *)textAttachment inRange:(NSRange)characterRange {
    if ([self.textViewNext respondsToSelector:@selector(textView:shouldInteractWithTextAttachment:inRange:)]) {
        return [self.textViewNext textView:textView shouldInteractWithTextAttachment:textAttachment inRange:characterRange];
    }
    return YES;
}
@end
