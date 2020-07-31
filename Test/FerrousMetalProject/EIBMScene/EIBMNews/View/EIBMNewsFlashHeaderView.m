//
//  NewsFlashHeaderView.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 04/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMNewsFlashHeaderView.h"

@interface EIBMNewsFlashHeaderView ()
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIButton *expandButton;
@end

@implementation EIBMNewsFlashHeaderView

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
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.arrowImageView];
    [self.contentView addSubview:self.expandButton];
}

- (void)updateConstraints
{
    [self.arrowImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.centerY.equalTo(self.contentView);
        make.width.equalTo(@7.5);
        make.height.equalTo(@4);
    }];
    [self.titleLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.arrowImageView.mas_right).offset(6);
        make.top.height.equalTo(self.contentView);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        //        make.right.equalTo(self.numLabel.mas_left).offset(-3);
//        make.width.mas_equalTo(SCREEN_WIDTH - 120);
    }];
    [self.expandButton mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    [super updateConstraints];
}

- (void)setModel:(EIBMNewsFlashModel *)model {
    if (_model != model) {
        _model = model;
    }
    if (model.isExpanded) {
        self.arrowImageView.transform = CGAffineTransformIdentity;
    } else {
        self.arrowImageView.transform = CGAffineTransformMakeRotation(-M_PI/2);
    }
}

- (void)expandAction:(UIButton *)sender {
    self.model.isExpanded = !self.model.isExpanded;
    [UIView animateWithDuration:0.2f animations:^{
        if (self.model.isExpanded) {
            self.arrowImageView.transform = CGAffineTransformIdentity;
        } else {
            self.arrowImageView.transform = CGAffineTransformMakeRotation(-M_PI/2);
        }
    }];
    if (self.expandCallback) {
        self.expandCallback(self.model.isExpanded);
    }
}
#pragma mark ------------- Setters --------------

- (void)setTitle:(NSString *)title
{
    if (![_title isEqualToString:title]) {
        _title = title;
        self.titleLabel.text = title;
    }
}
#pragma mark ------------- Getters --------------

- (UIImageView *)arrowImageView
{
    if (!_arrowImageView) {
        _arrowImageView = [[UIImageView alloc] init];
        _arrowImageView.image = [UIImage imageNamed:@"eibm_area_expand1"];
    }
    return _arrowImageView;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = TitleColor;
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
    }
    return _titleLabel;
}


- (UIButton *)expandButton
{
    if (!_expandButton) {
        _expandButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        [_expandButton addTarget:self action:@selector(expandAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _expandButton;
}

@end
