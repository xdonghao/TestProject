//
//  HeaderLineCollectionReusableView.m
//  BusinessOfArt
//
//  Created by 董浩 on 2017/9/4.
//  Copyright © 2017年 donghao. All rights reserved.
//

#import "EIBMHeaderLineCollectionReusableView.h"

@interface EIBMHeaderLineCollectionReusableView ()
@property (nonatomic, strong)UILabel *contentLabel;
@end

@implementation EIBMHeaderLineCollectionReusableView

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = TitleColor;
        _titleLabel.font = [UIFont systemFontOfSize:14];
    }
    return _titleLabel;
}

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"eibm_more_small"];
        _arrowImageView.contentMode =  UIViewContentModeScaleAspectFit;
        _arrowImageView.hidden = YES;
    }
    return _arrowImageView;
}


- (UIButton *)expandButton
{
    if (!_expandButton) {
        _expandButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_expandButton addTarget:self action:@selector(expandAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _expandButton;
}

- (UILabel *)moreLabel
{
    if (!_moreLabel) {
        _moreLabel = [[UILabel alloc] init];
        _moreLabel.textColor = [UIColor colorWithHexString:@"5CACEE"];
        _moreLabel.font = [UIFont boldSystemFontOfSize:14];
        _moreLabel.text = @"";
        _moreLabel.hidden = YES;
    }
    return _moreLabel;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatUI];
    }
    return self;
}

- (void)creatUI{
    self.backgroundColor = kWhiteColor;
    self.leftLabel = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_jingxuan"]];
    [self addSubview:self.leftLabel];
    
    [self addSubview:self.titleLabel];
    [self addSubview:self.arrowImageView];
    [self addSubview:self.expandButton];
    [self addSubview:self.moreLabel];
    
    self.bottomLine = [[UILabel alloc] init];
    self.bottomLine.backgroundColor = LINECOLOR;
    [self addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)updateConstraints
{
    [self.leftLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(20);
        make.size.mas_equalTo(CGSizeMake(20, 20));
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.arrowImageView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(self.mas_right).offset(-10);
//        make.centerY.equalTo(self.mas_centerY);
//        make.width.equalTo(@8);
//        make.height.equalTo(@13);
        
        make.right.equalTo(self.mas_right).offset(-15);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(30, 20));
    }];
    
    [self.expandButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.equalTo(self);
        make.right.equalTo(self.mas_right).offset(-15);
    }];
    
    [self.moreLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(30, 20));
        make.right.equalTo(self.arrowImageView.mas_left).offset(0);
        make.centerY.equalTo(self.mas_centerY);
    }];
    
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.left.equalTo(self.leftLabel.mas_right).offset(10);
        make.height.mas_equalTo(20);
        make.right.equalTo(self.moreLabel.mas_left).offset(-10);
    }];
    [super updateConstraints];
}

- (void)expandAction:(UIButton *)sender {
    
    if (self.moreBlock) {
        self.moreBlock();
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
