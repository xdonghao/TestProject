//
//  NewsChatManager.h
//  EIBMBestMetal
//
//  Created by MAC on 19/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDatabase.h>
#import "NewsChatModel.h"
#import "EIBMNewsOtherModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EIBMNewsChatManager : NSObject{
    FMDatabase * fmdb;
}

+(EIBMNewsChatManager *)shared;

-(void)initSqlite;
-(void)insertWithNewsChatListObjects:(NewsChatModel *)model;
-(NSArray *)getNewsChatListWithNewsId:(NSNumber *)articleId;

//新闻收藏
+ (void)addNewsToCollectList:(EIBMNewsOtherModel *)model;
+ (void)delNewsFromCollectList:(EIBMNewsOtherModel *)model;
+ (NSArray *)getNewsToCollectList;
//新闻评论黑名单
+ (void)addBlackChatMessageList:(NewsChatModel *)model;
+ (void)delBlackChatMessageList:(NewsChatModel *)model;
+ (NSArray *)getBlackChatMessageList;
+ (NSArray *)getBlackChatMessageListWithNewsId:(NSNumber *)newsId;

@end

NS_ASSUME_NONNULL_END
