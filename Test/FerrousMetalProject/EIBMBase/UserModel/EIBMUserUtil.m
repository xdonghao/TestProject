//
//  ACSMUserUtil.m
//  FarmRecovery
//
//  Created by 董浩 on 2016/10/19.
//  Copyright © 2016年 donghao. All rights reserved.
//

#import "EIBMUserUtil.h"
#import "EIBMDataSourceManager.h"
static NSString * const USER_KEY  = @"eibm_USER";

@implementation EIBMUserUtil
+ (instancetype)sharedUserUtil{
    static EIBMUserUtil *tool = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[EIBMUserUtil alloc] init];
    });
    
    return tool;
}
- (void)saveCache:(EIBMUser *)user
{
    if (user.userId) {
        // 保存用户
        [[EIBMDataSourceManager new] setUserDefaults:user forKey:USER_KEY];
    }
}

- (void)clearCache
{
    if (self.user.userId &&
        self.user.userId.length > 0) {
        [[EIBMDataSourceManager new] setUserDefaults:nil forKey:USER_KEY];
        self.user = nil;
    }
}

- (EIBMUser *)user
{
    if (!_user) {
        _user = [[EIBMDataSourceManager new] getUserDefaultsByKey:USER_KEY];
    }
    
    return _user;
}
@end
