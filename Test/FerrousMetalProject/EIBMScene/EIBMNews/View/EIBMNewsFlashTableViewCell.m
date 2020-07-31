//
//  NewsFlashTableViewCell.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 04/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMNewsFlashTableViewCell.h"

@implementation EIBMNewsFlashTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.textColor = TitleColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(CGFloat)getCellHeightWithString:(NSString *)str{
    CGFloat height = [str heightWithFont:[UIFont systemFontOfSize:13] forWidth:(SCREEN_WIDTH - 20)]+30;
    return height;
}

@end
