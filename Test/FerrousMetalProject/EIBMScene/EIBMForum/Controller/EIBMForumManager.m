//
//  ForumManager.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMForumManager.h"
#import "EIBMForumListModel.h"
#import <FMDB/FMDatabaseAdditions.h>

static NSString * forumListName = @"forumlist";

static NSString * KEY_TABLE_ARTICLEID = @"articleId";
static NSString * KEY_TABLE_ARTICLEUSERNAME = @"userName";
static NSString * KEY_TABLE_ARTICLEUSERIMAGEURL = @"userImageUrl";
static NSString * KEY_TABLE_ARTICLECONTENT = @"content";
static NSString * KEY_TABLE_ARTICLETIME = @"created";

@implementation EIBMForumManager

+(EIBMForumManager *)shared{
    static EIBMForumManager * areaSqlite = nil;
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        areaSqlite = [[EIBMForumManager alloc] init];
    });
    return areaSqlite;
}

-(NSString *)pathForFileName:(NSString *)fileName{
    if (fileName&&fileName.length>2) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [paths objectAtIndex:0];
        NSString *dbPath = [documentDirectory stringByAppendingPathComponent:fileName];
        return dbPath;
    }
    return nil;
}

#pragma 论坛列表相关

-(void)initSqlite{
    NSString * path = [self pathForFileName:@"forumlist.db"];
    fmdb = [FMDatabase databaseWithPath:path];
    if ([fmdb open]) {
        //   DLog(@"打开数据库成功！path%@",path);
        if (![fmdb tableExists:forumListName]) {
            //  DLog(@"user表不存在,新建");
            NSString *sql = [NSString stringWithFormat:@"CREATE TABLE %@(%@ integer primary key AUTOINCREMENT,%@ TEXT,%@ INTEGER,%@ TEXT,%@ TEXT);",forumListName,KEY_TABLE_ARTICLEID,KEY_TABLE_ARTICLEUSERNAME,KEY_TABLE_ARTICLETIME,KEY_TABLE_ARTICLEUSERIMAGEURL,KEY_TABLE_ARTICLECONTENT];
            if ([fmdb executeUpdate:sql]) {
                //   DLog(@"创建表格%@成功！",tableName);
            }
        }
    }else{
        //DLog(@"打开数据库失败！path%@",path);
    }
    [fmdb close];
}

-(void)addDBDataWithForumListObjects:(NSArray *)areaObjecs{
    if (areaObjecs&&areaObjecs.count>0) {
        NSString * path = [self pathForFileName:@"forumlist.db"];
        fmdb = [FMDatabase databaseWithPath:path];
        [self initSqlite];
        if ([fmdb open]) {
            for (int ii = 0; ii<areaObjecs.count; ii++) {
                EIBMForumListModel * object = [areaObjecs objectAtIndex:ii];
                
                NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@,%@,%@,%@) VALUES('%@', '%@', '%@', '%@')",forumListName,KEY_TABLE_ARTICLEUSERNAME,KEY_TABLE_ARTICLETIME,KEY_TABLE_ARTICLEUSERIMAGEURL,KEY_TABLE_ARTICLECONTENT,object.userName,object.created,object.userImageUrl,object.content];
                [fmdb executeUpdate:sql];
            }
        }else{
            
        }
    }
}

-(void)insertWithForumListObjects:(NSArray *)areaObjecs{
    if (areaObjecs&&areaObjecs.count>0) {
        NSString * path = [self pathForFileName:@"forumlist.db"];
        fmdb = [FMDatabase databaseWithPath:path];
        [self initSqlite];
        if ([fmdb open]) {
            for (int ii = 0; ii<areaObjecs.count; ii++) {
                EIBMForumListModel * object = [areaObjecs objectAtIndex:ii];
                NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@,%@,%@,%@,%@) VALUES('%@', '%@', '%@', '%@', '%@')",forumListName,KEY_TABLE_ARTICLEUSERNAME,KEY_TABLE_ARTICLETIME,KEY_TABLE_ARTICLEUSERIMAGEURL,KEY_TABLE_ARTICLECONTENT,KEY_TABLE_ARTICLEID,object.userName,object.created,object.userImageUrl,object.content,object.articleId];
                BOOL ret = [fmdb executeUpdate:sql];
                if (!ret) {
                    
                }
            }
        }else{
            
        }
    }
}

-(NSArray *)getForumList{
    NSMutableArray * cityList = [NSMutableArray array];
    if ([fmdb open]) {
        if ([fmdb tableExists:forumListName]) {
            NSString * sql = [NSString stringWithFormat:@"select * from %@",forumListName];
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

-(void)delateObjectWithAritcleID:(NSNumber *)articleId {
    if (articleId) {
        if ([fmdb open]) {
            if ([fmdb tableExists:forumListName]) {
                NSString *sql = @"delete from forumlist where articleId = ?";
                [fmdb executeUpdate:sql, articleId];
                
            }
        }
    }
}


+ (void)setForumList:(id)object
{
    NSString *key = [NSString stringWithFormat:@"Forum_Collect_List_%@",[EIBMUserUtil sharedUserUtil].user.userId];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (NSArray *)getForumList
{
    
    NSString *key = [NSString stringWithFormat:@"Forum_Collect_List_%@",[EIBMUserUtil sharedUserUtil].user.userId];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:key]];
    
    if (array) {
        return array;
    }
    
    return nil;
}

+ (void)setShieldForumList:(id)object
{
    NSString *key = [NSString stringWithFormat:@"Forum_Shield_List_%@",[EIBMUserUtil sharedUserUtil].user.userId];
    NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:object];
    [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (NSArray *)getShieldForumList
{
    
    NSString *key = [NSString stringWithFormat:@"Forum_Shield_List_%@",[EIBMUserUtil sharedUserUtil].user.userId];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:key]];
    
    if (array) {
        return array;
    }
    
    return nil;
}

@end
