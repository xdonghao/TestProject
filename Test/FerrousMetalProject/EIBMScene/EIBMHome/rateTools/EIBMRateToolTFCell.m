

//
//  RateToolTFCell.m
//  BlackIronProject
//
//  Created by mac on 2019/8/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "EIBMRateToolTFCell.h"

@implementation EIBMRateToolTFCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.contentView.backgroundColor = kWhiteColor;
    _lineView.backgroundColor = MainColor;
    _bgView.layer.masksToBounds = YES;
    _bgView.backgroundColor = LLBackGroundWhiteColor;
    _bgView.layer.cornerRadius = 10;
    _TextField.textColor = TitleColor;
    _titleLabel.textColor = TitleColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
