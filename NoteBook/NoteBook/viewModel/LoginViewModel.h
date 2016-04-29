//
//  LoginViewModel.h
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "ViewModel.h"

@interface LoginViewModel : ViewModel

@property (nonatomic, strong) NSString *phoneNumber;
@property (nonatomic, strong) NSString *password;
@property (nonatomic, readonly) RACCommand *loginCommand;

- (void)login;

@end
