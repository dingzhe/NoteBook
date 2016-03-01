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

@property (nonatomic, strong) RACCommand *signUpCommand;
@property (nonatomic, strong) RACCommand *addweeklyCommand;
@property (nonatomic, strong) RACCommand *weeklyListCommand;
@property (nonatomic, strong) RACCommand *myWeeklyCommand;

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
            [self showHUDMessage:[NSString stringWithFormat:@"%@",response]];
        }];
        [_signInCommand.errors subscribeNext:^(NSError *error) {
            NSLog(@"%@",error);
            
//            DDLogError(@"Error while update base:%@", error);
        }];
        
        _signUpCommand = [NoteBookSignService.service signUpCommandEnable:nil];
        
        [_signUpCommand.responses subscribeNext:^(SWGSignResponses *response) {
            @strongify(self)
            //            [self.showHUDSignal sendNext:@"保存成功"];
            NSLog(@"%@",response);
            
            [self showHUDMessage:[NSString stringWithFormat:@"%@",response]];
        }];
        [_signUpCommand.errors subscribeNext:^(NSError *error) {
            NSLog(@"%@",error);
            
            //            DDLogError(@"Error while update base:%@", error);
        }];
        
        _addweeklyCommand = [NoteBookWeeklyService.service addWeeklyCommandEnable:nil];
        
        [_addweeklyCommand.responses subscribeNext:^(SWGAddWeeklyResponses *response) {
            @strongify(self)
            //            [self.showHUDSignal sendNext:@"保存成功"];
            NSLog(@"%@",response);
            
            [self showHUDMessage:[NSString stringWithFormat:@"%@",response]];
        }];
        [_addweeklyCommand.errors subscribeNext:^(NSError *error) {
            NSLog(@"%@",error);
            
            //            DDLogError(@"Error while update base:%@", error);
        }];
        
        _weeklyListCommand = [NoteBookWeeklyService.service weeklyListCommandEnable:nil];
        
        [_weeklyListCommand.responses subscribeNext:^(SWGWeeklyListResponses *response) {
            @strongify(self)
            //            [self.showHUDSignal sendNext:@"保存成功"];
            NSLog(@"%@",response);
            
            [self showHUDMessage:[NSString stringWithFormat:@"%@",response]];
        }];
        [_weeklyListCommand.errors subscribeNext:^(NSError *error) {
            NSLog(@"%@",error);
            
            //            DDLogError(@"Error while update base:%@", error);
        }];
        
        _myWeeklyCommand = [NoteBookWeeklyService.service myWeeklyCommandEnable:nil];
        
        [_myWeeklyCommand.responses subscribeNext:^(SWGMyWeeklyResponses *response) {
            @strongify(self)
            //            [self.showHUDSignal sendNext:@"保存成功"];
            NSLog(@"%@",response);
            
            [self showHUDMessage:[NSString stringWithFormat:@"%@",response]];
        }];
        [_myWeeklyCommand.errors subscribeNext:^(NSError *error) {
            NSLog(@"%@",error);
            
            //            DDLogError(@"Error while update base:%@", error);
        }];
        
        _getArticleCommand = [NoteBookArticleService.service getArticleWithIdCommandEnable:nil];
        
        [_getArticleCommand.responses subscribeNext:^(SWGArticle *response) {
            @strongify(self)
            //            [self.showHUDSignal sendNext:@"保存成功"];
            NSLog(@"%@",response);
            [self showHUDMessage:[NSString stringWithFormat:@"%@",response]];
        }];
        [_getArticleCommand.errors subscribeNext:^(NSError *error) {
            NSLog(@"%@",error);
            //            DDLogError(@"Error while update base:%@", error);
        }];
    }
    return self;
}

- (void) test1 {
//    [self signIn];
    [self addWeekly];
//    [self weeklyList];
//    [self myWeekly];
}
- (void) test2 {
//    SWGGetArticleByIdRequest * request = [[SWGGetArticleByIdRequest alloc] init];
//    request._id = @"8";
//    [_getArticleCommand execute:request];
    [self weeklyList];
}
- (void) test3 {
    [self myWeekly];
}


/**
 *  登录
 */
- (void)signIn{
    SWGSignRequest * request = [[SWGSignRequest alloc] init];
    request.username = @"dingzero";
    request.password = @"123456";
    [_signInCommand execute:request];
}

/**
 *  注册
 */
- (void)signUp{
    SWGSignRequest * request = [[SWGSignRequest alloc] init];
    request.username = @"dingzero";
    request.password = @"123456";
    [_signUpCommand execute:request];
}

/**
 *  新建周报
 */
- (void)addWeekly{
    SWGAddWeeklyRequest * request = [[SWGAddWeeklyRequest alloc] init];
    request.uid = @"9";
    NSString* date;
    NSDateFormatter* formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd[hh:mm:ss]"];
    date = [formatter stringFromDate:[NSDate date]];
    request.title = date;
    request.content = @"DontsupportChinese";
    request.dateline = date;
    
//    request.dateline = 
    [_addweeklyCommand execute:request];
}

/**
 *  周报列表
 */
- (void)weeklyList{
    SWGWeeklyListRequest *request = [[SWGWeeklyListRequest alloc] init];
    request.uid = @"9";
    [_weeklyListCommand execute:request];
}

/**
 *  个人周报列表
 */
- (void)myWeekly{
    SWGMyWeeklyRequest *request = [[SWGMyWeeklyRequest alloc] init];
    request.uid = @"9";
    [_myWeeklyCommand execute:request];
}








@end
