//
//  TalkListManager.m
//  EIBMGoodsProject
//
//  Created by MAC on 19/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMTalkListManager.h"
#import <FMDB/FMDatabaseAdditions.h>

static NSString * talkListName = @"talkList";

static NSString * KEY_TABLE_TALKID = @"talkId";
static NSString * KEY_TABLE_TALKTYPE = @"type";
static NSString * KEY_TABLE_TALKUSERIMAGEURL = @"imageUrl";
static NSString * KEY_TABLE_TALKTITLE = @"title";
static NSString * KEY_TABLE_TALKTIME = @"created";
static NSString * KEY_TABLE_TALKImageData = @"imageData";
//static NSString * KEY_TABLE_TALKImageDataLength = @"imageDataLength";
@implementation EIBMTalkListManager

+(EIBMTalkListManager *)shared{
    static EIBMTalkListManager * areaSqlite = nil;
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        areaSqlite = [[EIBMTalkListManager alloc] init];
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
    NSString * path = [self pathForFileName:@"talkList.db"];
    fmdb = [FMDatabase databaseWithPath:path];
    if ([fmdb open]) {
        //   DLog(@"打开数据库成功！path%@",path);
        if (![fmdb tableExists:talkListName]) {
            //  DLog(@"user表不存在,新建");
            NSString *sql = [NSString stringWithFormat:@"CREATE TABLE %@(%@ integer primary key AUTOINCREMENT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT,%@ TEXT);",talkListName,KEY_TABLE_TALKID,KEY_TABLE_TALKTYPE,KEY_TABLE_TALKTIME,KEY_TABLE_TALKUSERIMAGEURL,KEY_TABLE_TALKTITLE,KEY_TABLE_TALKImageData];
            if ([fmdb executeUpdate:sql]) {
                //   DLog(@"创建表格%@成功！",tableName);
            }
        }
    }else{
        //DLog(@"打开数据库失败！path%@",path);
    }
    [fmdb close];
}

-(void)addDBDataWithTalkListObjects:(NSArray *)areaObjecs{
    if (areaObjecs&&areaObjecs.count>0) {
        NSString * path = [self pathForFileName:@"talkList.db"];
        fmdb = [FMDatabase databaseWithPath:path];
        [self initSqlite];
        if ([fmdb open]) {
            for (int ii = 0; ii<areaObjecs.count; ii++) {
                TalkListModel * object = [areaObjecs objectAtIndex:ii];
                
//                NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@,%@,%@,%@) VALUES('%@', '%@', '%@', '%@')",talkListName,KEY_TABLE_TALKTYPE,KEY_TABLE_TALKTIME,KEY_TABLE_TALKUSERIMAGEURL,KEY_TABLE_TALKTITLE,object.type,object.created,object.imageUrl,object.title];
                NSString *encodedImageStr = [object.imageData base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
                NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@,%@,%@,%@,%@) VALUES('%@', '%@', '%@', '%@', '%@')",talkListName,KEY_TABLE_TALKTYPE,KEY_TABLE_TALKTIME,KEY_TABLE_TALKUSERIMAGEURL,KEY_TABLE_TALKTITLE,KEY_TABLE_TALKImageData,object.type,object.created,object.imageUrl,object.title,encodedImageStr];
                BOOL ret = [fmdb executeUpdate:sql];
                if (!ret) {
                    
                }
            }
        }else{
            
        }
    }
}

-(void)insertWithTalkListObjects:(NSArray *)areaObjecs{
    if (areaObjecs&&areaObjecs.count>0) {
        NSString * path = [self pathForFileName:@"talkList.db"];
        fmdb = [FMDatabase databaseWithPath:path];
        [self initSqlite];
        if ([fmdb open]) {
            for (int ii = 0; ii<areaObjecs.count; ii++) {
                TalkListModel * object = [areaObjecs objectAtIndex:ii];
                NSString *sql = [NSString stringWithFormat:@"INSERT INTO %@(%@,%@,%@,%@,%@) VALUES('%@', '%@', '%@', '%@', '%@')",talkListName,KEY_TABLE_TALKTYPE,KEY_TABLE_TALKTIME,KEY_TABLE_TALKUSERIMAGEURL,KEY_TABLE_TALKTITLE,KEY_TABLE_TALKID,object.type,object.created,object.imageUrl,object.title,object.talkId];
                BOOL ret = [fmdb executeUpdate:sql];
                if (!ret) {
                    
                }
            }
        }else{
            
        }
    }
}

-(NSArray *)getTalkList{
    NSMutableArray * cityList = [NSMutableArray array];
    if ([fmdb open]) {
        if ([fmdb tableExists:talkListName]) {
            NSString * sql = [NSString stringWithFormat:@"select * from %@",talkListName];
            FMResultSet * rs = [fmdb executeQuery:sql];
            while ([rs next]) {
                TalkListModel * object = [[TalkListModel alloc]init];
                object.talkId = [NSNumber numberWithInt:[rs intForColumn:KEY_TABLE_TALKID]];
                object.type = [rs stringForColumn:KEY_TABLE_TALKTYPE];
                object.created = [rs stringForColumn:KEY_TABLE_TALKTIME];
                object.imageUrl = [rs stringForColumn:KEY_TABLE_TALKUSERIMAGEURL];
                object.title = [rs stringForColumn:KEY_TABLE_TALKTITLE];
                NSString *by = [rs stringForColumn:KEY_TABLE_TALKImageData];
                if (by) {
                     object.imageData = [[NSData alloc] initWithBase64EncodedString:by options:NSDataBase64Encoding64CharacterLineLength];
                }
                [cityList addObject:object];
            }
        }
    }
    return cityList;
}

-(void)delateObjectWithAritcleID:(NSNumber *)talkId {
    if (talkId) {
        if ([fmdb open]) {
            if ([fmdb tableExists:talkListName]) {
                NSString *sql = @"delete from talkList where talkId = ?";
                [fmdb executeUpdate:sql, talkId];
                
            }
        }
    }
}
@end
