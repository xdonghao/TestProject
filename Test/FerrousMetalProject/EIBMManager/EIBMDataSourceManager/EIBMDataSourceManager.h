//
//  ACSMDataSourceManager.h
//  FarmRecovery
//
//  Created by 董浩 on 2016/10/19.
//  Copyright © 2016年 donghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EIBMDataSourceManager : NSObject
/**
 *  保存用户属性
 *
 *  @param userDefaults value
 *  @param key          key
 */
- (void)setUserDefaults:(id)userDefaults forKey:(NSString *)key;
/**
 *  获取用户属性
 *
 *  @param key key
 *
 *  @return value
 */
- (id)getUserDefaultsByKey:(NSString *)key;
@end
