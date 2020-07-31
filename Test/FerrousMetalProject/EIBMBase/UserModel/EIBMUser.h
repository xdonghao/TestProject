//
//  ACSMUser.h
//  FarmRecovery
//
//  Created by 董浩 on 2016/10/19.
//  Copyright © 2016年 donghao. All rights reserved.
//

#import "JKDBModel.h"

@interface EIBMUser : JKDBModel

/** 客户账号 */
@property (nonatomic, copy) NSString *userId;
/** 客户密码 */
@property (nonatomic, copy) NSString *password;
/** 用户名 */
@property (nonatomic, copy) NSString *userName;

/** 性别 1 男 2 女 3保密*/
@property (nonatomic, copy) NSString *sex;

@property (nonatomic, copy) NSString *birthday;

@property (nonatomic, copy) NSString *remark;

//@property (nonatomic, strong) NSMutableArray *collectArray;
@property (nonatomic, copy) NSString *collectStrings;

@property (nonatomic, strong) NSData *headerImageData;


@end
