//
//  RootTabBarViewController.m
//  NoteBook
//
//  Created by Mac on 16/4/29.
//  Copyright © 2016年 dz. All rights reserved.
//

#import "RootTabBarViewController.h"
#import "WeeklyListTableViewController.h"
#import "MarkdownViewController.h"
#import "PersonalViewController.h"
#import "NoteViewController.h"

@interface RootTabBarViewController ()<UITabBarControllerDelegate>

@property (nonatomic,assign) BOOL shouldSignOut;

@end

@implementation RootTabBarViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setupBindings];
    [self reloadApplicationSignout:NO];
}

- (void) setupBindings {
    @weakify(self)
    
    [RACObserve(UserModel.currentUser, status) subscribeNext:^(id _) {
        @strongify(self)
        if (UserModelIdle == UserModel.currentUser.status) {
            // Signout
            if (_shouldSignOut) {
                // delay action in another runloop
                [self performSelector:@selector(reloadApplicationSignout:)
                           withObject:@(YES)
                           afterDelay:0];
            }
            _shouldSignOut = NO;
        }else{
            _shouldSignOut = YES;
        }
    }];
}

- (void) reloadApplicationSignout:(BOOL)signout {
    [self resetRootViewController];
    [self customiseAppearance];
    if (signout == YES) {
//        [SearchHistoriesModel saveHistories:nil callback:nil];
    }
}

- (void) setTabBarItem:(UITabBarItem *)tabBarItem
                 title:(NSString *)title
             imageName:(NSString *)imageName
     selectedImageName:(NSString *)selectedImageName {
    tabBarItem.title         = title;
    tabBarItem.image         = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    tabBarItem.selectedImage = [[UIImage imageNamed:selectedImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
}

- (void) resetRootViewController {
    NSArray *viewControllers = @[[WeeklyListTableViewController viewController],
                                 [NoteViewController viewController],
                                 [PersonalViewController viewController],
                                 ];
    
    NSMutableArray * navigationControllers = [NSMutableArray arrayWithCapacity:3];
    [viewControllers enumerateObjectsUsingBlock:^(UIViewController* vc, NSUInteger idx, BOOL *stop) {
        UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController: vc];
        if (idx == 3) {
//            RAC(navController.tabBarItem, badgeValue) = RACObserve(MessageManagerViewModel.sharedViewModel,totalMessageCountValue);
        }
        [navigationControllers addObject: navController];
    }];
    
    self.tabBar.tintColor    = [UIColor vsBlueColor];
    self.tabBar.barTintColor = [UIColor whiteColor];
    self.tabBar.translucent  = NO;
    self.delegate            = self;
    [self setViewControllers:navigationControllers animated:YES];
    self.selectedIndex = 0;
    
    NSArray *tabBarItems = self.tabBar.items;
    [self setTabBarItem:tabBarItems[0]
                  title:@"blog"
              imageName:@"ic_home_normal"
      selectedImageName:@"ic_home_press"];
    
    [self setTabBarItem:tabBarItems[1]
                  title:@"note"
              imageName:@"ic_hunter_normal"
      selectedImageName:@"ic_hunter_press"];
    
    [self setTabBarItem:tabBarItems[2]
                  title:@"设置"
                   imageName:@"ic_profile_normal"
           selectedImageName:@"ic_profile_press"];
    
//    [self setTabBarItem:tabBarItems[3]
//                  title:@"我的"
//              imageName:@"ic_profile_normal"
//      selectedImageName:@"ic_profile_press"];
}

- (void) customiseAppearance {
    
    //    [[UINavigationBar appearance] setTranslucent:NO];
    if(([UIDevice currentDevice].systemVersion.floatValue >= 8.0) && [UINavigationBar conformsToProtocol:@protocol(UIAppearanceContainer)]) {
        [[UINavigationBar appearance] setTranslucent:NO];
    }
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor vsBlueColor]]
                                       forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes: @{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [[UIBarButtonItem appearance] setTintColor:[UIColor whiteColor]];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    BOOL result = YES;
    
    NSInteger index = [tabBarController.viewControllers indexOfObject:viewController];
    
    if (2 == index) {
        result = [PermissionManager.manager checkPermission:PermissionAuthSignedon context:nil];
        if (!result) {
            PERMISSION_BEGIN(PermissionAuthSignedon, YES, YES, PermissionAuthContextStyleFullScreen)
            
//            DDLogDebug(@"PermissionAuthSignedon success");
            tabBarController.selectedIndex = 2;
            
            PERMISSION_END
        }
    }
    
    return result;
}



@end
