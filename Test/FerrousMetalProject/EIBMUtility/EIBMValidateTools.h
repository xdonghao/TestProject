//
//  ValidateTools.h
//  MusicShow
//
//  Created by daodao on 15/12/12.
//  Copyright © 2015年 PhoenixDaoDao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EIBMValidateTools : NSObject

/**
 *  验证手机号
 *
 *  @param str 手机号
 *
 *  @return 结果
 */
+ (BOOL)isValidateUserPhone:(NSString *)str;

/**
 *  验证邮箱格式
 *
 *  @param email 邮箱地址
 *
 *  @return 结果
 */
+ (BOOL)isValidateEmail:(NSString *)email;

/**
 *  验证密码
 *
 *  @param passwd 密码
 *
 *  @return 结果
 */
+ (BOOL)isValidatePasswd:(NSString *)passwd;

/**
 *  验证姓名
 *
 *  @param passwd 姓名
 *
 *  @return 结果
 */
+ (BOOL)isValidateName:(NSString*)name;

/**
 *  判断是否是昵称
 *
 *  @param nickname 昵称
 *
 *  @return 结果
 */
+ (BOOL)isValidateNickname:(NSString*)nickname;

/**
 *  验证是否包含emoji表情
 *
 *  @param string 字符串
 *
 *  @return 结果
 */
+ (BOOL)isContainsEmoji:(NSString *)string;

/**
 *  验证是否为有效的身份证号码
 *
 *  @param identityCard 身份证号码
 *
 *  @return 结果
 */
+ (BOOL)isValidateIdentityCard:(NSString *)identityCard;

/**
 *  验证是否为有效的银行卡账号
 *
 *  @param value 账号
 *
 *  @return 结果
 */
+ (BOOL)isValidCreditNumber:(NSString*)value;

@end
