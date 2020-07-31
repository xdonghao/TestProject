//
//  MarketSearchModel.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMMarketSearchModel : EIBMBaseModel

@property (nonatomic, copy) NSString *showCode;

@property (nonatomic, copy) NSString *code;

@property (nonatomic, copy) NSString *name;

@end

NS_ASSUME_NONNULL_END
