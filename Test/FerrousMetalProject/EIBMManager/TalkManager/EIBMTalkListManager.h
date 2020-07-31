//
//  TalkListManager.h
//  EIBMGoodsProject
//
//  Created by MAC on 19/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB/FMDatabase.h>
#import "TalkListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMTalkListManager : NSObject{
    FMDatabase * fmdb;
}

+(EIBMTalkListManager *)shared;

#pragma 论坛列表相关

-(void)initSqlite;

-(void)insertWithTalkListObjects:(NSArray *)areaObjecs;

-(void)addDBDataWithTalkListObjects:(NSArray *)areaObjecs;

-(NSArray *)getTalkList;

-(void)delateObjectWithAritcleID:(NSNumber *)articleId;

@end

NS_ASSUME_NONNULL_END
