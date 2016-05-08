//
//  LoginViewController.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NBBaseViewController.h"
@interface LoginViewController : NBBaseViewController

@property (nonatomic, strong) RACSignal *cancelSignal;

- (void) showAnimated:(BOOL) showAnimated;

@end
