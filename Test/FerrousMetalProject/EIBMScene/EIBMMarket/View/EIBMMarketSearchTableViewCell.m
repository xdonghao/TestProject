//
//  MarketSearchTableViewCell.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMMarketSearchTableViewCell.h"
#import "EIBMMarketSearchModel.h"
@implementation EIBMMarketSearchTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataWithSourceData:(EIBMMarketSearchModel *)model {
    self.titleLabel.text = model.showCode;
    self.contentLabel.text = model.name;
}

@end
