//
//  MarketKLineTableViewCell.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 01/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseTableViewCell.h"
#import "SimpleKLineVolView.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMMarketKLineTableViewCell : EIBMBaseTableViewCell

/**
 简单行情视图
 */
@property (strong, nonatomic) SimpleKLineVolView *simpleKLineView;

- (void)setKLineArray:(NSArray *)dataArray;

@end

NS_ASSUME_NONNULL_END
