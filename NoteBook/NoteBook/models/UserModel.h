//
//  UserModel.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, UserModelStatus) {
    UserModelIdle,
    UserModelSignedOn
};

@interface UserModel : NSObject
@property (nonatomic, readonly) UserModelStatus status;
@property (nonatomic, readonly) NSString *uid;
@property (nonatomic, readonly) NSString *email;
@property (nonatomic, readonly) NSString *username;
@property (nonatomic, readonly) NSString *headimage;
@property (nonatomic, readonly) SWGUser *profile;

DEF_SINGLETON(currentUser)

- (void) signedOnWithUid:(NSString *)uid;
- (void) signout;
- (void) updateProfile:(SWGUser *)profile;
- (void) updateHeadImage:(NSString *)headimage;
- (void) updateEmail:(NSString *)email;
- (void) updateUserName:(NSString *)username;
@end
