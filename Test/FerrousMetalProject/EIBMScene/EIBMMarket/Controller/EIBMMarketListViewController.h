//
//  MarketListViewController.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 01/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseCollectionViewController.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum : NSUInteger {
    MarketListSelf = 0,      //
    MarketListNengYuan,           //
    MarketListGuZhi,
    MarketListJinShu,
    MarketListNongChanPin,      //
} MarketListType;

@interface EIBMMarketListViewController : EIBMBaseCollectionViewController

/**
 是否是自选列表
 */
@property (nonatomic, assign) MarketListType type;
@property (nonatomic, copy) NSString *prod_code;
@property (nonatomic, copy) NSString *url;
@end

NS_ASSUME_NONNULL_END
