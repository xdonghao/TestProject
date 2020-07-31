//
//  ButtonCollectionViewCell.m
//  BusinessOfArt
//
//  Created by 董浩 on 2017/9/4.
//  Copyright © 2017年 donghao. All rights reserved.
//

#import "EIBMButtonCollectionViewCell.h"

@implementation EIBMButtonCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.textColor = TitleColor;
    
    self.titleLabel.backgroundColor = kWhiteColor;
}

@end
