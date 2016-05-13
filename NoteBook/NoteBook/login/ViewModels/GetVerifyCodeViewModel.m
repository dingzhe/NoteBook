//
//  GetVerifyCodeViewModel.m
//  NoteBook
//
//  Created by Mac on 16/5/8.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "GetVerifyCodeViewModel.h"
#import "TextValidator.h"

#define GET_VERIFYCODE_COOL_DOWN_SECS 60

@interface GetVerifyCodeViewModel ()

@property (nonatomic,strong)NSDate *latestGetVerifyCodeTime;
//@property (nonatomic, readonly) RACCommand *loginUpCommand;
@end

@implementation GetVerifyCodeViewModel

- (instancetype) initWithType:(GetVerifyCodeType)type {
    if (self = [super init]) {
        
        @weakify(self)
        
        _type = type;
        
        if (GetVerifyCodeTypeRegister == type) {
            _getVerifyCodeTitle = @"注册";
        }
        else if (GetVerifyCodeTypeResetPassword == type) {
            _getVerifyCodeTitle = @"设置新密码";
        }
        
        RACSignal *enabeld = \
        [RACSignal combineLatest:@[
                                   RACObserve(self, phoneNumber),
                                   RACObserve(self, getVerifyCodeCountDown)
                                   ] reduce:^(NSString *phoneNumber, NSNumber *countDown){
                                       return @(phoneNumber.length == RECEIVER_NAME_MAX_LENGTH && 0 == countDown.integerValue);
                                   }];
        
//        _getVerifyCodeCommand = \
//        [[VisionIdentityService service] sendSmsCommandEnable:getCodeEnabeld];
        _loginUpCommand = [NoteBookSignService.service signUpCommandEnable:nil];
        
        
        [_loginUpCommand.responses subscribeNext:^(SWGSignResponses* response) {
            @strongify(self)
            
            if (response.code.integerValue == 200) {
                [self showHUDMessage:@"注册成功，请前往登录"];
//                @weakify(self)
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1ull * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    @strongify(self)
                    [self.nextSignal sendNext:response];
//                    [self.navigationController popViewControllerAnimated:YES];
                });
            }
            
            
         
        }];
        [_loginUpCommand.errors subscribeNext:^(NSError *error) {
            [self showHUDMessage:@"注册失败！"];
            //            DDLogError(@"Error while get resume browse history:%@", error);
        }];
        
        
//        [_getVerifyCodeCommand.responses subscribeNext:^(SWGSendSmsResponse *response) {
//            @strongify(self)
//            self.serverVerifyCode = [NSString stringWithFormat:@"%@",response.code];
//            [self didGetVerifyCodeSuccess];
//        }];
        
        _nextSignal = [RACSubject subject];
    }
    
    return self;
}

- (void)goNext {
    
    TextValidator *validator = [TextValidator alloc];
    if (![validator valid:self.phoneNumber withType:InputValidTypeNone]) {
        [self showHUDMessage:validator.validErrorMessage];
        return;
    }
    
    SWGSignRequest * request = [[SWGSignRequest alloc] init];
    request.username = self.phoneNumber;
    request.password = self.verifyCode;
    [_loginUpCommand execute:request];
    
    
    
    
    
    
    
//    if (self.verifyCode.integerValue == self.serverVerifyCode.integerValue) {
//      [_nextSignal sendNext:nil];
//    }else{
//        [self showHUDMessage:@"验证码错误"];
//    }
}

- (void)getVerifyCode {
    
    TextValidator *validator = [TextValidator alloc];
    if (![validator valid:self.phoneNumber withType:InputValidTypeMobile]) {
        [self showHUDMessage:validator.validErrorMessage];
        return;
    }
    
//    SWGSendSmsRequest *sendSmsRequest = [[SWGSendSmsRequest alloc]init];
//    sendSmsRequest.mobile = self.phoneNumber;
//    [self.getVerifyCodeCommand execute:sendSmsRequest];
}

- (void) updateCountDown:(BOOL) forceComplete {
    NSTimeInterval pastTime = [[NSDate date] timeIntervalSinceDate:self.latestGetVerifyCodeTime];
    
    if (forceComplete || pastTime >= GET_VERIFYCODE_COOL_DOWN_SECS) {
        self.getVerifyCodeCountDown = 0;
        RAC_DISPOSABLE(self, countdownTimerDisposable) = nil;
    }else {
        self.getVerifyCodeCountDown = GET_VERIFYCODE_COOL_DOWN_SECS - pastTime;
    }
}

- (void) didGetVerifyCodeSuccess {
    _latestGetVerifyCodeTime = [NSDate date];
    
    RACScheduler *scheduler = [RACScheduler mainThreadScheduler];
    RACSignal *timerSignal = [RACSignal interval:0.1 onScheduler:[RACScheduler mainThreadScheduler]];
    RACSignal *stopSignal = [[RACSignal after:GET_VERIFYCODE_COOL_DOWN_SECS onScheduler:scheduler]
                             takeUntil: self.rac_willDeallocSignal];
    
    @weakify(self)
    
    RAC_DISPOSABLE(self, countdownTimerDisposable) = \
    [[timerSignal takeUntil:stopSignal] subscribeNext:^(id x) {
        @strongify(self)
        [self updateCountDown:NO];
    } completed:^{
        @strongify(self)
        [self updateCountDown:YES];
    }];
}

@end
