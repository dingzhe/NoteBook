//
//  ErrorHandlerManager.h
//  Vision_dal
//
//  Created by Joully on 15/7/18.
//  Copyright (c) 2015年 Joully. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ErrorHandler.h"
#define DEF_SINGLETON(methodName) \
+ (instancetype)methodName;
@interface ErrorHandlerManager : NSObject

@property (nonatomic, strong) ErrorHandler *dalErrorHandler;

DEF_SINGLETON(manager)

@end
