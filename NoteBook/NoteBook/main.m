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
        [OneAPM startWithApplicationToken: @ "9C1574EDF94C926FE9908020C1E277CE83"];
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
