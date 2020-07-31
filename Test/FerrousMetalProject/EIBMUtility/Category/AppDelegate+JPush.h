//
//  AppDelegate+JPush.h
//
//  Created by Mac on 2019/6/25.
//  Copyright © 2019 apple. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (JPush)

/**
 注册JPush

 @param appKey 推送的appKey
 @param options launchOptions
 */
- (void)jpushRegWithAppKey:(NSString * _Nonnull)appKey launchOptions:(NSDictionary * _Nullable)options;

@end

NS_ASSUME_NONNULL_END
