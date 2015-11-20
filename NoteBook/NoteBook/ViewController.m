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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[[Person alloc] init] run];
//    SWGApi *api;
    [[[Note alloc]init] readBook:@"iOS Pre"];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
