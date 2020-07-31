//
//  NewsModel.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 31/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMNewsModel : EIBMBaseModel

/**
 时间
 */
@property (nonatomic, copy) NSString *createTime;

/**
 图片
 */
@property (nonatomic, copy) NSString *cover;

/**
 标题
 */
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSNumber *mainId;

@end

NS_ASSUME_NONNULL_END
