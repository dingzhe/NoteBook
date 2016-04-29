//
//  UIViewController+Ext.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "UIViewController+Ext.h"

@implementation UIViewController (Ext)
+ (instancetype) rootViewController {
    return UIApplication.sharedApplication.keyWindow.rootViewController;
}
@end
