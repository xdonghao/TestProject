//
//  ACSMUserUtil.h
//  FarmRecovery
//
//  Created by 董浩 on 2016/10/19.
//  Copyright © 2016年 donghao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EIBMUser.h"
@interface EIBMUserUtil : NSObject

/**
 *  用户
 */
@property (nonatomic, strong)EIBMUser *user;
+ (instancetype)sharedUserUtil;
- (void)saveCache:(EIBMUser *)user;
- (void)clearCache;
@end
