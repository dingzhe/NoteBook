//
//  ErrorHandlerManager.m
//  Vision_dal
//
//  Created by Joully on 15/7/18.
//  Copyright (c) 2015年 Joully. All rights reserved.
//

#import "ErrorHandlerManager.h"
#define BEGIN_IMP_SINGLETON(methodName, class) \
+ (class *)methodName { \
static class *instance = nil; \
static dispatch_once_t once; \
dispatch_once(&once, ^{ \

#define END_IMP_SINGLETON \
}); \
return instance; \
}
#define IMP_SINGLETON(methodName, class) \
BEGIN_IMP_SINGLETON(methodName, class) \
instance = [[self alloc] init]; \
END_IMP_SINGLETON

@implementation ErrorHandlerManager

@synthesize dalErrorHandler;

IMP_SINGLETON(manager, ErrorHandlerManager)

@end
