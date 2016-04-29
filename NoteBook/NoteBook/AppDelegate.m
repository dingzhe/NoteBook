//
//  AppDelegate.m
//  NoteBook
//
//  Created by dz on 15/11/20.
//  Copyright (c) 2015年 dz. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "WeeklyListTableViewController.h"
#import "MarkdownViewController.h"

@interface AppDelegate ()
@property(nonatomic,strong)UINavigationController *navController;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [self.window makeKeyAndVisible];
    
    
    MarkdownViewController *appVC = [[MarkdownViewController alloc] init];
    appVC.view.backgroundColor = [UIColor orangeColor];
    appVC.title = @"app";
    UINavigationController *appNav = [[UINavigationController alloc] initWithRootViewController:appVC];
    
    WeeklyListTableViewController *weelyListController = [[WeeklyListTableViewController alloc] init];
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    
    
//    UIBarButtonItem *testAPI = [[UIBarButtonItem alloc] initWithTitle:@"test" style:UIBarButtonItemStylePlain target:self action:@selector(openTestView)];
//    
//    weelyListController.navigationItem.leftBarButtonItem = testAPI;
    _navController = [[UINavigationController alloc] initWithRootViewController:weelyListController];
    tabBarController.viewControllers = @[_navController,appNav];
    self.window.rootViewController = tabBarController;
    return YES;
}
- (void)openTestView{
    ViewController *testVC = [ViewController viewController];
    [_navController pushViewController:testVC animated:YES];

}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
