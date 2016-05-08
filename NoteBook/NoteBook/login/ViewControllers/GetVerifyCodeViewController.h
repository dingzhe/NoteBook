//
//  GetVerifyCodeViewController.h
//  NoteBook
//
//  Created by Mac on 16/5/8.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NBBaseViewController.h"
#import "GetVerifyCodeViewModel.h"

@interface GetVerifyCodeViewController : NBBaseViewController

@property (nonatomic, strong, readonly) GetVerifyCodeViewModel *viewModel;

- (instancetype) initWithViewModel:(GetVerifyCodeViewModel *)viewModel;


@end
