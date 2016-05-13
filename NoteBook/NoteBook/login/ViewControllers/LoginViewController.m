//
//  LoginViewController.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "LoginViewController.h"
#import "CommonTextField.h"
#import <Masonry.h>
#import "LoginViewModel.h"
#import "UIImage+DzNote.h"
#import "UINavigationController+DzNote.h"
#import "TextValidator.h"
#import "RegisterViewController.h"
#import "GetVerifyCodeViewController.h"

@interface LoginViewController() {
    RACSubject *_cancelSignal;
}
@property (nonatomic,strong) CommonTextField *phoneNumberTextField;
@property (nonatomic,strong) CommonTextField *passwordTextField;
@property (nonatomic,strong) UIButton *loginButton;
@property (nonatomic,strong) UIButton *forgetPasswordButton;
@property (nonatomic,strong) LoginViewModel *loginViewModel;
@end

@implementation LoginViewController
- (void) dimissAnimated:(BOOL)animated {
    [self.view endEditing:YES];
    if (!self.presentingViewController) {
        return;
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (instancetype) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        _loginViewModel = [[LoginViewModel alloc]init];
        _cancelSignal = [RACSubject subject];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"登录";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self setupNavigationBar];
    [self setupKeyboardAutoScrollable];
    
    self.phoneNumberTextField = [[CommonTextField alloc]initWithFrame:CGRectZero];
    _phoneNumberTextField.placeholder = @"用户名";
    [self.scrollView addSubview:_phoneNumberTextField];
    
    self.passwordTextField = [[CommonTextField alloc]initWithFrame:CGRectZero];
    _passwordTextField.placeholder = @"密码";
    _passwordTextField.secureTextEntry = YES;
    [self.scrollView addSubview:_passwordTextField];
    
    self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
    [_loginButton.titleLabel setFont:[UIFont largeFont]];
    [_loginButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:[UIImage greenBtnNormalImage] forState:UIControlStateNormal];
    [_loginButton setBackgroundImage:[UIImage greenBtnDisableImage] forState:UIControlStateDisabled];
    [self.scrollView addSubview:_loginButton];
    
    self.forgetPasswordButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_forgetPasswordButton setBackgroundColor:[UIColor clearColor]];
    [_forgetPasswordButton.titleLabel setFont:[UIFont middleFontLarge]];
    [_forgetPasswordButton setTitle:@"忘记密码" forState:UIControlStateNormal];
    [_forgetPasswordButton setTitleColor:[UIColor vsBlueColor] forState:UIControlStateNormal];
    [self.scrollView addSubview:_forgetPasswordButton];
    
    CGFloat maxWidth = self.view.bounds.size.width-50;
    
    _phoneNumberTextField.frame = CGRectMake(25, 33, maxWidth, 43);
    _passwordTextField.frame = CGRectMake(25, CGRectGetMaxY(_phoneNumberTextField.frame)+8, maxWidth, 43);
    _loginButton.frame = CGRectMake(25, CGRectGetMaxY(_passwordTextField.frame)+13, maxWidth, 42);
    _forgetPasswordButton.frame = CGRectMake(self.view.bounds.size.width-25-50, CGRectGetMaxY(_loginButton.frame)+12, 50, 14);
    self.view.userInteractionEnabled = YES;
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(fingerTapped:)];
    [self.view addGestureRecognizer:singleTap];
    [self setupBindings];
}
-(void)fingerTapped:(UITapGestureRecognizer *)gestureRecognizer
{
    [self.view endEditing:YES];
}
- (void) setupBindings {
    @weakify(self)
    
    RAC(_loginViewModel, phoneNumber) = self.phoneNumberTextField.rac_textSignal;
    RAC(_loginViewModel, password) = self.passwordTextField.rac_textSignal;
    
    [[_loginViewModel.showHUDSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString* message) {
        @strongify(self)
//        [[MessageManagerViewModel sharedViewModel] getMessageCount];
//        [[ProfileViewModel sharedViewModel] reload];
        [self.view showHUDWithText:nil detailText:message autoDismiss:YES];
        
    }];
    
    self.phoneNumberTextField.maxLength = MOBILE_MAX_LENGTH;
    
    [self.loginButton setEnabled:self.loginViewModel.loginCommand.enabled
                     actionBlock:^(UIButton *sender) {
                         @strongify(self)
                         [self.view endEditing:YES];
                         [self.loginViewModel login];
                     }];
    
    [self.forgetPasswordButton setEnabled:[_loginViewModel.loginCommand.executing not]
                              actionBlock:^(UIButton *sender) {
                                  @strongify(self)
                                  [self.view endEditing:YES];
                                  [self goResetPassword];
                              }];
    
    RAC_ONCE(self.navigationItem.rightBarButtonItem, enabled) = [self.loginViewModel.loginCommand.executing not];
    
    [_loginViewModel.loginCommand.responses subscribeNext:^(id _) {
        @strongify(self)
        [self dimissAnimated:YES];
    }];
    
    [self.view bindHUDWithExecuting:_loginViewModel.loginCommand.executing];
}

- (void) navBackBarButtonDidClick {
    [self -> _cancelSignal sendCompleted];
}

- (void)setupNavigationBar {
    
    UIBarButtonItem *testAPI = [[UIBarButtonItem alloc] initWithTitle:@"注册"
                                                                style:UIBarButtonItemStylePlain
                                                               target:self
                                                               action:@selector(goRegister)];
    UIBarButtonItem *appearance = [UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil];
    NSDictionary *textAttributes = @{NSFontAttributeName:[UIFont middleFont]};
    [appearance setTitleTextAttributes:textAttributes forState:0];
    self.navigationItem.rightBarButtonItem = testAPI;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showAnimated:(BOOL) showAnimated {
    [UIViewController.rootViewController showModalViewController:self
                                    wrapWithNavigationController:YES
                                                        animated:YES];
}

- (void)goRegister {
    
    [self setEditing:NO];
    
    @weakify(self)
    
    GetVerifyCodeViewModel *registerVM = [[GetVerifyCodeViewModel alloc] initWithType:GetVerifyCodeTypeRegister];
//    RegisterViewController *registerVC = [[RegisterViewController alloc] initWithModel:registerVM];
//    [self.navigationController pushViewController:registerVC animated:YES];
    
    
    // show register view controller after getting verify code
    [registerVM.nextSignal subscribeNext:^(id x) {
        @strongify(self)
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    
//     after register successfully
//    [registerVM.loginUpCommand.responses subscribeNext:^(id _) {
//        @strongify(self)
//        
//        
//
//    }];
    
    GetVerifyCodeViewController *getCodeVC = [[GetVerifyCodeViewController alloc] initWithViewModel:registerVM];
    [self.navigationController pushViewController:getCodeVC animated:YES];
}

- (void)goResetPassword {
    
    [self setEditing:NO];
    
    @weakify(self)
    
//    ResetPasswordViewModel *resetPasswordVM = [[ResetPasswordViewModel alloc] init];
//    
//    [resetPasswordVM.nextSignal subscribeNext:^(id x) {
//        @strongify(self)
//        if ([self.navigationController hasPushedViewControllerWithClass:RegisterViewController.class]) {
//            return;
//        }
//        ResetPasswordViewController *registerVC = [[ResetPasswordViewController alloc] initWithModel:resetPasswordVM];
//        [self.navigationController pushViewController:registerVC animated:YES];
//    }];
//    
//    [resetPasswordVM.resetPassowrdCommand.responses subscribeNext:^(id _) {
//        @strongify(self)
//        [self.navigationController popToRootViewControllerAnimated:YES];
//    }];
//    
//    GetVerifyCodeViewController *getCodeVC = [[GetVerifyCodeViewController alloc] initWithViewModel:resetPasswordVM];
//    [self.navigationController pushViewController:getCodeVC animated:YES];
}





@end
