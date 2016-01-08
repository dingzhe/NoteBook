//
//  ViewController.m
//  NoteBook
//
//  Created by dz on 15/11/20.
//  Copyright (c) 2015年 dz. All rights reserved.
//

#import "ViewController.h"
@interface ViewController ()

@property (nonatomic, strong) RACCommand *getArticleCommand;
@property (nonatomic, strong) SWGGetArticleByIdRequest* article;
@end

@implementation ViewController



+ (instancetype) viewController {
    return [[self alloc] initWithModel:[TestViewModel viewModel]];
}

- (instancetype) initWithModel:(TestViewModel *)viewModel {
    if (self = [super initWithNibName:nil bundle:nil]) {
        _viewModel = viewModel;
        self.hidesBottomBarWhenPushed = YES;
        self.title = @"测试API";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    @weakify(self)
    
    UIButton *testBtn1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [testBtn1 setTitle:@"测试1" forState:UIControlStateNormal];
    [testBtn1 setFrame:CGRectMake(0, 0, 50, 35)];
    testBtn1.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height*1/4);
    [self.view addSubview:testBtn1];
    testBtn1.rac_command = [RACCommand commandWithBlock:^(id input) {
        @strongify(self)
        [self.viewModel test1];
    }];
    
    UIButton *testBtn2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [testBtn2 setTitle:@"测试2" forState:UIControlStateNormal];
    [testBtn2 setFrame:CGRectMake(0, 0, 50, 35)];
    testBtn2.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height*2/4);
    [self.view addSubview:testBtn2];
    testBtn2.rac_command = [RACCommand commandWithBlock:^(id input) {
        @strongify(self)
        [self.viewModel test2];
    }];
    
    UIButton *testBtn3 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [testBtn3 setTitle:@"测试3" forState:UIControlStateNormal];
    [testBtn3 setFrame:CGRectMake(0, 0, 50, 35)];
    testBtn3.center = CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height*3/4);
    [self.view addSubview:testBtn3];
    testBtn3.rac_command = [RACCommand commandWithBlock:^(id input) {
        @strongify(self)
        [self.viewModel test3];
    }];
    
    [[self.viewModel.showHUDSignal takeUntil:self.rac_willDeallocSignal] subscribeNext:^(NSString* message) {
        [self.view showHUDWithText:nil detailText:message autoDismiss:YES];
    }];
    
}





//- (id)init{
//    if (self = [super init]) {
//        @weakify(self)
//        _getArticleCommand = [NoteBookArticleService.service getArticleWithIdCommandEnable:nil];
//        [_getArticleCommand.responses subscribeNext:^(SWGGetArticleByIdResponse* respons) {
//            @strongify(self)
////            [self.showHUDSignal sendNext:@"保存成功"];
//            NSLog(@"%@",respons);
//            self.article = respons;
//            NSLog(@"-----%@",self.article);
//            
//        }];
//        [_getArticleCommand.errors subscribeNext:^(NSError *error) {
//////            DDLogError(@"Error while update base:%@", error);
//            NSLog(@"%@",error);
//        }];
//    }
//    
//    return self;
//}
//
//
//- (void)viewDidLoad {
//    [super viewDidLoad];
////    [[[Person alloc] init] run];
////    SWGApi *api;
////    [[[Note alloc]init] readBook:@"iOS Pre"];
//    // Do any additional setup after loading the view, typically from a nib.
//    self.view.backgroundColor = [UIColor whiteColor];
////    SWGGetArticleApi *api = [SWGGetArticleApi apiWithBasePath:@"http://192.168.1.111/php"];
////    //http://192.168.1.111/php/api.php
////    
////    [api getArticleByIdWith_id:@"8" api:@"article" completionHandler:^(NSData *data, NSError *error) {
////        NSLog(@"%@",data);
////    }];
////    [_getArticleCommand execute:[@"8",@"article"]];
//    
//    SWGGetArticleByIdRequest *request = [[SWGGetArticleByIdRequest alloc] init];
//    request._id = @"8";
//    request.api = @"article";
//    [_getArticleCommand execute:request];
//    
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
