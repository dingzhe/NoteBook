//
//  VisionStorage.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>

#define PRINT_DEBUG_INFO 0

typedef void(^VisionStorageCallback)(id object, NSError *error);
typedef NSData *(^VisionStorageEncode)(id obj, __autoreleasing NSError **error);
typedef id(^VisionStorageDecode)(NSData *data, __autoreleasing NSError **error);

@interface VisionStorage : NSObject

DEF_SINGLETON(storage)

- (NSError *) syncSaveObject:(id) object
                      forKey:(NSString *)key;
- (id) syncRestoreObjectForKey:(NSString *)key;

- (NSError *) syncSaveObject:(id) object
                      forKey:(NSString *)key
                      encode:(VisionStorageEncode)encode;
- (id) syncRestoreObjectForKey:(NSString *)key
                        encode:(VisionStorageDecode)decode;

- (void) asyncSaveObject:(id) object
                  forKey:(NSString *)key
                callback:(VisionStorageCallback)callback;
- (void) asyncRestoreObjectForKey:(NSString *)key
                         callback:(VisionStorageCallback)callback;

- (void) asyncSaveObject:(id) object
                  forKey:(NSString *)key
                  encode:(VisionStorageEncode)encode
                callback:(VisionStorageCallback)callback;
- (void) asyncRestoreObjectForKey:(NSString *)key
                           encode:(VisionStorageDecode)decode
                         callback:(VisionStorageCallback)callback;

- (void) removeObjectForKey:(NSString *)key
                      async:(BOOL)async;

// handy methods to save/restore syncronizedlly.
- (void)setObject:(id)obj forKeyedSubscript:(id)key;
- (id)objectForKeyedSubscript:(NSString *)key;

- (NSURLResponse *) cachedHTTPURLResposneForURL:(NSString *)URL;

@end
