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
@property (nonatomic, strong) SWGGetArticleByIdResponse* article;
@end

@implementation TestViewModel
+ (instancetype) viewModel {
    return [[self alloc] init];
}

- (id)init {
    
    if (self = [super init]) {
        
        @weakify(self)
        _getArticleCommand = [NoteBookArticleService.service getArticleWithIdCommandEnable:nil];
        [_getArticleCommand.responses subscribeNext:^(SWGGetArticleByIdResponse* response) {
            @strongify(self)
            //            [self.showHUDSignal sendNext:@"保存成功"];
            NSLog(@"%@",response);
            self.article = response;
            NSLog(@"-----%@",self.article);
            
            [self showHUDMessage:[NSString stringWithFormat:@"%@",response]];
            
        }];
        [_getArticleCommand.errors subscribeNext:^(NSError *error) {
            ////            DDLogError(@"Error while update base:%@", error);
            NSLog(@"%@",error);
        }];
    }
    return self;
}

- (void) test1 {
    SWGGetArticleByIdRequest *request = [[SWGGetArticleByIdRequest alloc] init];
    request._id = @"8";
    request.api = @"article";
    SWGGetArticleApi *api = [SWGGetArticleApi apiWithBasePath:@"http://192.168.1.111/php"];
    [api getArticleByIdWithBody:request completionHandler:^(SWGGetArticleByIdResponse *output, NSError *error) {
        NSLog(@"%@",output);
    }];
    [_getArticleCommand execute:request];
}
- (void) test2 {
    SWGGetArticleByIdRequest *request = [[SWGGetArticleByIdRequest alloc] init];
    request._id = @"8";
    request.api = @"article";
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
