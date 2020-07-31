//
//  AppDelegate.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 30/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "AppDelegate.h"
#import "EIBMForumManager.h"
#import "EIBMForumReplyManager.h"
#import "EIBMTalkListManager.h"
#import "EIBMForumListModel.h"
#import "AppDelegate+JPush.h"
#import "EIBMTalkDetailManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions  {
    // Override point for customization after application launch.
    [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];

    [[EIBMAppLaunch sharedInstance] launchMainController:self.window];
    [[EIBMAppLaunch sharedInstance] addKeyboardManager];
    [[EIBMAppLaunch sharedInstance] setupTabBarController];
    [[EIBMForumManager shared] initSqlite];
    [[EIBMForumReplyManager shared] initReplySqlite];
    [[EIBMTalkListManager shared]initSqlite];
    [[EIBMTalkDetailManager shared] initTalkSqlite];
    
    [[EIBMAppLaunch sharedInstance] addDefaultMessage];
    return YES;
}


@end
