//
//  TitleHeaderFooterView.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 12/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMTitleHeaderFooterView.h"

@implementation EIBMTitleHeaderFooterView

- (void)configUI {
    self.contentView.backgroundColor = LLBackGroundWhiteColor;
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = MainColor;
    [self.contentView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.width.mas_equalTo(5);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(label.mas_right).offset(5);
        make.top.bottom.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
    }];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [EIBMFactoryTool labelWithFont:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:MainColor];
    }
    return _titleLabel;
}

@end
