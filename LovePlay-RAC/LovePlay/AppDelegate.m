//
//  AppDelegate.m
//  LovePlay
//
//  Created by weiying on 2017/1/22.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "AppDelegate.h"
#import "JPFPSStatus.h"
#import "MainTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [[HttpRequest sharedInstance] configBaseURL:BaseURL];
    
    [self setupMainController];
    
    [self.window makeKeyAndVisible];
    
    [self setupJPFPSStatus];
    return YES;
}

- (void)setupJPFPSStatus
{
    [[JPFPSStatus sharedInstance] open];
}

- (void)setupMainController
{
    self.window.rootViewController = [[MainTabBarController alloc] init];
}

- (void)setupADLaunchController
{

}

@end
