//
//  BaseTabBarController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 30/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseTabBarController.h"
#import "EIBMHomeViewController.h"
#import "EIBMPersonCenterViewController.h"
#import "EIBMMarketViewController.h"
#import "EIBMForumListViewController.h"
#import "EIBMNewsPageViewController.h"
#import "EIBMBaseNavigationViewController.h"
#import "EIBMMarketMyViewController.h"

@interface EIBMBaseTabBarController ()

@end

@implementation EIBMBaseTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.backgroundColor = LLTabBarColor;
    self.tabBar.translucent = NO;
    self.tabBar.tintColor = MainColor;
    [self createSubViewControllers];
    
    [self setTabBarItems];
}

- (void)createSubViewControllers{
    
    EIBMBaseNavigationViewController *home = [[EIBMBaseNavigationViewController alloc]initWithRootViewController:[EIBMHomeViewController new]];
    
    EIBMBaseNavigationViewController *market = [[EIBMBaseNavigationViewController alloc]initWithRootViewController:[[EIBMMarketViewController alloc] initEIBMMarketCenter]];
    
    EIBMBaseNavigationViewController *forum = [[EIBMBaseNavigationViewController alloc]initWithRootViewController:[[EIBMForumListViewController alloc] init]];
     EIBMBaseNavigationViewController *new = [[EIBMBaseNavigationViewController alloc]initWithRootViewController:[[EIBMNewsPageViewController alloc] initEIBMNewsListCenter]];
    EIBMBaseNavigationViewController *my = [[EIBMBaseNavigationViewController alloc]initWithRootViewController:[[EIBMPersonCenterViewController alloc] init]];
    
    self.viewControllers = @[home, market,new,forum,my];
}

- (void)setTabBarItems{
    
    NSArray *titleArr = @[@"首页",@"行情",@"资讯",@"圈子", @"我的"];
    NSArray *normalImgArr = @[@"home_n", @"hq_n", @"xw_n", @"lt_n", @"wd_n"];
    NSArray *selectedImgArr = @[ @"home_d", @"hq_d", @"xw_d",@"lt_d", @"wd_d"];
    //循环设置信息
    for (int i = 0; i<titleArr.count; i++) {
        EIBMBaseNavigationViewController *vc = self.viewControllers[i];
//        vc.tabBarItem = [[UITabBarItem alloc] initWithTitle:titleArr[i] image:[UIImage imageNamed:normalImgArr[i]] tag:i];
        vc.tabBarItem = [[UITabBarItem alloc]initWithTitle:titleArr[i] image:[UIImage imageNamed:normalImgArr[i]] selectedImage:[[UIImage imageNamed:selectedImgArr[i]]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]];
        vc.tabBarItem.tag = i;
    }
    
}



+ (void)initialize
{
    //设置底部tabbar的主题样式
//    UITabBarItem *appearance = [UITabBarItem appearance];
//    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor lightGrayColor], NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
//    [appearance setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:MainColor, NSForegroundColorAttributeName,nil] forState:UIControlStateSelected];

}

@end
