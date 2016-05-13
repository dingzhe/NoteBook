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
#import "Masonry.h"
#import "UIView+HUD.h"
#import "FeedViewModel+MultipleSections.h"
#import "NoteSettingViewController.h"

@implementation NoteViewController
@dynamic viewModel;

+ (instancetype) viewController {
    NoteViewController *result = [[self alloc] initWithModel:[NoteViewModel viewModel]];
    result.navBackBarButtonHidden = YES;
    return result;
}

- (void)viewWillAppear:(BOOL)animated{
    [self.viewModel loadAtHead];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"笔记";
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(onPreview:)];
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
            }else if([item.title isEqualToString:@"设置"]){
                NoteSettingViewController *vc = [NoteSettingViewController viewControllerWithModel:model];
//                vc.model = model;
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
                @strongify(self)
                [self presentViewController:nav animated:YES completion:nil];
            }
        };
        [self.navigationController pushViewController:previewController
                                             animated:YES];
        
        
        
//        MKMarkdownController *controller = [[MKMarkdownController alloc] initWithModel:model];
//        controller.defaultMarkdownText   = model.content;
//        controller.onComplete = ^(UIViewController *c)
//        {
//            MKPreviewController *pc = (MKPreviewController *) c;
//            NSLog(@"%@", pc.bodyMarkdown);
//            [c dismissViewControllerAnimated:YES completion:nil];
//        };
//        //        [self.navigationController pushViewController:controller animated:YES];
//        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
//        [self presentViewController:nav animated:YES completion:nil];
        //        [self.navigationController pushViewController:nav animated:YES];
        
        
    }
}
- (void) deleteMessage:(id)message {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"确认删除？"
                                                    message:@""
                                                   delegate:nil
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"删除", nil];
    @weakify(self)
    [alert.rac_buttonClickedSignal subscribeNext:^(NSNumber *x) {
        @strongify(self)
        
        if (x.integerValue == 1) {
            [self.tableView setEditing:NO];
            [self.viewModel deleteWeekly:message];
        }
    }];
    
    [alert show];
}

- (void) makeTableViewConstraintWithFooter{
    
    @weakify(self)
    CGFloat footerSpace = 50;
    [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self_weak_.view.mas_leading);
        make.trailing.equalTo(self_weak_.view.mas_trailing);
        make.top.equalTo(self_weak_.view.mas_top);
        make.bottom.equalTo(self_weak_.view.mas_bottom).with.offset(- footerSpace);
    }];
    
}

- (BOOL) tableView:(UITableView *)tableView canEditCellWithViewModel:(CellViewModel *)cellViewModel {
    BOOL result = NO;
    if ([cellViewModel isKindOfClass: NoteCellViewModel.class]) {
        result = YES;
    }
    return result;
}

// OS < iOS 8
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForCellWithViewModel:(CellViewModel *)cellViewModel {
    return [cellViewModel isKindOfClass:NoteCellViewModel.class] ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleNone;
    
}

- (void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forCellWithViewModel:(CellViewModel *)cellViewModel {
    
    if ( editingStyle == UITableViewCellEditingStyleDelete && [cellViewModel isKindOfClass:NoteCellViewModel.class]) {
        [self deleteMessage:((NoteCellViewModel*)cellViewModel.model)];
    }
}

// OS >= iOS 8
- (NSArray*) tableView:(UITableView *)tableView editActionsForCellWithViewModel:(CellViewModel *)cellViewModel {
    
    if ([cellViewModel isKindOfClass:NoteCellViewModel.class]) {
        @weakify(self)
        UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"删除" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
            @strongify(self)
            
            NoteCellViewModel *cellViewModel = (NoteCellViewModel*)[self.viewModel viewModelAtIndexPath:indexPath];
            if ([cellViewModel isKindOfClass:NoteCellViewModel.class]) {
                [self deleteMessage:((NoteCellViewModel*)cellViewModel.model)];
            }
        }];
        return @[deleteAction];
        
    }
    return nil;
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
