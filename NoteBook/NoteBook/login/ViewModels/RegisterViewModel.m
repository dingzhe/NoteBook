//
//  RegisterViewModel.m
//  NoteBook
//
//  Created by Mac on 16/5/8.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "RegisterViewModel.h"
#import "TextValidator.h"

@interface RegisterViewModel ()

@end

@implementation RegisterViewModel

- (id) init {
    if (self = [super initWithType:GetVerifyCodeTypeRegister]) {
        
        @weakify(self)
        
        RACSignal *enabeld = \
        [RACSignal combineLatest:@[
                                   RACObserve(self, phoneNumber),
                                   RACObserve(self, password)
                                   ]
                          reduce:^(NSString *phoneNumber, NSString *password){
                              return @(phoneNumber.length == MOBILE_MAX_LENGTH && password.length > 0);
                          }];
        
        _registerCommand = [NoteBookSignService.service signUpCommandEnable:enabeld];
        [_registerCommand.responses subscribeNext:^(SWGSignResponses *response){
            @strongify(self)
            [self showHUDMessage:@"注册成功，请前往登录"];
        }];
    }
    
    return self;
}

- (void)goRegister {
    
    TextValidator *validator = [TextValidator alloc];
    if (![validator valid:self.phoneNumber withType:InputValidTypeMobile]) {
        [self showHUDMessage:validator.validErrorMessage];
        return;
    } else if (![validator valid:self.password withType:InputValidTypePassword]) {
        [self showHUDMessage:validator.validErrorMessage];
        return;
    }
    
    SWGSignRequest *regRequest = [[SWGSignRequest alloc]init];
    regRequest.username = self.phoneNumber;
    regRequest.password = self.password;
    [_registerCommand execute:regRequest];
}

@end
