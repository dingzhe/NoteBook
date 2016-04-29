//
//  UINavigationController+DzNote.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "UINavigationController+DzNote.h"

@implementation UINavigationController (DzNote)

- (BOOL) hasPushedViewControllerWithClass:(Class) viewControllerClass {
    __block BOOL result = NO;
    
    [self.navigationController.viewControllers
     enumerateObjectsUsingBlock:^(UIViewController *viewController, NSUInteger idx, BOOL *stop) {
         if ([viewController isKindOfClass:viewControllerClass]) {
             result = YES;
             *stop = YES;
         }
     }];
    
    return result;
}

@end
