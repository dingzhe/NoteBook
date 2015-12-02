//
//  ErrorHandler.h
//  Vision_dal
//
//  Created by Joully on 15/7/18.
//  Copyright (c) 2015年 Joully. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ErrorHandler : NSObject

@property (nonatomic, strong) ErrorHandler *nextHandler;

+ (instancetype) handlerWithNext:(ErrorHandler *)nextHandler;

- (void) process:(NSError *)error;

- (BOOL) handleError:(NSError *)error;

@end