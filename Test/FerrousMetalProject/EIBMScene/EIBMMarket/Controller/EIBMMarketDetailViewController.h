//
//  MarketDetailViewController.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 01/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMMarketDetailViewController : EIBMBaseTableViewController
@property (nonatomic, assign) NSInteger newType;
@property (nonatomic, copy) NSString *codeString;
@property (nonatomic, copy) NSString *nameString;

@end

NS_ASSUME_NONNULL_END
