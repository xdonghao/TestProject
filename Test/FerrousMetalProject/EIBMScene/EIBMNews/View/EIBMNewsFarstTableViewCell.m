//
//  NewsFarstTableViewCell.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 12/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMNewsFarstTableViewCell.h"
#import "EIBMNewsFarstModel.h"
@interface EIBMNewsFarstTableViewCell ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation EIBMNewsFarstTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configUI {
//    UIView *bgView = [[UIView alloc] init];
//    bgView.layer.cornerRadius = 2;
//    bgView.layer.borderWidth = 1;
//    bgView.layer.borderColor = MainColor.CGColor;
//    [self.contentView addSubview:bgView];

    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10)
        ;
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.timeLabel.mas_top).offset(-10);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10)
        ;
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.height.mas_equalTo(20);
    }];

//    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView.mas_left).offset(10);
//        make.right.equalTo(self.contentView.mas_right).offset(-10)
//        ;
//        make.top.equalTo(self.contentView.mas_top).offset(10);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10)
//        ;
//    }];
//    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(bgView.mas_left).offset(5);
//        make.right.equalTo(bgView.mas_right).offset(-5)
//        ;
//        make.top.equalTo(bgView.mas_top).offset(0);
//        make.height.mas_equalTo(20);
//    }];
//    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(bgView.mas_left).offset(20);
//        make.right.equalTo(bgView.mas_right).offset(-20)
//        ;
//        make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
//        make.bottom.equalTo(bgView.mas_bottom).offset(-10)
//        ;
//    }];
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


- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont boldSystemFontOfSize:13];
    }
    return _timeLabel;
}

- (void)setDataWithSourceData:(EIBMNewsFarstModel *)model {
    self.titleLabel.text = model.Title;
    self.timeLabel.text = [NSDate dateStrFromCstampTime:[model.UpdateTime integerValue]/1000 withDateFormat:@"yyyy-MM-dd HH:mm"];
}

+ (CGFloat)getCellHeightWithString:(NSString *)str {
    CGFloat height = [str heightWithFont:[UIFont systemFontOfSize:14] forWidth:(SCREEN_WIDTH - 20)] + 50 + 10;
    return height;
}

@end
