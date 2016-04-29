//
//  UITextField+Ext.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "UITextField+Ext.h"
#import "TextFieldMaxLength.h"

@implementation UITextField (Ext)
@dynamic maxLength;
- (NSInteger) maxLength {
    TextFieldMaxLength *obj = GET_ASSOCIATED_OBJ();
    return obj ? obj.maxLength : NSIntegerMax;
}
- (void) setMaxLength:(NSInteger)length {
    TextFieldMaxLength *maxLength = [TextFieldMaxLength new];
    maxLength.maxLength = length;
    maxLength.textFieldNext = self.delegate;
    self.delegate = maxLength;
    
    @weakify(self)
    [[self.rac_textSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(id _) {
        @strongify(self)
        if (self.text.length > length) {
            self.text = [self.text substringToIndex:length];
        }
    }];
    
    SET_ASSOCIATED_OBJ_RETAIN_NONATOMIC(maxLength);
}

- (NSString *) textIfChangeTextInRange:(NSRange)range
                       replacementText:(NSString *)text{
    return [self.text stringByReplacingCharactersInRange:range withString:text];
}

- (NSInteger) textLengthIfChangeTextInRange:(NSRange)range
                            replacementText:(NSString *)text{
    return [text length] - range.length + [self.text length];
}
@end
