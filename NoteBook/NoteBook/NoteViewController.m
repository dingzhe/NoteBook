//
//  NoteViewController.m
//  NoteBook
//
//  Created by Mac on 16/5/7.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "NoteViewController.h"
#import "MKMarkdownController.h"
#import "MKPreviewController.h"
#import "FeedViewController+Refresh.h"
#import "NoteCellViewModel.h"

@implementation NoteViewController
+ (instancetype) viewController {
    NoteViewController *result = [[self alloc] initWithModel:[NoteViewModel viewModel]];
    result.navBackBarButtonHidden = YES;
    return result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"笔记";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onPreview:)];
    
    
    
//    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"test"
//                                                                             style:UIBarButtonItemStylePlain
//                                                                            target:self
//                                                                            action:@selector(openTestView)];
    [self addFreshingControls];
    [self.viewModel loadAtHead];
}
- (void) tableView:(UITableView *)tableView didSelectCellWithViewModel:(CellViewModel *)cellViewModel {
    if ([cellViewModel isKindOfClass:NoteCellViewModel.class]) {
        
        SWGWeekly * model = (SWGWeekly*)cellViewModel.model;
        MKMarkdownController *controller = [[MKMarkdownController alloc] initWithModel:model];
        controller.defaultMarkdownText   = model.content;
        controller.onComplete = ^(UIViewController *c)
        {
            MKPreviewController *pc = (MKPreviewController *) c;
            NSLog(@"%@", pc.bodyMarkdown);
            [c dismissViewControllerAnimated:YES completion:nil];
        };
        //        [self.navigationController pushViewController:controller animated:YES];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
        [self presentViewController:nav animated:YES completion:nil];
        //        [self.navigationController pushViewController:nav animated:YES];
        
        
    }
}

- (void)onPreview:(id)onClick
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"syntax" ofType:@"md"];
    NSString *content  = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    
    MKMarkdownController *controller = [[MKMarkdownController alloc] initWithAddNote];
    controller.defaultMarkdownText   = content;
    controller.onComplete = ^(UIViewController *c)
    {
        MKPreviewController *pc = (MKPreviewController *) c;
        NSLog(@"%@", pc.bodyMarkdown);
        [c dismissViewControllerAnimated:YES completion:nil];
    };
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    [self presentViewController:nav
                       animated:YES
                     completion:nil];
}
@end
