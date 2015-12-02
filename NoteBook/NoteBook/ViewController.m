//
//  ViewController.m
//  NoteBook
//
//  Created by dz on 15/11/20.
//  Copyright (c) 2015年 dz. All rights reserved.
//

#import "ViewController.h"
#import "NoteBookLib.h"
@interface ViewController ()

@property (nonatomic, strong) RACCommand *getArticleCommand;
@property (nonatomic, strong) SWGGetArticleByIdResponse* article;
@end

@implementation ViewController
- (id)init{
    if (self = [super init]) {
        @weakify(self)
        _getArticleCommand = [NoteBookArticleService.service getArticleWithIdCommandEnable:nil];
        [_getArticleCommand.responses subscribeNext:^(SWGGetArticleByIdResponse* respons) {
            @strongify(self)
//            [self.showHUDSignal sendNext:@"保存成功"];
            NSLog(@"%@",respons);
            self.article = respons;
            NSLog(@"-----%@",self.article);
            
        }];
        [_getArticleCommand.errors subscribeNext:^(NSError *error) {
////            DDLogError(@"Error while update base:%@", error);
            NSLog(@"%@",error);
        }];
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
//    [[[Person alloc] init] run];
//    SWGApi *api;
//    [[[Note alloc]init] readBook:@"iOS Pre"];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
//    SWGGetArticleApi *api = [SWGGetArticleApi apiWithBasePath:@"http://192.168.1.111/php"];
//    //http://192.168.1.111/php/api.php
//    
//    [api getArticleByIdWith_id:@"8" api:@"article" completionHandler:^(NSData *data, NSError *error) {
//        NSLog(@"%@",data);
//    }];
//    [_getArticleCommand execute:[@"8",@"article"]];
    
    SWGGetArticleByIdRequest *request = [[SWGGetArticleByIdRequest alloc] init];
    request._id = @"8";
    request.api = @"article";
    [_getArticleCommand execute:request];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
