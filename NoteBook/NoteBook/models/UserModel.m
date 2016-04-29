//
//  UserModel.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "UserModel.h"
static NSString *UidStorageKey = @"vision.storage.usermodel.uid";
@interface UserModel () {
    UserModelStatus _status;
    NSString *_uid;
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
- (void) _init {
    
    NSString *uid = VisionStorage.storage[UidStorageKey];
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
}
@end
