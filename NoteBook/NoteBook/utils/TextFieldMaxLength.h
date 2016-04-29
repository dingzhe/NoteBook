//
//  TextFieldMaxLength.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TextFieldMaxLength : NSObject<UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, assign) NSInteger maxLength;

@property(nonatomic, assign) id<UITextFieldDelegate>textFieldNext;

@property(nonatomic, assign) id<UITextViewDelegate>textViewNext;


@end
