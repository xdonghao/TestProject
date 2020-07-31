//
//  ACSMDataSourceManager.m
//  FarmRecovery
//
//  Created by 董浩 on 2016/10/19.
//  Copyright © 2016年 donghao. All rights reserved.
//

#import "EIBMDataSourceManager.h"

@implementation EIBMDataSourceManager
- (void)setUserDefaults:(id)userDefaults forKey:(NSString *)key
{
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:userDefaults];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:data forKey:key];
    [defaults synchronize];
}

- (id)getUserDefaultsByKey:(NSString *)key
{
    if ([[[NSUserDefaults standardUserDefaults] dictionaryRepresentation].allKeys containsObject:key]) {
        return [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:key]];
    }
    return nil;
}
@end
