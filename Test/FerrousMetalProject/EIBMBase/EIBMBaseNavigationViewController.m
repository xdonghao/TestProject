//
//  AABaseNavigationViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 14/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseNavigationViewController.h"

@interface EIBMBaseNavigationViewController ()

@end

@implementation EIBMBaseNavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    
    if (self.viewControllers.count >0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    
    [super pushViewController:viewController animated:YES];
}

@end
