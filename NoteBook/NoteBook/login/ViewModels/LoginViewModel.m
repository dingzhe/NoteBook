//
//  LoginViewModel.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "LoginViewModel.h"
#import "UIView+HUD.h"
#import "TextValidator.h"

@implementation LoginViewModel
@synthesize loginCommand = _loginCommand;

- (id) init {
    if (self = [super init]) {
        
        @weakify(self)

        RACSignal *enabeld = \
        [RACSignal combineLatest:@[
                                   RACObserve(self, phoneNumber),
                                   RACObserve(self, password)
                                   ]
                          reduce:^(NSString *phoneNumber, NSString *password){
                              return @(password.length > 0);
                          }];
        _loginCommand = [NoteBookSignService.service signInCommandEnable:enabeld];
        [_loginCommand.responses subscribeNext:^(SWGSignResponses* response) {
            @strongify(self)
            
            
            if (response.code.integerValue == 200) {
                NSString *uid = [NSString stringWithFormat:@"%@",response.data.userid];
                NSString *headimage = [NSString stringWithFormat:@"%@",response.data.headimage];
                NSString *email = [NSString stringWithFormat:@"%@",response.data.email];
                NSString *username = [NSString stringWithFormat:@"%@",response.data.username];
                [UserModel.currentUser signedOnWithUid:uid];
                [UserModel.currentUser updateHeadImage:headimage];
                [UserModel.currentUser updateEmail:email];
                [UserModel.currentUser updateUserName:username];
                [UserModel.currentUser updateProfile:response.data];
                [self showHUDMessage:@"登录成功"];
            }else{
                [self showHUDMessage:response.message];
            }
            
            
        }];
        [_loginCommand.errors subscribeNext:^(NSError *error) {
//            DDLogError(@"Error while login:%@", error);
        }];
    }
    
    return self;
}

- (void) login {
//    TextValidator *validator = [TextValidator alloc];
    //验证手机号格式
//    if (![validator valid:self.phoneNumber withType:InputValidTypePostCode]) {
//        [self showHUDMessage:validator.validErrorMessage];
//        return;
//    }
    SWGSignRequest * request = [[SWGSignRequest alloc] init];
    request.username = self.phoneNumber;
    request.password = self.password;
    [self.loginCommand execute:@[request]];
    
}

@end
