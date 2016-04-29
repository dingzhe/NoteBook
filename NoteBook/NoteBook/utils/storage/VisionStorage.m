//
//  VisionStorage.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "VisionStorage.h"
#import "VisionLog.h"
#import "ConcurrentUtils.h"

#define STORAGE_Q dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)

#pragma mark -

@implementation VisionStorage(private)

- (void) _saveObject:(id) object
            forKey:(NSString *)key
            encode:(VisionStorageEncode)encode
             async:(BOOL)async
          callback:(VisionStorageCallback)callback {

#if PRINT_DEBUG_INFO
    DDLogDebug(@"[VisionStorage] save key:%@ value:%@ async:%d", key, object, async);
#endif
    
    if (async) {
        ASYNC_BEGIN(STORAGE_Q)
        
        id data = object;
        NSError *error = nil;
        
        if (encode) {
            data = encode(object, &error);
        }
        
        if (error) {
            DDLogError(@"[VisionStorage] Error occured while saving object: %@ for key: %@ - %@", object, key, error);
        }
        else {
            [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        
        ASYNC_MAIN_BEGIN
        
#if PRINT_DEBUG_INFO
        if (!error) {
            DDLogDebug(@"[VisionStorage] async save key:%@ sucessfully", key);
        }
#endif
        
        if (callback) {
            callback(data, error);
        }
        
        ASYNC_MAIN_END
        ASYNC_END
    }
    else {
        id data = object;
        NSError *error = nil;
        
        if (encode) {
            data = encode(object, &error);
        }
        
        if (error) {
            DDLogError(@"[VisionStorage] Error occured while saving object: %@ for key: %@ - %@", object, key, error);
        }
        else {
            [NSUserDefaults.standardUserDefaults setObject:data forKey:key];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
#if PRINT_DEBUG_INFO
            DDLogDebug(@"[VisionStorage] sync save key:%@ sucessfully", key);
#endif
        }
        
        if (callback) {
            callback(data, error);
        }
    }
}


- (void) _restoreForKey:(NSString *)key
               decode:(VisionStorageDecode)decode
                async:(BOOL)async
             callback:(VisionStorageCallback)callback {
    
#if PRINT_DEBUG_INFO
    DDLogDebug(@"[VisionStorage] restore key:%@ async:%d", key, async);
#endif
    
    if (async) {
        ASYNC_BEGIN(STORAGE_Q)
        
        id data = [NSUserDefaults.standardUserDefaults objectForKey:key];
        NSError *error = nil;
        
        if (data && decode) {
            data = decode(data, &error);
        }
        
        if (error) {
            DDLogError(@"[VisionStorage] Error occured while restoring object for key: %@ - %@", key, error);
        }
        
        ASYNC_MAIN_BEGIN
        
#if PRINT_DEBUG_INFO
        if (!error) {
            DDLogDebug(@"[VisionStorage] async restore key:%@ value:%@", key, data);
        }
#endif
        
        callback(data, error);
        
        ASYNC_MAIN_END
        ASYNC_END
    }
    else{
        id data = [NSUserDefaults.standardUserDefaults objectForKey:key];
        NSError *error = nil;
        
        if (data && decode) {
            data = decode(data, &error);
        }
        
        if (error) {
            DDLogError(@"[VisionStorage] Error occured while restoring object for key: %@ - %@", key, error);
        }
       
#if PRINT_DEBUG_INFO
        if (!error) {
            DDLogDebug(@"[VisionStorage] sync restore key:%@ value:%@", key, data);
        }
#endif
        
        callback(data, error);
    }
}

@end

@implementation VisionStorage

IMP_SINGLETON(storage, VisionStorage)

- (NSError *) syncSaveObject:(id) object
                      forKey:(NSString *)key {
    return [self syncSaveObject:object forKey:key encode:nil];
}

- (id) syncRestoreObjectForKey:(NSString *)key {
    return [self syncRestoreObjectForKey:key encode:nil];
}

- (NSError *) syncSaveObject:(id) object
                      forKey:(NSString *)key
                      encode:(VisionStorageEncode)encode {
    __block NSError *result = nil;
    
    [self _saveObject:object forKey:key encode:encode async:NO callback:^(id object, NSError *error) {
        result = error;
    }];
    
    return result;
}

- (id) syncRestoreObjectForKey:(NSString *)key
                        encode:(VisionStorageDecode)decode {
    __block id result = nil;
    
    [self _restoreForKey:key decode:decode async:NO callback:^(id object, NSError *error) {
        result = error ? error : object;
    }];
    
    return result;
}

- (void) asyncSaveObject:(id) object
                  forKey:(NSString *)key
                callback:(VisionStorageCallback)callback {
    [self asyncSaveObject:object forKey:key encode:nil callback:callback];
}

- (void) asyncRestoreObjectForKey:(NSString *)key
                         callback:(VisionStorageCallback)callback {
    [self asyncRestoreObjectForKey:key encode:nil callback:callback];
}

- (void) asyncSaveObject:(id) object
                  forKey:(NSString *)key
                  encode:(VisionStorageEncode)encode
                callback:(VisionStorageCallback)callback {
    [self _saveObject:object forKey:key encode:encode async:YES callback:callback];
}

- (void) asyncRestoreObjectForKey:(NSString *)key
                           encode:(VisionStorageDecode)decode
                         callback:(VisionStorageCallback)callback {
    [self _restoreForKey:key decode:decode async:YES callback:callback];
}

- (void) removeObjectForKey:(NSString *)key
                      async:(BOOL)async {
    if (async) {
        [self asyncSaveObject:nil forKey:key callback:nil];
    }
    else {
        [self syncSaveObject:nil forKey:key];
    }
}

- (void)setObject:(id)obj forKeyedSubscript:(id)key {
    [self syncSaveObject:obj forKey:key];
}

- (id)objectForKeyedSubscript:(NSString *)key {
    return [self syncRestoreObjectForKey:key];
}

- (NSHTTPURLResponse *) cachedHTTPURLResposneForURL:(NSString *)URL {
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:URL]];
    return (NSHTTPURLResponse *) [[NSURLCache sharedURLCache] cachedResponseForRequest:request];
}

@end
