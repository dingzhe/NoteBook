//
//  FeedbackViewController.m
//  NoteBook
//
//  Created by Mac on 16/5/13.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "FeedbackViewController.h"
#import "CommonTextField.h"
#import "Masonry.h"


@interface FeedbackViewController ()

@property (nonatomic, strong)UIButton *sendBtn;
@property (nonatomic, strong)UITextField *emailTextField;
@property (nonatomic, strong)UITextView *textView;
@end



@implementation FeedbackViewController

- (void) viewDidLoad{
    self.title = @"反馈";
//    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    
    [self.view addGestureRecognizer:singleTap];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectZero];
//    [textView setEditable:NO];
    
    _textView.layer.backgroundColor = [[UIColor clearColor] CGColor];
    
    _textView.layer.borderColor = [[UIColor colorWithRed:230.0/255.0 green:250.0/255.0 blue:250.0/255.0 alpha:1.0]CGColor];
    
    _textView.layer.borderWidth = 3.0;
    
    _textView.layer.cornerRadius = 8.0f;
    
    [_textView.layer setMasksToBounds:YES];
    
    
    
    
//    [textView setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:_textView];
    [_textView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_top).offset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.view.bounds.size.width - 40,120));
    }];

    
    
    _emailTextField = [[UITextField alloc]initWithFrame:CGRectZero];
    [_emailTextField setBorderStyle:UITextBorderStyleLine];
    _emailTextField.placeholder = @"   邮箱";
    [self.view addSubview:_emailTextField];
    [_emailTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_textView.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.view.bounds.size.width - 40,50));
    }];

    
    
    _sendBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [_sendBtn.titleLabel setFont:[UIFont boldLargeFont]];
    [_sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_sendBtn setBackgroundImage:[UIImage greenBtnNormalImage] forState:UIControlStateNormal];
    [_sendBtn setBackgroundImage:[UIImage greenBtnDisableImage] forState:UIControlStateDisabled];
    [_sendBtn addTarget:self action:@selector(sentMessage) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:_sendBtn];
    [_sendBtn mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_emailTextField.mas_bottom).offset(20);
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.size.mas_equalTo(CGSizeMake(self.view.bounds.size.width - 40,40));
    }];
}
- (void)sentMessage{
    
    
    if ([_textView.text isEqualToString:@""] || [_emailTextField.text isEqualToString:@""]) {
        [self.view  showHUDWithText:nil detailText:@"请输入正确信息" autoDismiss:YES];
    }else{
        [self.view  showHUDWithText:nil detailText:@"发送成功！" autoDismiss:YES];
        @weakify(self)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2ull * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            @strongify(self)
            [self.navigationController popViewControllerAnimated:YES];
        });
    }
}

-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}

@end
