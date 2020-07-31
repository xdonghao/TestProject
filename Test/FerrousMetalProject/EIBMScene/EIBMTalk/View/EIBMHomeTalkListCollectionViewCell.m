//
//  HomeTalkListCollectionViewCell.m
//  EIBMGoodsProject
//
//  Created by MAC on 19/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMHomeTalkListCollectionViewCell.h"
#import "TalkListModel.h"

@interface EIBMHomeTalkListCollectionViewCell ()

@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UILabel *typeLabel;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIButton *moreButton;
@end

@implementation EIBMHomeTalkListCollectionViewCell

- (void)configUI {
    self.contentView.backgroundColor = LLBackGroundWhiteColor;
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.typeLabel];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.moreButton];
    [self.contentView addSubview:self.joinButton];
    
    UILabel *line = [[UILabel alloc] init];
    line.backgroundColor = LINECOLOR;
    [self.contentView addSubview:line];
    UILabel *line2 = [[UILabel alloc] init];
    line2.backgroundColor = LINECOLOR;
    [self.contentView addSubview:line2];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.height.mas_equalTo(200);
    }];
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.headImageView);
        make.top.equalTo(self.headImageView.mas_bottom).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.typeLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.headImageView);
        make.top.equalTo(line.mas_bottom).offset(0);
        make.height.mas_equalTo(40);
    }];
    
    [line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.contentView);
        make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView);
        make.top.equalTo(line2.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(50, 40));
    }];
    
    [self.joinButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.headImageView);
        make.top.equalTo(line2.mas_bottom).offset(0);
        make.size.mas_equalTo(CGSizeMake(80, 40));
    }];
}

+(CGFloat)getCellHeightWithString:(NSString *)str{
    return 330;
}

- (void)setDataWithSourceData:(TalkListModel *)model {
    self.titleLabel.text = model.title;
    self.typeLabel.text = [NSString stringWithFormat:@"话题：%@",model.type];
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.imageUrl] placeholderImage:[UIImage imageNamed:IMAGENOPIC]];
}

- (UIImageView *)headImageView {
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
    }
    return _headImageView;
}

- (UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.textColor = [UIColor lightGrayColor];
        _typeLabel.font = [UIFont boldSystemFontOfSize:12];
    }
    return _typeLabel;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = TitleColor;
        _titleLabel.font = [UIFont boldSystemFontOfSize:14];
        _titleLabel.numberOfLines = 0;
    }
    return _titleLabel;
}

- (UIButton *)joinButton {
    if (!_joinButton) {
        _joinButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [_joinButton setTitle:@"参与讨论" forState:UIControlStateNormal];
        [_joinButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _joinButton.tag = 101;
    }
    return _joinButton;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setImage:[UIImage imageNamed:@"eibm_more_small"] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _moreButton.tag = 100;
    }
    return _moreButton;
}

- (void)buttonClick:(UIButton *)button {
    if (self.success) {
        self.success(button.tag - 100);
        
    }
}

@end
