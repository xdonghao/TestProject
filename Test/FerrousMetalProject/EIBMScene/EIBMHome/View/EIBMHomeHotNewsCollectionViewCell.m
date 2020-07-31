//
//  HomeHotNewsCollectionViewCell.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 12/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMHomeHotNewsCollectionViewCell.h"
#import "EIBMNewsOtherModel.h"
#import "EIBMNewsModel.h"
@interface EIBMHomeHotNewsCollectionViewCell ()

//@property (nonatomic, strong) UIImageView *headImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end

@implementation EIBMHomeHotNewsCollectionViewCell

- (void)configUI {
//    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.titleLabel];
    [self.contentView addSubview:self.timeLabel];
    
//    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView.mas_left).offset(10);
//        make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
//        make.size.mas_equalTo(CGSizeMake(120, 90));
//    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.titleLabel);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.height.mas_equalTo(20);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.timeLabel.mas_top).offset(-10);
    }];
}

+ (CGFloat)getCellHeightWithString:(NSString *)str {
    CGFloat height = [str heightWithFont:[UIFont systemFontOfSize:15] forWidth:(SCREEN_WIDTH - 20)] + 50;
    return height;
}

- (UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = TitleColor;
        _titleLabel.numberOfLines = 0;
        _titleLabel.font = [UIFont systemFontOfSize:15];
    }
    return _titleLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.textColor = TitleColor;
        _timeLabel.font = [UIFont systemFontOfSize:13];
    }
    return _timeLabel;
}

//- (UIImageView *)headImageView
//{
//    if (!_headImageView) {
//        _headImageView = [[UIImageView alloc] init];
//        _headImageView.layer.masksToBounds = YES;
//        _headImageView.layer.cornerRadius = 2;
//    }
//    return _headImageView;
//}

- (void)setDataWithSourceData:(id)model {
    
    
    if ([model isKindOfClass:[EIBMNewsOtherModel class]]) {
        EIBMNewsOtherModel *other = (EIBMNewsOtherModel *)model;
        self.titleLabel.text = other.title;
        self.timeLabel.text = [NSDate dateStrFromCstampTime:[other.recordDate integerValue]/1000 withDateFormat:@"yyyy-MM-dd hh:mm"];
//        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:other.imageUrl] placeholderImage:[UIImage imageNamed:IMAGENOPIC]];
    }
    if ([model isKindOfClass:[EIBMNewsModel class]]) {
        EIBMNewsModel *other = (EIBMNewsModel *)model;
        self.titleLabel.text = other.title;
        self.timeLabel.text = other.createTime;
//        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:other.cover] placeholderImage:[UIImage imageNamed:IMAGENOPIC]];
    }
}

@end
