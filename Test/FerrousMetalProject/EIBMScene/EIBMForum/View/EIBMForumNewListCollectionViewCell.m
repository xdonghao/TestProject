//
//  ForumNewListCollectionViewCell.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMForumNewListCollectionViewCell.h"
#import "EIBMForumListModel.h"

@interface EIBMForumNewListCollectionViewCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *headImageView;
@end

@implementation EIBMForumNewListCollectionViewCell

- (void)configUI {
    UIView *bgView = [[UIView alloc] init];
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.left.right.equalTo(self.contentView);
        make.height.mas_equalTo(50);
    }];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.headImageView];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.top.equalTo(bgView);
        make.left.equalTo(bgView.mas_left).offset(15);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(10);
        make.top.equalTo(bgView.mas_top);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.height.mas_equalTo(50);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView.mas_bottom);
        make.left.right.equalTo(self.contentLabel);
        make.height.mas_equalTo(20);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(bgView.mas_left).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.bottom.equalTo(self.timeLabel.mas_top);
        make.top.equalTo(bgView.mas_bottom).offset(10);
    }];
    
}

- (void)setDataWithSourceData:(EIBMForumListModel *)model {
    if (model.userImageUrl.length > 0) {
        [self.headImageView sd_setImageWithURL:[NSURL URLWithString:model.userImageUrl] placeholderImage:[UIImage imageNamed:@"eibm_person_touxiang"]];
    } else {
        if ([model.userName isEqualToString:[EIBMUserUtil sharedUserUtil].user.userName] && [EIBMUserUtil sharedUserUtil].user.headerImageData) {
            [self.headImageView setImage:[UIImage imageWithData:[EIBMUserUtil sharedUserUtil].user.headerImageData]];
        } else {
            [self.headImageView setImage:[UIImage imageNamed:@"eibm_person_touxiang"]];
        }
    }
    NSString *time = [NSDate dateStrFromCstampTime:[model.created integerValue] withDateFormat:@"yyyy-MM-dd HH:mm"];
    self.contentLabel.text = model.content;
    self.timeLabel.text = time;
    self.nameLabel.text = model.userName;
}

+ (CGFloat)getCellHeightWithString:(NSString *)str {
    CGFloat height = [str heightWithFont:[UIFont systemFontOfSize:14] forWidth:(SCREEN_WIDTH - 70)] +50 + 60;
    return height;
}

- (UIImageView *)headImageView
{
    if (!_headImageView) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.layer.cornerRadius = 3;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}


- (UILabel *)timeLabel
{
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = [UIColor lightGrayColor];
        _timeLabel.font = [UIFont boldSystemFontOfSize:12];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
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

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = TitleColor;
        _nameLabel.font = [UIFont boldSystemFontOfSize:15];
        _nameLabel.numberOfLines = 1;
    }
    return _nameLabel;
}

@end
