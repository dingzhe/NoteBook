//
//  UserModel.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "UserModel.h"
static NSString *UidStorageKey = @"vision.storage.usermodel.uid";
static NSString *EmailStorageKey = @"vision.storage.usermodel.email";
static NSString *HeadImageStorageKey = @"vision.storage.usermodel.headimage";
static NSString *UserNameStorageKey = @"vision.storage.usermodel.username";
static NSString *ProfileStorageKey = @"vision.storage.usermodel.profile";

@interface UserModel () {
    UserModelStatus _status;
    NSString *_uid;
    NSString *_headimage;
    NSString *_email;
    NSString *_username;
    SWGUser *_profile;
}
@end
@implementation UserModel(private)

- (void) _updateStatus:(UserModelStatus)status {
    [self willChangeValueForKey:@"status"];
    _status = status;
    [self didChangeValueForKey:@"status"];
}
- (void) _updateUid:(NSString *)uid save:(BOOL)save {
    [self willChangeValueForKey:@"uid"];
    _uid = uid;
    [self didChangeValueForKey:@"uid"];
    if (save) {
        VisionStorage.storage[UidStorageKey] = uid;
    }
}
- (void) _updateHeadImage:(NSString *)headimage {
    [self willChangeValueForKey:@"headimage"];
    _headimage = headimage;
    [self didChangeValueForKey:@"headimage"];
    VisionStorage.storage[HeadImageStorageKey] = headimage;
    
}

- (void) _updateEmail:(NSString *)email {
    [self willChangeValueForKey:@"email"];
    _email = email;
    [self didChangeValueForKey:@"email"];
    VisionStorage.storage[EmailStorageKey] = email;
}
- (void) _updateUserName:(NSString *)username {
    [self willChangeValueForKey:@"username"];
    _username = username;
    [self didChangeValueForKey:@"username"];
    VisionStorage.storage[UserNameStorageKey] = username;
}

- (void) _restoreProfile {
//    DDLogDebug(@"[UserModel] start restoring profile...");
    
    SWGUser *profile = [VisionStorage.storage syncRestoreObjectForKey:ProfileStorageKey encode:^id(NSData *data, NSError *__autoreleasing *error) {
        return [[SWGUser alloc] initWithData:data error:error];
    }];
    
    if (profile) {
//        DDLogDebug(@"[UserModel] restored profile");
        
        [self _updateProfile:profile save:NO];
    }
}

- (void) _updateProfile:(SWGUser *)profile save:(BOOL)save {
    [self willChangeValueForKey:@"profile"];
    _profile = profile;
    [self didChangeValueForKey:@"profile"];
    
    if (save) {
//        DDLogDebug(@"[UserModel] start saveing profile...");
        
        [VisionStorage.storage asyncSaveObject:profile forKey:ProfileStorageKey encode:^NSData *(SWGUser *profile, NSError *__autoreleasing *error) {
            
            if (profile) {
                return [NSJSONSerialization dataWithJSONObject:[profile toDictionary]
                                                       options:0
                                                         error:error];
            }
            return nil;
            
        } callback:^(id object, NSError *error) {
            if (error) {
//                DDLogError(@"[UserModel] Error while saving profile: %@", error);
            }
            else {
//                DDLogDebug(@"[UserModel] save profile successfully");
            }
        }];
    }
}




- (void) _init {
    
    NSString *uid = VisionStorage.storage[UidStorageKey];
    NSString *headimage = VisionStorage.storage[HeadImageStorageKey];
    NSString *email = VisionStorage.storage[EmailStorageKey];
    NSString *username = VisionStorage.storage[UserNameStorageKey];
    
//    NSLog(@"username:%@ \n email:%@",UserModel.currentUser.username,UserModel.currentUser.email);
    
    [self _updateHeadImage:headimage];
    [self _updateEmail:email];
    [self _updateUserName:username];
    if ([uid isNotEmpty]) {
        [self _updateStatus:UserModelSignedOn];
        [self _updateUid:uid save:NO];
    }else{
        [self _updateStatus:UserModelIdle];
    }
}


@end

@implementation UserModel
@synthesize status = _status;
@synthesize uid = _uid;
@synthesize headimage = _headimage;
@synthesize email = _email;
@synthesize username = _username;
@synthesize profile = _profile;
BEGIN_IMP_SINGLETON(currentUser, UserModel)
instance = [[self alloc] init];

[instance _init];
END_IMP_SINGLETON
- (void) signedOnWithUid:(NSString *)uid {
    
    NSAssert(uid, @"uid must not be nil before signed on");
    
    if (!uid) {
        return;
    }
    
    [self _updateUid:uid save:YES];
    [self _updateStatus:UserModelSignedOn];
    
}
- (void) signout {
    [self _updateUid:nil save:YES];
    
    [self _updateStatus:UserModelIdle];
    [self _updateHeadImage:nil];
    [self _updateEmail:nil];
    [self _updateUserName:nil];
}

- (void) updateProfile:(SWGUser *)profile {
    if (UserModelSignedOn != self.status) {
//        DDLogError(@"user status has not be signed on while updating user profile");
        return;
    }
    
    [self _updateProfile:profile save:YES];
}


- (void) updateHeadImage:(NSString *)headimage{
    [self _updateHeadImage:headimage];
}

- (void) updateEmail:(NSString *)email{
    [self _updateEmail:email];
}
- (void) updateUserName:(NSString *)username{
    [self _updateUserName:username];
}
@end
