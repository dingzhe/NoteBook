//
//  NoteBookTests.m
//  NoteBookTests
//
//  Created by dz on 15/11/20.
//  Copyright (c) 2015年 dz. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "TestViewModel.h"
#import "NoteBookLib.h"

//#import "ViewController.h"
@interface NoteBookTests : XCTestCase
@property (strong,nonatomic)TestViewModel *testModel;
//@property (nonatomic, strong) RACCommand *getArticleCommand;
//@property (nonatomic, strong) SWGGetArticleByIdRequest* article;
//
@property (nonatomic, strong) RACCommand *weeklyListCommand;
@end

@implementation NoteBookTests

- (void)setUp {
    [super setUp];
    @weakify(self)
    _weeklyListCommand = [NoteBookWeeklyService.service weeklyListCommandEnable:nil];
    
    [_weeklyListCommand.responses subscribeNext:^(SWGWeeklyListResponses *response) {
        @strongify(self)
        //            [self.showHUDSignal sendNext:@"保存成功"];
        NSLog(@"接口测试：%@",response);
        
        
//        [self showHUDMessage:[NSString stringWithFormat:@"%@",response]];
    }];
    [_weeklyListCommand.errors subscribeNext:^(NSError *error) {
        NSLog(@"%@",error);
        
        //            DDLogError(@"Error while update base:%@", error);
    }];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)test{
    SWGWeeklyListRequest *request = [[SWGWeeklyListRequest alloc] init];
    request.uid = @"9";
    [_weeklyListCommand execute:request];

}

- (void)testWeeklyList{
    SWGWeeklyListRequest *request = [[SWGWeeklyListRequest alloc] init];
    request.uid = @"9";
    [_weeklyListCommand execute:request];
}

- (void)testExample {
    // This is an example of a functional test case.
    [_testModel test1];
    [_testModel test2];
    [_testModel test3];
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
