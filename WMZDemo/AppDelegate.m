//
//  AppDelegate.m
//  WMZDemo
//
//  Created by Do on 2021/2/17.
//

#import "AppDelegate.h"

#import "MainVC.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    UINavigationController *mainNav=[[UINavigationController alloc]initWithRootViewController:[[MainVC alloc]init]];
    mainNav.navigationBar.hidden=YES;
    self.window.rootViewController=mainNav;
    [self.window makeKeyAndVisible];
    
    
    return YES;
}

@end
