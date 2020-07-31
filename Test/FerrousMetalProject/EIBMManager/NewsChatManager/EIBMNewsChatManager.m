//
//  NewsChatManager.m
//  EIBMBestMetal
//
//  Created by MAC on 19/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMNewsChatManager.h"
#import <FMDB/FMDatabaseAdditions.h>

static NSString * forumListName = @"newschatlist";

static NSString * KEY_TABLE_ARTICLEID = @"newsId";
static NSString * KEY_TABLE_ARTICLEUSERNAME = @"userName";
static NSString * KEY_TABLE_ARTICLEUSERIMAGEURL = @"userImageUrl";
static NSString * KEY_TABLE_ARTICLECONTENT = @"content";
static NSString * KEY_TABLE_ARTICLETIME = @"created";

@implementation EIBMNewsChatManager

+(EIBMNewsChatManager *)shared{
    static EIBMNewsChatManager * areaSqlite = nil;
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        areaSqlite = [[EIBMNewsChatManager alloc] init];
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
    NSString * path = [self pathForFileName:@"newschatlist.db"];
    fmdb = [FMDatabase databaseWithPath:path];
    if ([fmdb open]) {
        //   DLog(@"打开数据库成功！path%@",path);
        if (![fmdb tableExists:forumListName]) {
            //  DLog(@"user表不存在,新建");
            NSString *sql = [NSString stringWithFormat:@"CREATE TABLE %@(%@ integer,%@ TEXT,%@ INTEGER,%@ TEXT,%@ TEXT);",forumListName,KEY_TABLE_ARTICLEID,KEY_TABLE_ARTICLEUSERNAME,KEY_TABLE_ARTICLETIME,KEY_TABLE_ARTICLEUSERIMAGEURL,KEY_TABLE_ARTICLECONTENT];
            if ([fmdb executeUpdate:sql]) {
                //   DLog(@"创建表格%@成功！",tableName);
            }
        }
    }else{
        //DLog(@"打开数据库失败！path%@",path);
    }
    [fmdb close];
}

-(void)insertWithNewsChatListObjects:(NewsChatModel *)model{
    if (model) {
        NSString * path = [self pathForFileName:@"newschatlist.db"];
        fmdb = [FMDatabase databaseWithPath:path];
        [self initSqlite];
        if ([fmdb open]) {
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@,%@,%@,%@,%@) VALUES('%@', '%@', '%@', '%@', '%@')",forumListName,KEY_TABLE_ARTICLEUSERNAME,KEY_TABLE_ARTICLETIME,KEY_TABLE_ARTICLEUSERIMAGEURL,KEY_TABLE_ARTICLECONTENT,KEY_TABLE_ARTICLEID,model.userName,model.created,model.userImageUrl,model.content,model.newsId];
            BOOL ret = [fmdb executeUpdate:sql];
            if (!ret) {
                
            }
        }else{
            
        }
    }
}

-(NSArray *)getNewsChatListWithNewsId:(NSNumber *)articleId{
    NSMutableArray * cityList = [NSMutableArray array];
    if ([fmdb open]) {
        if ([fmdb tableExists:forumListName]) {
            NSString * sql = [NSString stringWithFormat:@"select * from %@ where %@ = '%@'",forumListName,KEY_TABLE_ARTICLEID,articleId];
            FMResultSet * rs = [fmdb executeQuery:sql];
            while ([rs next]) {
                NewsChatModel * object = [[NewsChatModel alloc]init];
                object.newsId = [NSNumber numberWithInteger:[rs longLongIntForColumn:KEY_TABLE_ARTICLEID]];
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



+ (void)addNewsToCollectList:(EIBMNewsOtherModel *)model
{
    NSMutableArray *muarr = [NSMutableArray arrayWithArray:[EIBMNewsChatManager getNewsToCollectList]];
    
    if ([muarr containsObject:model]) {
        
    } else {
        [muarr addObject:model];
        NSString *key = [NSString stringWithFormat:@"News_Collect_List_%@",[EIBMUserUtil sharedUserUtil].user.userId];
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:muarr];
        [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)delNewsFromCollectList:(EIBMNewsOtherModel *)model {
    NSMutableArray *muarr = [NSMutableArray arrayWithArray:[EIBMNewsChatManager getNewsToCollectList]];
    if ([muarr containsObject:model]) {
        [muarr removeObject:model];
        NSString *key = [NSString stringWithFormat:@"News_Collect_List_%@",[EIBMUserUtil sharedUserUtil].user.userId];
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:muarr];
        [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        
    }
}

+ (NSArray *)getNewsToCollectList
{
    
    NSString *key = [NSString stringWithFormat:@"News_Collect_List_%@",[EIBMUserUtil sharedUserUtil].user.userId];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:key]];
    
    if (array) {
        return array;
    }
    
    return nil;
}

+ (void)addBlackChatMessageList:(NewsChatModel *)model
{
    NSMutableArray *muarr = [NSMutableArray arrayWithArray:[EIBMNewsChatManager getBlackChatMessageList]];
    
    if ([muarr containsObject:model]) {
        
    } else {
        [muarr addObject:model];
        NSString *key = [NSString stringWithFormat:@"News_BlackChat_List_%@",[EIBMUserUtil sharedUserUtil].user.userId];
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:muarr];
        [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

+ (void)delBlackChatMessageList:(NewsChatModel *)model {
    NSMutableArray *muarr = [NSMutableArray arrayWithArray:[EIBMNewsChatManager getBlackChatMessageList]];
    if ([muarr containsObject:model]) {
        [muarr removeObject:model];
        NSString *key = [NSString stringWithFormat:@"News_BlackChat_List_%@",[EIBMUserUtil sharedUserUtil].user.userId];
        NSData *encodedObject = [NSKeyedArchiver archivedDataWithRootObject:muarr];
        [[NSUserDefaults standardUserDefaults] setObject:encodedObject forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    } else {
        
    }
}

+ (NSArray *)getBlackChatMessageList
{
    
    NSString *key = [NSString stringWithFormat:@"News_BlackChat_List_%@",[EIBMUserUtil sharedUserUtil].user.userId];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults] objectForKey:key]];
    
    if (array) {
        return array;
    }
    
    return nil;
}

+ (NSArray *)getBlackChatMessageListWithNewsId:(NSNumber *)newsId {
    NSMutableArray *muarr = [NSMutableArray arrayWithArray:[EIBMNewsChatManager getBlackChatMessageList]];
    NSMutableArray *modelArr = [NSMutableArray array];
    for (NewsChatModel *model in muarr) {
        if ([model.newsId integerValue] == [newsId integerValue]) {
            [modelArr addObject:model];
        }
    }
    return modelArr;
}

@end
