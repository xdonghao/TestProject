//
//  NSObject+Common.h
//  Coding_iOS
//
//  Created by 王 原闯 on 14-7-31.
//  Copyright (c) 2014年 Coding. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Common)

+ (instancetype)acsm;

#pragma mark Tip M

+ (NSString *)tipFromError:(NSError *)error;

+ (BOOL)showError:(NSError *)error;
+ (void)showHudTipStr:(NSString *)tipStr;

+ (instancetype)showHUDQueryStr:(NSString *)titleStr;
+ (instancetype)showHUDQueryStr:(NSString *)titleStr inView:(UIView *)view;
+ (void)showHudSuccessStr:(NSString *)success;
+ (void)showHudErrorStr:(NSString *)errorStr;
+ (void)showHudError:(NSError *)error;

+ (NSUInteger)hideHUDQuery;
+ (NSUInteger)hideHUDQueryInView:(UIView *)view;

#pragma mark File M
//获取fileName的完整地址
+ (NSString* )pathInCacheDirectory:(NSString *)fileName;
//创建缓存文件夹
+ (BOOL)createDirInCache:(NSString *)dirName;

//图片
+ (BOOL)saveImage:(UIImage *)image imageName:(NSString *)imageName inFolder:(NSString *)folderName;
+ (NSData*)loadImageDataWithName:( NSString *)imageName inFolder:(NSString *)folderName;



@end
