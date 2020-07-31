//
//  ForumReplyManager.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDatabase.h>
NS_ASSUME_NONNULL_BEGIN

@interface EIBMForumReplyManager : NSObject{
    FMDatabase * fmdb;
}

+(EIBMForumReplyManager *)shared;

#pragma 论坛评论相关

-(void)initReplySqlite;

-(void)addDBDataWithForumReplyObjects:(NSArray *)areaObjecs;

-(NSArray *)getForumReplyListWithArticleId:(NSNumber *)articleId;

@end

NS_ASSUME_NONNULL_END
