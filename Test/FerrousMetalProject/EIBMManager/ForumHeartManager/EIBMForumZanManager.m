//
//  NewsChatManager.m
//  EIBMBestMetal
//
//  Created by MAC on 19/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMForumZanManager.h"

@implementation EIBMForumZanManager


+ (void)addForumToZanList:(EIBMForumListModel *)model
{
    NSMutableArray *muarr = [NSMutableArray arrayWithArray:[EIBMForumZanManager getAllZanForum]];
    
    if ([muarr containsObject:model]) {
        
    } else {
        [muarr addObject:model];
        NSString *key = [NSString stringWithFormat:@"Forum_Zan_List_%@",[EIBMUserUtil sharedUserUtil].user.userId];
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:muarr];
        [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)delForumFromZanList:(EIBMForumListModel *)model {
    NSMutableArray *muarr = [NSMutableArray arrayWithArray:[EIBMForumZanManager getAllZanForum]];
    if ([muarr containsObject:model]) {
        [muarr removeObject:model];
        NSString *key = [NSString stringWithFormat:@"Forum_Zan_List_%@",[EIBMUserUtil sharedUserUtil].user.userId];
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:muarr];
        [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        
    }
}

+ (NSArray *)getAllZanForum
{
    
    NSString *key = [NSString stringWithFormat:@"Forum_Zan_List_%@",[EIBMUserUtil sharedUserUtil].user.userId];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:key]];
    
    if (array) {
        return array;
    }
    
    return nil;
}

@end
