//
//  GetVerifyCodeViewModel.h
//  NoteBook
//
//  Created by Mac on 16/5/8.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "ViewModel.h"

typedef NS_ENUM(NSInteger, GetVerifyCodeType) {
    GetVerifyCodeTypeRegister = 1,
    GetVerifyCodeTypeResetPassword = 2,
};

@interface GetVerifyCodeViewModel : ViewModel

@property (nonatomic,assign,readonly) GetVerifyCodeType type;
@property (nonatomic,strong,readonly) NSString *getVerifyCodeTitle;
@property (nonatomic,strong) NSString *phoneNumber;
@property (nonatomic,strong) NSString *verifyCode;
@property (nonatomic,strong) NSString *serverVerifyCode;
@property (nonatomic,assign) NSInteger getVerifyCodeCountDown;
@property (nonatomic,strong,readonly) RACCommand *getVerifyCodeCommand;
@property (nonatomic,strong,readonly) RACSubject *nextSignal;

- (instancetype) initWithType:(GetVerifyCodeType)type;

- (void)getVerifyCode;
- (void)goNext;


@end
