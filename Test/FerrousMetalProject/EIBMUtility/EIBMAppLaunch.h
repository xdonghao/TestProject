//
//  AppLaunch.h
//  FarmRecovery
//
//  Created by 董浩 on 2016/10/20.
//  Copyright © 2016年 donghao. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface EIBMAppLaunch : NSObject
DH_SYNTHESIZE_SINGLETON_INTERFACE(EIBMAppLaunch)

/**
 *  添加键盘管理工具
 */
- (void)addKeyboardManager;

- (void)setupLoginController;

- (void)setupTabBarController;

/**
 退出登录
 */
- (void)showWindowHome;

- (void)launchMainController:(UIWindow *)window;

- (void)launchController:(UIViewController *)viewController window:(UIWindow *)window;

- (void)launchMainControllerFromViewController:(UIViewController *)viewController;

- (void)addDefaultMessage;

@end
