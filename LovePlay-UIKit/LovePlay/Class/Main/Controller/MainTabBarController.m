//
//  MainTabBarController.m
//  LovePlay
//
//  Created by weiying on 2017/1/22.
//  Copyright © 2017年 Yuns. All rights reserved.
//

#import "MainTabBarController.h"
#import "MainNavigationController.h"
#import "NewsListViewController.h"
#import "RecommendViewController.h"
#import "ZoneListViewController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTabBar];
    [self addNewsViewController];
    [self addRecommendViewController];
    [self addZoneViewController];
}

- (void)configureTabBar
{
    [[UITabBarItem appearanceWhenContainedIn:[self class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor colorWithRed:113/255.0 green:113/255.0 blue:113/255.0 alpha:1.0] } forState:UIControlStateNormal];
    
    [[UITabBarItem appearanceWhenContainedIn:[self class], nil] setTitleTextAttributes:@{NSForegroundColorAttributeName :[UIColor colorWithRed:218/255.0 green:85/255.0 blue:107/255.0 alpha:1.0] } forState:UIControlStateSelected];
}

- (void)addNewsViewController
{
    NewsListViewController *newsViewController = [[NewsListViewController alloc] init];
    [self addChildViewController:newsViewController title:@"资讯" imageName:@"icon_zx_nomal_pgall" selectImageName:@"icon_zx_pressed_pgall"];
}

- (void)addRecommendViewController
{
    RecommendViewController *recommendViewController = [[RecommendViewController alloc] init];
    [self addChildViewController:recommendViewController title:@"精选" imageName:@"icon_jx_nomal_pgall" selectImageName:@"icon_jx_pressed_pgall"];
}

- (void)addZoneViewController
{
    ZoneListViewController *zoneViewController = [[ZoneListViewController alloc] init];
    [self addChildViewController:zoneViewController title:@"社区" imageName:@"icon_sq_nomal_pgall" selectImageName:@"icon_sq_pressed_pgall"];
}

- (void)addChildViewController:(UIViewController *)childController title:(NSString *)title imageName:(NSString *)imageName selectImageName:(NSString *)selectImageName
{
    childController.title = title;
    childController.tabBarItem.title = title;
    childController.tabBarItem.image = [UIImage imageNamed:imageName];
    childController.tabBarItem.selectedImage = [[UIImage imageNamed:selectImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    MainNavigationController *nav = [[MainNavigationController alloc] initWithRootViewController:childController];
    [self addChildViewController:nav];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
