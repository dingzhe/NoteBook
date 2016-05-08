//
//  GetVerifyCodeViewController.m
//  NoteBook
//
//  Created by Mac on 16/5/8.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "GetVerifyCodeViewController.h"
#import "UIViewController+DzNote.h"
#import "Masonry.h"
#import "TextValidator.h"
#import "UIView+HUD.h"
#import "CommonTextField.h"
#import "UIImage+DzNote.h"
#import "NSAttributedString+Ext.h"
#import "NSMutableAttributedString+Ext.h"

#import "WebViewController+Factory.h"

@interface GetVerifyCodeViewController ()

@property (nonatomic,strong) CommonTextField *phoneNumberTextField;
@property (nonatomic,strong) CommonTextField *verifyCodeTextField;
@property (nonatomic,strong) UIButton *nextButton;
@property (nonatomic,strong) UIButton *verifyCodeButton;
@property (nonatomic,strong) UIButton *agreeProtocolButton;
@property (nonatomic,strong) UILabel *agreeTextLab;
@property (nonatomic,strong) UIButton *protocolWebButton;

@end

@implementation GetVerifyCodeViewController

- (instancetype) initWithViewModel:(GetVerifyCodeViewModel *)viewModel {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _viewModel = viewModel;
        
        [[_viewModel.showHUDSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString* message) {
            [self.view showHUDWithText:nil detailText:message autoDismiss:YES];
        }];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.viewModel.getVerifyCodeTitle;
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupKeyboardAutoScrollable];
    
    self.phoneNumberTextField = [[CommonTextField alloc]initWithFrame:CGRectZero];
    _phoneNumberTextField.placeholder = @"请输入您的邮箱";
    self.phoneNumberTextField.maxLength = MOBILE_MAX_LENGTH;
    [self.scrollView addSubview:_phoneNumberTextField];
    
    self.verifyCodeTextField = [[CommonTextField alloc]initWithFrame:CGRectZero];
    _verifyCodeTextField.placeholder = @"请输入密码";
    [self.scrollView addSubview:_verifyCodeTextField];
    
    self.nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_nextButton setTitle:@"注册" forState:UIControlStateNormal];
    [_nextButton.titleLabel setFont:[UIFont largeFont]];
    [_nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_nextButton setBackgroundImage:[UIImage greenBtnNormalImage] forState:UIControlStateNormal];
    [_nextButton setBackgroundImage:[UIImage greenBtnDisableImage] forState:UIControlStateDisabled];
    [self.scrollView addSubview:_nextButton];
    
    self.verifyCodeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_verifyCodeButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [_verifyCodeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_verifyCodeButton.titleLabel setFont:[UIFont largeFont]];
    [_verifyCodeButton setBackgroundImage:[UIImage greenBtnNormalImage] forState:UIControlStateNormal];
    [_verifyCodeButton setBackgroundImage:[UIImage greenBtnDisableImage] forState:UIControlStateDisabled];
//    [self.scrollView addSubview:_verifyCodeButton];
    
    
    
    
    self.agreeProtocolButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NSAttributedString *protocolTextStr  = [NSAttributedString string:@"  我已阅读并同意" block:^(NSMutableAttributedString *mutableAttributedString, NSString *orignalString, NSRange range) {
        [mutableAttributedString replaceFont:[UIFont middleFontLarge] inRange:range];
        [mutableAttributedString replaceColor:[UIColor lightGrayTextColor] inRange:range];
    }];
    [_agreeProtocolButton setAttributedTitle:protocolTextStr forState:UIControlStateNormal];
    [_agreeProtocolButton setImage:[UIImage imageNamed:@"check_01"]forState:UIControlStateNormal];
    [_agreeProtocolButton setImage:[UIImage imageNamed:@"check_02"]forState:UIControlStateSelected];
    [_agreeProtocolButton setImage:[UIImage imageNamed:@"check_02"]forState:UIControlStateHighlighted];
    [_agreeProtocolButton addTarget:self action:@selector(isSelected) forControlEvents:UIControlEventTouchDown];
    
    
    
    _agreeProtocolButton.selected = YES;
    [self.scrollView addSubview:_agreeProtocolButton];
    
    self.protocolWebButton = [UIButton buttonWithType:UIButtonTypeCustom];
    NSAttributedString *protocolWebStr  = [NSAttributedString string:@"记着用户协议" block:^(NSMutableAttributedString *mutableAttributedString, NSString *orignalString, NSRange range) {
        [mutableAttributedString replaceFont:[UIFont middleFontLarge] inRange:range];
        [mutableAttributedString replaceColor:[UIColor vsBlueColor] inRange:range];
    }];
    [_protocolWebButton setAttributedTitle:protocolWebStr forState:UIControlStateNormal];
    [_protocolWebButton.titleLabel setFont:[UIFont largeFont]];
    [_protocolWebButton addTarget:self action:@selector(openWebVc) forControlEvents:UIControlEventTouchDown];
    [self.scrollView addSubview:_protocolWebButton];
    
    
    CGFloat maxWidth = self.view.bounds.size.width-50;
    _verifyCodeButton.frame = CGRectMake(self.view.bounds.size.width-25-90, 33, 90, 42);
    _phoneNumberTextField.frame = CGRectMake(25, 33, maxWidth, 43);
    _verifyCodeTextField.frame = CGRectMake(25, CGRectGetMaxY(_phoneNumberTextField.frame)+8, maxWidth, 43);
    _nextButton.frame = CGRectMake(25, CGRectGetMaxY(_verifyCodeTextField.frame)+13, maxWidth, 43);
    _agreeProtocolButton.frame = CGRectMake(self.view.bounds.size.width / 2 - 110, CGRectGetMaxY(_nextButton.frame) + 13, 120, 25);
    _protocolWebButton.frame = CGRectMake(self.view.bounds.size.width / 2, CGRectGetMaxY(_nextButton.frame) + 13, 90, 25);
    [self setupBindings];
}
- (void)isSelected
{
    _agreeProtocolButton.selected = _agreeProtocolButton.selected ? NO : YES;
}
- (void)openWebVc
{
//    WebViewController *detailVC = [WebViewController protocolController];
//    [self.navigationController pushViewController:detailVC animated:YES];
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.viewModel.serverVerifyCode = @"";
}

- (void) setupBindings {
    @weakify(self)
    
    RAC(_viewModel, phoneNumber) = self.phoneNumberTextField.rac_textSignal;
    RAC(_viewModel, verifyCode) = self.verifyCodeTextField.rac_textSignal;
    
    [[RACObserve(_viewModel, getVerifyCodeCountDown) takeUntil:self.rac_willDeallocSignal]
     subscribeNext:^(NSNumber *num) {
         @strongify(self)
         NSString *text = [self.verifyCodeButton titleForState:UIControlStateNormal];
         if (0 != num.integerValue) {
             text = [NSString stringWithFormat:@"重新获取(%d)", (int)num.integerValue];
         }
         [UIView setAnimationsEnabled:NO];
         [self.verifyCodeButton setTitle:text forState:UIControlStateDisabled];
         [UIView setAnimationsEnabled:YES];
     }];
    
    [[_viewModel.showHUDSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString* message) {
        @strongify(self)
        [self.view showHUDWithText:nil detailText:message autoDismiss:YES];
    }];
    
    [self.verifyCodeButton setEnabled:self.viewModel.getVerifyCodeCommand.enabled
                          actionBlock:^(UIButton *sender) {
                              @strongify(self)
                              [self.view endEditing:YES];
                              [self.viewModel getVerifyCode];
                          }];
    
    RACSignal *enabeld = \
    [RACSignal combineLatest:@[self.verifyCodeTextField.rac_textSignal,RACObserve(self.agreeProtocolButton,selected)]
                      reduce:^(NSString *verifyCode,NSNumber *loggingIn){
                          return @(verifyCode.length > 0 && loggingIn.boolValue);
                      }];
    
    [self.nextButton setEnabled:enabeld actionBlock:^(UIButton *sender) {
        @strongify(self)
        [self.view endEditing:YES];
        [self.viewModel goNext];
    }];
    
    [self.view bindHUDWithExecuting:self.viewModel.getVerifyCodeCommand.executing];
}


@end
