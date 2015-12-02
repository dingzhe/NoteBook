//
//  ErrorHandler.m
//  Vision_dal
//
//  Created by Joully on 15/7/18.
//  Copyright (c) 2015年 Joully. All rights reserved.
//

#import "ErrorHandler.h"

@implementation ErrorHandler

+ (instancetype) handlerWithNext:(ErrorHandler *)nextHandler {
    ErrorHandler *result = [self new];
    result.nextHandler = nextHandler;
    return result;
}

- (void) process:(NSError *)error {
    if (![self handleError:error] && self.nextHandler) {
        [self.nextHandler process:error];
    }
}

- (BOOL) handleError:(NSError *)error {
    return NO;
}

@end