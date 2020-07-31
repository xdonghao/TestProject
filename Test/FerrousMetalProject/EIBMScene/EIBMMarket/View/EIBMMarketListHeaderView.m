//
//  MarketListHeaderView.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 01/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMMarketListHeaderView.h"

@interface EIBMMarketListHeaderView ()
@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UILabel *priceLabel;
@property (nonatomic, strong)UILabel *stateLabel;
@end

@implementation EIBMMarketListHeaderView

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [EIBMFactoryTool labelWithFont:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentCenter textColor:MainColor];
        _nameLabel.text = @"期货种类";
    }
    return _nameLabel;
}

- (UILabel *)priceLabel{
    if (!_priceLabel) {
        _priceLabel = [EIBMFactoryTool labelWithFont:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentCenter textColor:[UIColor lightGrayColor]];
        _priceLabel.text = @"最新价";
    }
    return _priceLabel;
}

- (UILabel *)stateLabel{
    if (!_stateLabel) {
        _stateLabel = [EIBMFactoryTool labelWithFont:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentCenter textColor:[UIColor lightGrayColor]];
        _stateLabel.text = @"涨跌幅";
    }
    return _stateLabel;
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI{
    self.contentView.backgroundColor = LLBackGroundWhiteColor;
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.priceLabel];
    [self.contentView addSubview:self.stateLabel];
}

- (void)updateConstraints
{
    
    [self.stateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_right);
        make.width.mas_equalTo(SCREEN_WIDTH/3);
    }];
    [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.stateLabel.mas_left);
        make.width.mas_equalTo(SCREEN_WIDTH/3);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.left.equalTo(self.mas_left);
        make.right.equalTo(self.priceLabel.mas_left);
    }];
    
    [super updateConstraints];
}

@end
