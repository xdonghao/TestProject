//
//  NewsDetailModel.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 05/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMNewsDetailModel : EIBMBaseModel

@property (nonatomic, copy) NSString *metadesc;

/**
 图片
 */
@property (nonatomic, copy) NSString *imgurl;

/**
 标题
 */
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSNumber *mainId;


/**
 时间
 */
@property (nonatomic, copy) NSString *created;

@property (nonatomic, copy) NSString *images;

@property (nonatomic, copy) NSString *introtext;

@property (nonatomic, copy) NSString *xreference;

@end

NS_ASSUME_NONNULL_END
