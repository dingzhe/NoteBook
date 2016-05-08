//
//  RegisterViewController.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//


#import "RegisterViewModel.h"
#import "NBBaseViewController.h"

@interface RegisterViewController : NBBaseViewController

@property (nonatomic,strong) RegisterViewModel *viewModel;

- (instancetype) initWithModel:(RegisterViewModel *)viewModel;

@end
