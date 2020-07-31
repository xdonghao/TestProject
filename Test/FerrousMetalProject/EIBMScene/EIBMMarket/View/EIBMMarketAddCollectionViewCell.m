//
//  MarketAddCollectionViewCell.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 08/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMMarketAddCollectionViewCell.h"

@implementation EIBMMarketAddCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.selButton setImage:[UIImage imageNamed:@"choose_un"] forState:UIControlStateNormal];
    [self.selButton setImage:[UIImage imageNamed:@"choose_se"] forState:UIControlStateSelected];
    [self.selButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnClick:(UIButton *)button {
    if (self.selSuccess) {
        self.selSuccess(button.selected);
    }
}

@end
