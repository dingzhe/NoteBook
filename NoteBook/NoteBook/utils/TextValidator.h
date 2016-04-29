//
//  TextValidator.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    InputValidTypeNone,
    InputValidTypeMobile,
    InputValidTypePassword,
    InputValidTypeSMSCode,
    InputValidTypeRemark,
    InputValidTypeNick,
    InputValidTypePostCode,
    InputValidTypeAddress,
    InputValidTypeReceiverCity,
    InputValidTypeConsignee,
    InputValidTypeIdentityID,
    InputValidTypeIdentityName
}InputValidType;

#define PASSWORD_MAX_LENGTH 32
#define PASSWORD_MIN_LENGTH 6
#define MOBILE_MAX_LENGTH 11
#define SMS_CODE_MAX_LENGTH 6
#define POST_CODE_MAX_LENGTH 6
#define REMARK_MAX_LENGTH 200
#define NICK_MAX_LENGTH 12
#define RECEIVER_NAME_MAX_LENGTH 60
//#define RECEIVER_ADDRESS_MAX_LENGTH 100
#define IDENTITY_ID_MAX_LENGTH 18
#define IDENTITY_NAME_MAX_LENGTH 60

@interface TextValidator : NSObject

- (BOOL) valid:(NSString*) string
      withType:(InputValidType) validType;

@property (nonatomic,strong) NSString* validErrorMessage;

@end
