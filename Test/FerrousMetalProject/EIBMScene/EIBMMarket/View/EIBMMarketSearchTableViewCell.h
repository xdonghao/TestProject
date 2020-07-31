//
//  MarketSearchTableViewCell.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMMarketSearchTableViewCell : EIBMBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

NS_ASSUME_NONNULL_END
