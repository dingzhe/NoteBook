//
//  UINavigationController+DzNote.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (DzNote)

- (BOOL) hasPushedViewControllerWithClass:(Class) viewControllerClass;

@end
