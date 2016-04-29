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
DEF_SINGLETON(currentUser)

- (void) signedOnWithUid:(NSString *)uid;
- (void) signout;

@end
