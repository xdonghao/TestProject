//
//  TalkDetailManager.h
//  EIBMGoodsProject
//
//  Created by MAC on 19/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDatabase.h>
NS_ASSUME_NONNULL_BEGIN

@interface EIBMTalkDetailManager : NSObject{
    FMDatabase * fmdb;
}

+(EIBMTalkDetailManager *)shared;

#pragma 论坛列表相关

-(void)initTalkSqlite;

-(void)addDBDataWithTalkObjects:(NSArray *)areaObjecs;

-(NSArray *)getTalkListWithTalkId:(NSNumber *)talkId;

@end

NS_ASSUME_NONNULL_END
