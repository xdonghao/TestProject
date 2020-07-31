//
//  MarketAddCollectionViewCell.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 08/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMMarketAddCollectionViewCell : EIBMBaseCollectionViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;
@property (weak, nonatomic) IBOutlet UIButton *selButton;

@property (nonatomic, copy) void(^selSuccess)(BOOL sel);

@end

NS_ASSUME_NONNULL_END
