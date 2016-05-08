//
//  RegisterViewModel.h
//  NoteBook
//
//  Created by Mac on 16/5/8.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "GetVerifyCodeViewModel.h"

@interface RegisterViewModel : GetVerifyCodeViewModel

@property (nonatomic,strong) NSString *password;
@property (nonatomic,readonly) RACCommand *registerCommand;

- (void)goRegister;


@end
