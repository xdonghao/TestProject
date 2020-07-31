//
//  TalkDetailManager.m
//  EIBMGoodsProject
//
//  Created by MAC on 19/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMTalkDetailManager.h"
#import <FMDB/FMDatabaseAdditions.h>
#import "EIBMTalkDetailModel.h"

static NSString * talkDetailName = @"talkDetail";

static NSString * KEY_TABLE_ARTICLEID = @"talkId";
static NSString * KEY_TABLE_ARTICLEUSERNAME = @"userName";
static NSString * KEY_TABLE_ARTICLEUSERIMAGEURL = @"userImageUrl";
static NSString * KEY_TABLE_ARTICLECONTENT = @"content";
static NSString * KEY_TABLE_ARTICLETIME = @"created";

@implementation EIBMTalkDetailManager

+(EIBMTalkDetailManager *)shared{
    static EIBMTalkDetailManager * areaSqlite = nil;
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        areaSqlite = [[EIBMTalkDetailManager alloc] init];
    });
    return areaSqlite;
}

-(NSString *)pathForFileName:(NSString *)fileName{
    if (fileName&&fileName.length>2) {
        //        NSArray * pathArray = [fileName componentsSeparatedByString:@"."];
        //        return [[NSBundle mainBundle]pathForResource:[pathArray objectAtIndex:0] ofType:[pathArray objectAtIndex:1]];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:fileName];
        return dbPath;
    }
    return nil;
}

#pragma 论坛评论相关

-(void)initTalkSqlite{
    NSString * path = [self pathForFileName:@"talkDetail.db"];
    fmdb = [FMDatabase databaseWithPath:path];
    if ([fmdb open]) {
        //   DLog(@"打开数据库成功！path%@",path);
        if (![fmdb tableExists:talkDetailName]) {
            //  DLog(@"user表不存在,新建");
            NSString *sql = [NSString stringWithFormat:@"CREATE TABLE %@(%@ INTEGER,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT);",talkDetailName,KEY_TABLE_ARTICLEID,KEY_TABLE_ARTICLEUSERNAME,KEY_TABLE_ARTICLETIME,KEY_TABLE_ARTICLEUSERIMAGEURL,KEY_TABLE_ARTICLECONTENT];
            if ([fmdb executeUpdate:sql]) {
                //   DLog(@"创建表格%@成功！",tableName);
            }
        }
    }else{
        //DLog(@"打开数据库失败！path%@",path);
    }
    [fmdb close];
}

-(void)addDBDataWithTalkObjects:(NSArray *)areaObjecs{
    if (areaObjecs&&areaObjecs.count>0) {
        NSString * path = [self pathForFileName:@"talkDetail.db"];
        fmdb = [FMDatabase databaseWithPath:path];
        [self initTalkSqlite];
        if ([fmdb open]) {
            for (int ii = 0; ii<areaObjecs.count; ii++) {
                EIBMTalkDetailModel * object = [areaObjecs objectAtIndex:ii];
                
                NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@,%@,%@,%@,%@) VALUES('%@', '%@', '%@', '%@', '%@')",talkDetailName,KEY_TABLE_ARTICLEUSERNAME,KEY_TABLE_ARTICLETIME,KEY_TABLE_ARTICLEUSERIMAGEURL,KEY_TABLE_ARTICLECONTENT,KEY_TABLE_ARTICLEID,object.userName,object.created,object.userImageUrl,object.content,object.talkId];
                BOOL ret = [fmdb executeUpdate:sql];
                if (!ret) {
                    
                }
            }
        }else{
            
        }
    }
}

-(NSArray *)getTalkListWithTalkId:(NSNumber *)talkId{
    NSMutableArray * cityList = [NSMutableArray array];
    if ([fmdb open]) {
        if ([fmdb tableExists:talkDetailName]) {
            NSString * sql = [NSString stringWithFormat:@"select * from %@ where talkId = '%@'",talkDetailName,talkId];
            //            NSString * sql = [NSString stringWithFormat:@"select * from %@",forumReplyName];
            FMResultSet * rs = [fmdb executeQuery:sql];
            while ([rs next]) {
                EIBMTalkDetailModel * object = [[EIBMTalkDetailModel alloc]init];
                object.talkId = [NSNumber numberWithInt:[rs intForColumn:KEY_TABLE_ARTICLEID]];
                object.userName = [rs stringForColumn:KEY_TABLE_ARTICLEUSERNAME];
                object.created = [rs stringForColumn:KEY_TABLE_ARTICLETIME];
                object.userImageUrl = [rs stringForColumn:KEY_TABLE_ARTICLEUSERIMAGEURL];
                object.content = [rs stringForColumn:KEY_TABLE_ARTICLECONTENT];
                [cityList addObject:object];
            }
        }
    }
    return cityList;
}

@end
