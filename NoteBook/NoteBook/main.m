//
//  main.m
//  NoteBook
//
//  Created by dz on 15/11/20.
//  Copyright (c) 2015年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//CFAbsoluteTime StartTime;

int main(int argc, char * argv[]) {
    
    NSLog(@"start in %f ",CFAbsoluteTimeGetCurrent());
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
