//
//  StoreMenuCollectionViewCell.m
//  BusinessOfArt
//
//  Created by 董浩 on 2017/9/4.
//  Copyright © 2017年 donghao. All rights reserved.
//

#import "EIBMStoreMenuCollectionViewCell.h"

@implementation EIBMStoreMenuCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = kWhiteColor;
    self.menuLabel.textColor = TitleColor;
}

@end
