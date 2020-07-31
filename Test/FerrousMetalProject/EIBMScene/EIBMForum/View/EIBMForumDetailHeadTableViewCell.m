//
//  ForumDetailHeadTableViewCell.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMForumDetailHeadTableViewCell.h"
#import "EIBMForumListModel.h"
#import "NewsChatModel.h"

@interface EIBMForumDetailHeadTableViewCell ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@property (nonatomic, strong) UIImageView *headImageView;

@end

@implementation EIBMForumDetailHeadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configUI {
    [self.contentView addSubview:self.moreButton];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.headImageView];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(40, 40));
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
    }];
    
    [self.moreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.centerY.equalTo(self.headImageView.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(10);
        make.right.equalTo(self.moreButton.mas_left).offset(-10);
        make.top.equalTo(self.headImageView.mas_top);
        make.height.mas_equalTo(20);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(10);
        make.right.equalTo(self.moreButton.mas_left).offset(-10);
        make.bottom.equalTo(self.headImageView.mas_bottom);
        make.height.mas_equalTo(20);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.headImageView.mas_bottom).offset(10);
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}

- (void)setDataWithSourceData:(id)model {
    if ([model isKindOfClass:[NewsChatModel class]]) {
        NewsChatModel *temp = (NewsChatModel *)model;
        if (temp.userImageUrl.length > 0) {
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:temp.userImageUrl] placeholderImage:[UIImage imageNamed:@"eibm_person_touxiang"]];
        } else {
            if ([temp.userName isEqualToString:[EIBMUserUtil sharedUserUtil].user.userName] && [EIBMUserUtil sharedUserUtil].user.headerImageData) {
                [self.headImageView setImage:[UIImage imageWithData:[EIBMUserUtil sharedUserUtil].user.headerImageData]];
            } else {
                [self.headImageView setImage:[UIImage imageNamed:@"eibm_person_touxiang"]];
            }
        }
        if ([temp.userName isEqualToString:[EIBMUserUtil sharedUserUtil].user.userName]) {
            self.moreButton.hidden = YES;
        }
        NSString *time = [NSDate dateStrFromCstampTime:[temp.created integerValue] withDateFormat:@"yyyy.MM.dd HH:mm"];
        self.nameLabel.text = temp.userName;
        self.contentLabel.text = temp.content;
        self.timeLabel.text = time;
    }
    if ([model isKindOfClass:[EIBMForumListModel class]]) {
        EIBMForumListModel *temp = (EIBMForumListModel *)model;
        if (temp.userImageUrl.length > 0) {
            [self.headImageView sd_setImageWithURL:[NSURL URLWithString:temp.userImageUrl] placeholderImage:[UIImage imageNamed:@"eibm_person_touxiang"]];
        } else {
            if ([temp.userName isEqualToString:[EIBMUserUtil sharedUserUtil].user.userName] && [EIBMUserUtil sharedUserUtil].user.headerImageData) {
                [self.headImageView setImage:[UIImage imageWithData:[EIBMUserUtil sharedUserUtil].user.headerImageData]];
            } else {
                [self.headImageView setImage:[UIImage imageNamed:@"eibm_person_touxiang"]];
            }
        }
        if ([temp.userName isEqualToString:[EIBMUserUtil sharedUserUtil].user.userName]) {
            self.moreButton.hidden = YES;
        }
        NSString *time = [NSDate dateStrFromCstampTime:[temp.created integerValue] withDateFormat:@"yyyy.MM.dd HH:mm"];
        self.nameLabel.text = temp.userName;
        self.contentLabel.text = temp.content;
        self.timeLabel.text = time;
    }
    
    
}

- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.cornerRadius = 20;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    return _nameLabel;
}

- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont boldSystemFontOfSize:12];
    }
    return _timeLabel;
}

- (UILabel *)contentLabel
{
    if (!_contentLabel) {
        _contentLabel = [[UILabel alloc] init];
        _contentLabel.textColor = TitleColor;
        _contentLabel.font = [UIFont boldSystemFontOfSize:14];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UIButton *)moreButton {
    if (!_moreButton) {
        _moreButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_moreButton setImage:[UIImage imageNamed:@"eibm_more_small"] forState:UIControlStateNormal];
        [_moreButton addTarget:self action:@selector(moreClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreButton;
}

+ (CGFloat)getCellHeightWithString:(NSString *)str {
    CGFloat height = [str heightWithFont:[UIFont systemFontOfSize:14] forWidth:(SCREEN_WIDTH - 20)] + 30 + 40 + 20;
    return height;
}

- (void)moreClick {
    if (self.moreBlock) {
        self.moreBlock();
    }
}
@end
