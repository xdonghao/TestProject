//
//  ForumReplyManager.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMForumReplyManager.h"
#import "EIBMForumListModel.h"
#import <FMDB/FMDatabaseAdditions.h>
static NSString * forumReplyName = @"forumReply";

static NSString * KEY_TABLE_ARTICLEID = @"articleId";
static NSString * KEY_TABLE_ARTICLEUSERNAME = @"userName";
static NSString * KEY_TABLE_ARTICLEUSERIMAGEURL = @"userImageUrl";
static NSString * KEY_TABLE_ARTICLECONTENT = @"content";
static NSString * KEY_TABLE_ARTICLETIME = @"created";

@implementation EIBMForumReplyManager

+(EIBMForumReplyManager *)shared{
    static EIBMForumReplyManager * areaSqlite = nil;
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        areaSqlite = [[EIBMForumReplyManager alloc] init];
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

-(void)initReplySqlite{
    NSString * path = [self pathForFileName:@"forumReply.db"];
    fmdb = [FMDatabase databaseWithPath:path];
    if ([fmdb open]) {
        //   DLog(@"打开数据库成功！path%@",path);
        if (![fmdb tableExists:forumReplyName]) {
            //  DLog(@"user表不存在,新建");
            NSString *sql = [NSString stringWithFormat:@"CREATE TABLE %@(%@ INTEGER,%@ TEXT,%@ INTEGER,%@ TEXT,%@ TEXT);",forumReplyName,KEY_TABLE_ARTICLEID,KEY_TABLE_ARTICLEUSERNAME,KEY_TABLE_ARTICLETIME,KEY_TABLE_ARTICLEUSERIMAGEURL,KEY_TABLE_ARTICLECONTENT];
            if ([fmdb executeUpdate:sql]) {
                //   DLog(@"创建表格%@成功！",tableName);
            }
        }
    }else{
        //DLog(@"打开数据库失败！path%@",path);
    }
    [fmdb close];
}

-(void)addDBDataWithForumReplyObjects:(NSArray *)areaObjecs{
    if (areaObjecs&&areaObjecs.count>0) {
        NSString * path = [self pathForFileName:@"forumReply.db"];
        fmdb = [FMDatabase databaseWithPath:path];
        [self initReplySqlite];
        if ([fmdb open]) {
            for (int ii = 0; ii<areaObjecs.count; ii++) {
                EIBMForumListModel * object = [areaObjecs objectAtIndex:ii];
                
                NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@,%@,%@,%@,%@) VALUES('%@', '%@', '%@', '%@', '%@')",forumReplyName,KEY_TABLE_ARTICLEUSERNAME,KEY_TABLE_ARTICLETIME,KEY_TABLE_ARTICLEUSERIMAGEURL,KEY_TABLE_ARTICLECONTENT,KEY_TABLE_ARTICLEID,object.userName,object.created,object.userImageUrl,object.content,object.articleId];
                BOOL ret = [fmdb executeUpdate:sql];
                if (!ret) {
                    
                }
            }
        }else{
            
        }
    }
}

-(NSArray *)getForumReplyListWithArticleId:(NSNumber *)articleId{
    NSMutableArray * cityList = [NSMutableArray array];
    if ([fmdb open]) {
        if ([fmdb tableExists:forumReplyName]) {
            NSString * sql = [NSString stringWithFormat:@"select * from %@ where articleId = '%@'",forumReplyName,articleId];
//            NSString * sql = [NSString stringWithFormat:@"select * from %@",forumReplyName];
            FMResultSet * rs = [fmdb executeQuery:sql];
            while ([rs next]) {
                EIBMForumListModel * object = [[EIBMForumListModel alloc]init];
                object.articleId = [NSNumber numberWithInt:[rs intForColumn:KEY_TABLE_ARTICLEID]];
                object.userName = [rs stringForColumn:KEY_TABLE_ARTICLEUSERNAME];
                object.created = [NSNumber numberWithInt:[rs intForColumn:KEY_TABLE_ARTICLETIME]];
                object.userImageUrl = [rs stringForColumn:KEY_TABLE_ARTICLEUSERIMAGEURL];
                object.content = [rs stringForColumn:KEY_TABLE_ARTICLECONTENT];
                [cityList addObject:object];
            }
        }
    }
    return cityList;
}

@end
