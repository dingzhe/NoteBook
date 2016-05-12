//
//  MyBlogViewController.m
//  NoteBook
//
//  Created by Mac on 16/5/11.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "MyBlogViewController.h"
#import "MKMarkdownController.h"
#import "MKPreviewController.h"

#import "FeedViewController+Refresh.h"
#import "NoteCellViewModel.h"
#import "Masonry.h"
#import "UIView+HUD.h"
#import "FeedViewModel+MultipleSections.h"


@implementation MyBlogViewController
@dynamic viewModel;

+ (instancetype) viewController {
    MyBlogViewController *result = [[self alloc] initWithModel:[MyBlogViewModel viewModel]];
    result.navBackBarButtonHidden = YES;
    return result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的博客";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self addFreshingControls];
    [self.viewModel loadAtHead];
}
- (void) tableView:(UITableView *)tableView didSelectCellWithViewModel:(CellViewModel *)cellViewModel {
    if ([cellViewModel isKindOfClass:NoteCellViewModel.class]) {
        
        SWGWeekly * model = (SWGWeekly*)cellViewModel.model;
        MKPreviewController *previewController = MKPreviewController.new;
        previewController.bodyMarkdown = model.content;
        //        [previewController ]
        previewController.type = MKPreviewControllerNote;
        previewController.title = model.title;
        @weakify(self) //@strongify(self)
        previewController.onclickBarBtn  = ^(UIBarButtonItem *item){
            if ([item.title isEqualToString:@"编辑"]) {
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
                @strongify(self)
                [self presentViewController:nav animated:YES completion:nil];
                //                    [self.navigationController pushViewController:nav animated:YES];
            }
        };
        [self.navigationController pushViewController:previewController
                                             animated:YES];        
    }
}

@end
