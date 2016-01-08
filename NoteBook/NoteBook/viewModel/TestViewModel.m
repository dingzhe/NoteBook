//
//  TestViewModel.m
//  NoteBook
//
//  Created by dz on 15/12/2.
//  Copyright (c) 2015年 dz. All rights reserved.
//

#import "TestViewModel.h"
#import "NoteBookLib.h"

@interface TestViewModel()
@property (nonatomic, strong) RACCommand *getArticleCommand;
@property (nonatomic, strong) SWGGetArticleByIdRequest* article;
@property (nonatomic, strong) RACCommand *signInCommand;

@end

@implementation TestViewModel
+ (instancetype) viewModel {
    return [[self alloc] init];
}

- (id)init {
    
    if (self = [super init]) {
        
        @weakify(self)
        _signInCommand = [NoteBookSignService.service signInCommandEnable:nil];
        
        [_signInCommand.responses subscribeNext:^(SWGSignResponses *response) {
            @strongify(self)
//            [self.showHUDSignal sendNext:@"保存成功"];
            NSLog(@"%@",response);
        }];
        [_signInCommand.errors subscribeNext:^(NSError *error) {
            NSLog(@"%@",error);
            
//            DDLogError(@"Error while update base:%@", error);
        }];
        _getArticleCommand = [NoteBookArticleService.service getArticleWithIdCommandEnable:nil];
        
        [_getArticleCommand.responses subscribeNext:^(SWGArticle *response) {
            @strongify(self)
            //            [self.showHUDSignal sendNext:@"保存成功"];
            NSLog(@"%@",response);
        }];
        [_getArticleCommand.errors subscribeNext:^(NSError *error) {
            NSLog(@"%@",error);
            //            DDLogError(@"Error while update base:%@", error);
        }];
    }
    return self;
}

- (void) test1 {
    SWGSignRequest * request = [[SWGSignRequest alloc] init];
    request.username = @"ding";
    request.password = @"123456";
//    request.app = @"iOS";
    [_signInCommand execute:request];

}
- (void) test2 {
    SWGGetArticleByIdRequest * request = [[SWGGetArticleByIdRequest alloc] init];
    request._id = @"8";
    [_getArticleCommand execute:request];
}
- (void) test3 {
    NSURL *url = [NSURL URLWithString:@"prefs:root=LOCATION_SERVICES"];
    if ([[UIApplication sharedApplication] canOpenURL:url])
    {
        [[UIApplication sharedApplication] openURL:url];
    }
}








@end
