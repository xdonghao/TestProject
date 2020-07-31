//
//  NewsChatModel.h
//  EIBMBestMetal
//
//  Created by MAC on 19/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface NewsChatModel : EIBMBaseModel

/**
 发布时间
 */
@property (nonatomic, copy) NSNumber *created;

/**
 内容
 */
@property (nonatomic, copy) NSString *content;


/**
 新闻ID
 */
@property (nonatomic, copy) NSNumber *newsId;


/**
 发布者昵称
 */
@property (nonatomic, copy) NSString *userName;

/**
 发布者头像
 */
@property (nonatomic, copy) NSString *userImageUrl;

@end

NS_ASSUME_NONNULL_END
