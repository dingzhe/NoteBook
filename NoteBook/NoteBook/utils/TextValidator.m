//
//  TextValidator.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "TextValidator.h"
#import <UIKit/UIKit.h>

static NSString* MobileRegular = @"^\\d{11}$";

static NSString* PasswordRegular = @"^([0-9a-zA-Z.,?!:/@\";'~()<>*&\\[\\]\\\\#$%^_+-={}|\\u20ac\\u00a3\\u00a5\\u2022]){6,32}$";

static NSString* SMSCodeRegular = @"^\\d{6}$";

static NSString* RemarkRegular = @"^*{0,200}$";

// ，。？！：、＠…“”；‘’～（）《》〈〉〔〕*&［］【】—｀#￥%·+-=｛｝．｜∶＇＂〃
static NSString* NickRegular
= @"^([\\s\\dA-Za-z\\u4e00-\\u9fa5]|[.,?!:/@\";'~()<>*&\\[\\]\\\\#$%^_+-={}|\\u20ac\\u00a3\\u00a5\\u2022]|[，。？！：、＠…“”；‘’～（）《》〈〉〔〕*\\uff06\\uff3b\\uff3d\\u3010\\u3011—｀#￥%·+-=｛｝．｜∶＇＂〃]){1,12}$";

static NSString* PostCodeRegular = @"^\\d{6}$";

// ，。、／：；“”＃@&（）*—-
//static NSString* ReceiverAddressRegular
//    = @"^([\\s\\dA-Za-z\\u4e00-\\u9fa5]|[，。、／：；“”＃@&（）*—-]|[.,:/@\";'()*&\\\\#_-]){1,100}$";
static NSString* ReceiverAddressRegular = @"^.+$";

static NSString* ReceiverNameRegular
= @"^([A-Za-z\\u4e00-\\u9fa5]){1,60}$";

static NSString* ReceiverCityRegular = @"^.{1,200}$";

static NSString* IdentityNameRegular = @"^([\\u4e00-\\u9fa5]){1,60}$";

#define REGULAR_VALIDATE(reg, str) \
[[NSPredicate predicateWithFormat:@"SELF MATCHES %@", reg] evaluateWithObject:str]

@implementation TextValidator

- (BOOL) valid:(NSString *)string
      withType:(InputValidType)validType {
    
    switch (validType) {
        case InputValidTypeMobile:
            return [self _valid:string byReg:MobileRegular errorMessage:@"请输入正确的手机号"];
        case InputValidTypePassword:
            return [self _valid:string byReg:PasswordRegular errorMessage:@"密码格式不合规范\n请输入6~12位密码\n且不要使用中文与特殊符号"];
        case InputValidTypeSMSCode:
            return [self _valid:string byReg:SMSCodeRegular errorMessage:@"请输入正确的验证码"];
        case InputValidTypeRemark:
            return [self _valid:string byReg:RemarkRegular errorMessage:@"您输入的备注格式不正确"];
        case InputValidTypeNick:
            return [self _valid:string byReg:NickRegular errorMessage:@"用户名不支持您输入的符号"];
        case InputValidTypePostCode:
            return [self _valid:string byReg:PostCodeRegular errorMessage:@"请输入正确的邮编"];
        case InputValidTypeAddress:
            if ([string isNotEmpty]) {
                return [self _valid:string byReg:ReceiverAddressRegular errorMessage:@"地址仅支持部分中英文符号，您输入的符号不支持"];
            } else {
                self.validErrorMessage = @"请输入您的收货地址";
                return NO;
            }
        case InputValidTypeConsignee:
            return [self _valid:string byReg:ReceiverNameRegular errorMessage:@"请输入您的姓名，不要包含符号"];
        case InputValidTypeReceiverCity:
            return [self _valid:string byReg:ReceiverCityRegular errorMessage:@"请选择您的收货城市"];
        case InputValidTypeIdentityID:
            return [self _validID:string errorMessage:@"您的身份证信息有误，请确认"];
        case InputValidTypeIdentityName:
            return [self _valid:string byReg:IdentityNameRegular errorMessage:@"请输入中文姓名"];
        case InputValidTypeNone:
        default:
            return YES;
    }
}

- (BOOL) _valid:(NSString*) string
          byReg:(NSString*) reg
   errorMessage:(NSString*) msg {
    BOOL result=YES;
    if (!REGULAR_VALIDATE(reg, string)) {
        result = NO;
        self.validErrorMessage = msg;
    }
    return result;
}

- (BOOL) _validID:(NSString*) string
     errorMessage:(NSString*) msg {
    if (IDENTITY_ID_MAX_LENGTH != string.length) {
        self.validErrorMessage = msg;
        return NO;
    }
    NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789xX"];
    
    if (NSNotFound != [string rangeOfCharacterFromSet:[characterSet invertedSet]].location
        || ![self _validDate:[string substringWithRange:NSMakeRange(6, 8)] withFormat:@"yyyyMMdd"]
        || ![self _checkIDSum:string]) {
        self.validErrorMessage = msg;
        return NO;
    } else {
        return YES;
    }
}

- (BOOL) _validDate:(NSString*) string
         withFormat:(NSString*) format {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    return nil != [formatter dateFromString:string];
}

- (BOOL) _checkIDSum:(NSString*) string {
    NSString *idPre = [string substringToIndex:17];
    NSString *sum = [string substringFromIndex:17];
    
    NSArray *power = @[@(7), @(9), @(10), @(5), @(8), @(4), @(2), @(1), @(6), @(3), @(7), @(9), @(10), @(5), @(8), @(4), @(2)];
    NSArray *verifyCode = @[@"1", @"0", @"X", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    __block NSInteger checkSum = 0;
    [power enumerateObjectsUsingBlock:^(NSNumber* p, NSUInteger idx, BOOL *stop) {
        checkSum += ([idPre characterAtIndex:idx] - 48) * p.integerValue;
    }];
    
    return NSOrderedSame == [sum compare:[verifyCode objectAtIndex:checkSum % 11] options:NSCaseInsensitiveSearch];
}
@end
