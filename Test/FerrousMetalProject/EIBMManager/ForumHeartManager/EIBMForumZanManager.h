//
//  NewsChatManager.h
//  EIBMBestMetal
//
//  Created by MAC on 19/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EIBMForumListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMForumZanManager : NSObject

//新闻收藏
+ (void)addForumToZanList:(EIBMForumListModel *)model;
+ (void)delForumFromZanList:(EIBMForumListModel *)model;
+ (NSArray *)getAllZanForum;


@end

NS_ASSUME_NONNULL_END
