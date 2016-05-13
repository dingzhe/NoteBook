//
//  PersonalViewController.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "PersonalViewController.h"
#import "CommonTextCellViewModel.h"
#import "PersonalManagerHeadCell.h"
#import "PersonalInformationViewController.h"
#import "MyBlogViewController.h"
#import "MyFavoriteViewController.h"
#import "SettingViewController.h"


@interface PersonalViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>

@end
@implementation PersonalViewController
@dynamic viewModel;

+ (instancetype) viewController {
    PersonalViewController *result = [[self alloc] initWithModel:[PersonalViewModel sharedViewModel]];
//    result.hidesBottomBarWhenPushed = YES;
    result.navBackBarButtonHidden = YES;
    return result;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我";
    
    [self.viewModel reload];
    [self.viewModel refreshResume];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(signout)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"setting"] style:UIBarButtonItemStyleDone target:self action:@selector(signout)];
}

- (void)signout{

    SettingViewController *desVC = [SettingViewController viewController];
    [self.navigationController pushViewController:desVC animated:YES];

}


-(void)toChangePortrait
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"选择照片", nil];
    sheet.actionSheetStyle=UIActionSheetStyleBlackTranslucent;
    [sheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex>1) {
        return;
    }
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    if (buttonIndex == 0) {
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            UIAlertView *av=[[UIAlertView alloc] initWithTitle:nil message:@"设备不支持拍照" delegate:nil cancelButtonTitle:@"好的" otherButtonTitles: nil];
            [av show];
            return;
        }
        imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else if(buttonIndex == 1) {
        imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    
    if (!imagePicker.navigationController && imagePicker.navigationController.presentingViewController) {
        return;
    }
    
    UIViewController *prensentingVC = imagePicker;
    
    [self presentViewController:prensentingVC animated:YES completion:nil];
}

- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated{
    if ([navigationController isKindOfClass:[UIImagePickerController class]]
        &&((UIImagePickerController *)navigationController).sourceType == UIImagePickerControllerSourceTypePhotoLibrary
        &&[[UIDevice currentDevice].systemVersion floatValue]>=7.0) {
        
        [[UIApplication sharedApplication] setStatusBarHidden:NO];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
        UIGraphicsBeginImageContext(CGSizeMake(130, 130));
        CGRect rect = CGRectMake(0, 0, 130, 130);
        [image drawInRect:rect];
        UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.viewModel updateAvatar:newimg];
        });
    });
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - tableViewDelegate

- (NBTableViewCell*) tableView:(UITableView *)tableView cellForViewModel:(CellViewModel *)cellViewModel {
    NBTableViewCell *cell = [super tableView:tableView cellForViewModel:cellViewModel];
    @weakify(self)
    if ([cellViewModel isKindOfClass:PersonalManagerHeadCellViewModel.class]) {
        PersonalManagerHeadCell *headCell = (PersonalManagerHeadCell *)cell;
        headCell.previewBtn.rac_command = [RACCommand commandWithBlock:^(id input) {
            @strongify(self)
            //我的博客
            [self goToMyBlog];
        }];
        headCell.browseHistoryBtn.rac_command = [RACCommand commandWithBlock:^(id input) {
            @strongify(self)
            //我的收藏
            [self goToMyFavorite];
        }];
        headCell.headBtn.rac_command = [RACCommand commandWithBlock:^(id input) {
            @strongify(self)
            [self toChangePortrait];
        }];
    }
    return  cell;
}



- (void)goToMyBlog {
    MyBlogViewController *detailVC = [MyBlogViewController viewController];
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void)goToMyFavorite {
    MyFavoriteViewController *detailVC = [MyFavoriteViewController viewController];
    [self.navigationController pushViewController:detailVC animated:YES];
}
- (void) tableView:(UITableView *)tableView didSelectCellWithViewModel:(CellViewModel *)cellViewModel {
    if ([cellViewModel isKindOfClass:CommonTextCellViewModel.class]) {
        CommonTextCellModel *commonTextCellModel = (CommonTextCellModel*)cellViewModel.model;
        Class destinationClass = NSClassFromString(commonTextCellModel.destinationVC);
        NBBaseViewController *desVC = [destinationClass viewController];
//        PersonalInformationViewController *desVC = [PersonalInformationViewController viewController];
        [self.navigationController pushViewController:desVC animated:YES];
    }
}
- (void)onClick:(id)onClick
{
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"syntax" ofType:@"md"];
    NSString *content  = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    
    content = [content stringByReplacingOccurrencesOfString:@"\r" withString:@""];
}
@end
