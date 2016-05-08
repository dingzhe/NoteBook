//
//  RegisterViewController.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "RegisterViewController.h"
#import "CommonTextField.h"
#import "UIViewController+DzNote.h"
#import "Masonry.h"
#import "UIImage+DzNote.h"
#import "TextValidator.h"

@interface RegisterViewController ()

@property (nonatomic,strong) CommonTextField *passwordTextField;
@property (nonatomic,strong) UIButton *registerButton;

@end

@implementation RegisterViewController

+ (instancetype) viewController {
    RegisterViewModel *viewmodel = [[RegisterViewModel alloc]init];
    return [[self alloc] initWithModel:viewmodel];
}

- (instancetype) initWithModel:(RegisterViewModel *)viewModel {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _viewModel = viewModel;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"注册";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupKeyboardAutoScrollable];
    
    self.passwordTextField = [[CommonTextField alloc]initWithFrame:CGRectZero];
    _passwordTextField.placeholder = @"请设置6~12位密码";
    _passwordTextField.secureTextEntry = YES;
    [self.scrollView addSubview:_passwordTextField];
    
    self.registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_registerButton setBackgroundColor:[UIColor greenColor]];
    [_registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [_registerButton.titleLabel setFont:[UIFont largeFont]];
    [_registerButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_registerButton setBackgroundImage:[UIImage greenBtnNormalImage] forState:UIControlStateNormal];
    [_registerButton setBackgroundImage:[UIImage greenBtnDisableImage] forState:UIControlStateDisabled];
    [self.scrollView addSubview:_registerButton];
    
    CGFloat maxWidth = self.view.bounds.size.width-50;
    _passwordTextField.frame = CGRectMake(25, 33, maxWidth, 43);
    _registerButton.frame = CGRectMake(25, CGRectGetMaxY(_passwordTextField.frame)+13,maxWidth, 42);
    
    [self setupBindings];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) setupBindings {
    
    @weakify(self)
    
    RAC_ONCE(_viewModel, password) = self.passwordTextField.rac_textSignal;
    
    self.registerButton.rac_command = \
    [RACCommand commandWithEnabled:_viewModel.registerCommand.enabled
                             block:^(id input) {
                                 @strongify(self)
                                 [self.view endEditing:YES];
                                 [self.viewModel goRegister];
                             }];
    
    [[_viewModel.showHUDSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString* message) {
        @strongify(self)
        [self.view showHUDWithText:nil detailText:message autoDismiss:YES];
    }];
    
    [self.view bindHUDWithExecuting:_viewModel.registerCommand.executing];
}

@end
