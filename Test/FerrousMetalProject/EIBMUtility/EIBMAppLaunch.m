//
//  AppLaunch.m
//  FarmRecovery
//
//  Created by 董浩 on 2016/10/20.
//  Copyright © 2016年 donghao. All rights reserved.
//

#import "EIBMAppLaunch.h"
#import "EIBMBaseTabBarController.h"
#import "IQKeyboardManager.h"
#import "EIBMForumListModel.h"
#import "EIBMForumManager.h"
#import "EIBMForumReplyManager.h"
#import "EIBMTalkListManager.h"
#import "TalkListModel.h"
@interface EIBMAppLaunch ()

@property (nonatomic, strong) UIWindow *main_window;
//@property (nonatomic, strong) ACSMMainTabBarViewController *tabBarController;

@end

@implementation EIBMAppLaunch
DH_SYNTHESIZE_SINGLETON_IMPLEMENTION(EIBMAppLaunch)
//- (ACSMMainTabBarViewController *)tabBarController{
//    if (!_tabBarController) {
//        _tabBarController = [ACSMMainTabBarViewController acsm];
//    }
//    return _tabBarController;
//}


- (void)addKeyboardManager
{
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
}

#pragma mark *********** 退出登录方法 *********

- (void)setupLoginController{
//    self.main_window.rootViewController = [[BaseNavigationController alloc]initWithRootViewController:[LoginDetailController new]];
}

- (void)setupTabBarController{
    EIBMBaseTabBarController *vc = [EIBMBaseTabBarController new];
    self.main_window.rootViewController = vc;
}

- (void)launchMainController:(UIWindow *)window
{
    if (!self.main_window) {
        self.main_window = window;
    }
    if (!self.main_window) {
        self.main_window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    }
//    _tabBarController = nil;
//    [self.main_window setRootViewController:self.tabBarController];
    self.main_window.backgroundColor = [UIColor whiteColor];
    [self.main_window makeKeyAndVisible];
}

- (void)launchController:(UIViewController *)viewController window:(UIWindow *)window
{
    if (!self.main_window) {
        self.main_window = window;
    }
    [self.main_window setRootViewController:viewController];
    [self.main_window makeKeyAndVisible];
}

- (void)launchMainControllerFromViewController:(UIViewController *)viewController
{
//    _tabBarController = nil;
//    [UIView transitionFromView:viewController.view
//                        toView:self.tabBarController.view
//                      duration:0.5
//                       options:UIViewAnimationOptionTransitionNone
//                    completion:^(BOOL finished)
//     {
//         [self.main_window setRootViewController:self.tabBarController];
//         [self.main_window makeKeyAndVisible];
//     }];
}

- (void)addDefaultMessage {
    NSUserDefaults *defaults=[NSUserDefaults standardUserDefaults];
    NSString *openStr=[defaults objectForKey:@"FirstLogIN"];
    if (openStr.length >0 && [openStr isEqualToString:@"HAHA"]) {
        
    }else{
        [defaults setObject:@"HAHA" forKey:@"FirstLogIN"];
        [defaults synchronize];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"luntan_k_data" ofType:@"json"];
        NSData *dataStock = [NSData dataWithContentsOfFile:path];
        NSArray *stockJson = [NSJSONSerialization JSONObjectWithData:dataStock options:0 error:nil];
        NSMutableArray *luntanArray = [NSMutableArray array];
        for (NSDictionary *modelDic in stockJson) {
            EIBMForumListModel *model = [EIBMForumListModel mj_objectWithKeyValues:modelDic];
            NSInteger i = [model.created integerValue] + 86400*48;
            model.created = [NSNumber numberWithInteger:i];
            [luntanArray addObject:model];
        }
        [[EIBMForumManager shared] insertWithForumListObjects:luntanArray];
        
        NSString *path2 = [[NSBundle mainBundle] pathForResource:@"pinglun_k_data" ofType:@"json"];
        NSData *dataStock2 = [NSData dataWithContentsOfFile:path2];
        NSArray *stockJson2 = [NSJSONSerialization JSONObjectWithData:dataStock2 options:0 error:nil];
        NSMutableArray *pinglunArray = [NSMutableArray array];
        for (NSDictionary *modelDic in stockJson2) {
            EIBMForumListModel *model = [EIBMForumListModel mj_objectWithKeyValues:modelDic];
            NSInteger i = [model.created integerValue] + 86400*48;
            model.created = [NSNumber numberWithInteger:i];
            [pinglunArray addObject:model];
        }
        [[EIBMForumReplyManager shared] addDBDataWithForumReplyObjects:pinglunArray];
        
        
        
        NSString *path3 = [[NSBundle mainBundle] pathForResource:@"talk_k_data" ofType:@"json"];
        NSData *dataStock3 = [NSData dataWithContentsOfFile:path3];
        NSArray *stockJson3 = [NSJSONSerialization JSONObjectWithData:dataStock3 options:0 error:nil];
        NSMutableArray *talkArray = [NSMutableArray array];
        for (NSDictionary *modelDic in stockJson3) {
            TalkListModel *model = [TalkListModel mj_objectWithKeyValues:modelDic];
            [talkArray addObject:model];
        }
        [[EIBMTalkListManager shared] insertWithTalkListObjects:talkArray];
    }
}
@end
