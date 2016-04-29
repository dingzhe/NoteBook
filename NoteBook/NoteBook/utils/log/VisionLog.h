//
//  VisionLog.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CocoaLumberjack.h"

#ifndef _VisionLogManager_h
#define _VisionLogManager_h

// set default log level
#ifdef DEBUG
static DDLogLevel ddLogLevel = DDLogLevelVerbose;
#else
static DDLogLevel ddLogLevel = DDLogLevelWarning;
#endif

#define ENABLE_CLASS_DYNAMIC_LOG_LEVEL \
+ (DDLogLevel)ddLogLevel { \
    return ddLogLevel; \
} \
+ (void)ddSetLogLevel:(DDLogLevel)logLevel { \
    ddLogLevel = logLevel; \
}

@interface VisionLog : DDLog

+ (void)initialize;

@end

#endif
