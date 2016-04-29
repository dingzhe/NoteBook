//
//  PersonalViewController.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "PersonalViewController.h"

@implementation PersonalViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onClick:)];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:UserModel.currentUser.uid
         forState:UIControlStateNormal];
   
    [btn setTitleColor:[UIColor blueColor]
              forState:UIControlStateNormal];
    [self.view addSubview:btn];
    [btn sizeToFit];
    [btn setCenter:CGPointMake(self.view.bounds.size.width/2, self.view.bounds.size.height/2)];
    [btn addTarget:self
            action:@selector(onClick:)
  forControlEvents:UIControlEventTouchUpInside];
}

- (void)onClick:(id)onClick
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"syntax" ofType:@"md"];
    NSString *content  = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
//    MKMarkdownController *controller = [MKMarkdownController new];
//    controller.defaultMarkdownText   = content;
//    controller.onComplete = ^(UIViewController *c)
//    {
//        MKPreviewController *pc = (MKPreviewController *) c;
//        NSLog(@"%@", pc.bodyMarkdown);
//        [c dismissViewControllerAnimated:YES completion:nil];
//    };
//    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
//    [self presentViewController:nav
//                       animated:YES
//                     completion:nil];
}
@end
