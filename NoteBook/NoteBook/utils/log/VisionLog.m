//
//  VisionLog.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "VisionLog.h"

@implementation VisionLog

+ (void)initialize {
    [super initialize];
    
    static dispatch_once_t once;
    dispatch_once(&once, ^(){
        
        // use TTY logger for all builds
        [self addLogger:[DDTTYLogger sharedInstance]];
        [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
        
    });
}

@end
