//
//  InputFieldViewController.h
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NBBaseViewController.h"

@interface InputFieldViewController : NBBaseViewController

@property (nonatomic,strong,readonly) RACSubject *completeSignal;
@property (nonatomic,strong) NSString *text;
@property (nonatomic,strong) NSString *placeHolderText;

@end
