//
//  NewsFlashModel.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 04/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMNewsFlashModel : EIBMBaseModel

// 是否是展开的
@property (nonatomic, assign) BOOL isExpanded;

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *time;

@end

NS_ASSUME_NONNULL_END
