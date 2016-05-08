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
        
        RACSignal *getCodeEnabeld = \
        [RACSignal combineLatest:@[
                                   RACObserve(self, phoneNumber),
                                   RACObserve(self, getVerifyCodeCountDown)
                                   ] reduce:^(NSString *phoneNumber, NSNumber *countDown){
                                       return @(phoneNumber.length == MOBILE_MAX_LENGTH && 0 == countDown.integerValue);
                                   }];
        
//        _getVerifyCodeCommand = \
//        [[VisionIdentityService service] sendSmsCommandEnable:getCodeEnabeld];
        
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
    if (![validator valid:self.phoneNumber withType:InputValidTypeMobile]) {
        [self showHUDMessage:validator.validErrorMessage];
        return;
    }
    
    if (self.verifyCode.integerValue == self.serverVerifyCode.integerValue) {
        [_nextSignal sendNext:nil];
    }else{
        [self showHUDMessage:@"验证码错误"];
    }
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
