//
//  ForumManager.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDatabase.h>

NS_ASSUME_NONNULL_BEGIN

@interface EIBMForumManager : NSObject{
    FMDatabase * fmdb;
}

+(EIBMForumManager *)shared;

#pragma 论坛列表相关

-(void)initSqlite;

-(void)insertWithForumListObjects:(NSArray *)areaObjecs;

-(void)addDBDataWithForumListObjects:(NSArray *)areaObjecs;

-(NSArray *)getForumList;

-(void)delateObjectWithAritcleID:(NSNumber *)articleId;

//收藏列表
+ (void)setForumList:(id)object;
+ (NSArray *)getForumList;


//屏蔽列表
+ (void)setShieldForumList:(id)object;
+ (NSArray *)getShieldForumList;

@end

NS_ASSUME_NONNULL_END
