//
//  ForumNewListTableViewCell.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMForumNewListTableViewCell.h"
#import "EIBMForumListModel.h"
#import "EIBMForumZanManager.h"
@interface EIBMForumNewListTableViewCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *contentLabel;
@property (nonatomic, strong) UIImageView *headImageView;

@property (nonatomic, strong) UIButton *shareButton;
@property (nonatomic, strong) UIButton *chatButton;
@property (nonatomic, strong) UIButton *heartButton;
@end


@implementation EIBMForumNewListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configUI {
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = LLBackGroundWhiteColor;
    [self.contentView addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(0);
        make.height.mas_equalTo(8);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
    }];
    
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.timeLabel];
    [self.contentView addSubview:self.contentLabel];
    [self.contentView addSubview:self.headImageView];
    
    [self.contentView addSubview:self.shareButton];
    [self.contentView addSubview:self.chatButton];
    [self.contentView addSubview:self.heartButton];
    
    [self.shareButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.bottom.equalTo(bgView.mas_top);
        make.width.mas_equalTo(SCREEN_WIDTH/3);
        make.height.mas_equalTo(40);
    }];
    
    [self.chatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.shareButton.mas_right);
        make.bottom.equalTo(bgView.mas_top);
        make.width.mas_equalTo(SCREEN_WIDTH/3);
        make.height.mas_equalTo(40);
    }];
    
    [self.heartButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView);
        make.bottom.equalTo(bgView.mas_top);
        make.width.mas_equalTo(SCREEN_WIDTH/3);
        make.height.mas_equalTo(40);
    }];
    
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.top.equalTo(self.contentView.mas_top).offset(10);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headImageView.mas_right).offset(10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.height.mas_equalTo(25);
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.nameLabel.mas_left);
        make.right.equalTo(self.nameLabel.mas_right);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
        make.height.mas_equalTo(25);
    }];
    
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.bottom.equalTo(self.shareButton.mas_top).offset(-10);
        make.top.equalTo(self.headImageView.mas_bottom).offset(10);
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
    self.timeLabel.text = [NSString stringWithFormat:@"%@ 发布",time];
    self.nameLabel.text = model.userName;
    
    
    NSMutableArray *muarr = [NSMutableArray arrayWithArray:[EIBMForumZanManager getAllZanForum]];
    
    if ([muarr containsObject:model]) {
        self.heartButton.selected = YES;
    } else {
        self.heartButton.selected = NO;
    }
    
}

+ (CGFloat)getCellHeightWithString:(NSString *)str {
    CGFloat height = [str heightWithFont:[UIFont systemFontOfSize:14] forWidth:(SCREEN_WIDTH - 20)] +40 + 50 + 8 + 40;
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

- (UIButton *)chatButton {
    if (!_chatButton) {
        _chatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chatButton setImage:[UIImage imageNamed:@"forum_chat"] forState:UIControlStateNormal];
        [_chatButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _chatButton.tag = 101;
    }
    return _chatButton;
}

- (UIButton *)shareButton {
    if (!_shareButton) {
        _shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shareButton setImage:[UIImage imageNamed:@"forum_share"] forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _shareButton.tag = 100;
        _shareButton.hidden = YES;
    }
    return _shareButton;
}

- (UIButton *)heartButton {
    if (!_heartButton) {
        _heartButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_heartButton setImage:[UIImage imageNamed:@"forum_zan_un"] forState:UIControlStateNormal];
        [_heartButton setImage:[UIImage imageNamed:@"forum_zan_se"] forState:UIControlStateSelected];
        [_heartButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        _heartButton.tag = 102;
    }
    return _heartButton;
}

- (void)buttonClick:(UIButton *)button {
    if (![EIBMUserUtil sharedUserUtil].user) {
        [NSObject showHudTipStr:@"请先登录"];
        return;
    }
    if (self.success) {
        self.success(button.tag - 100, button.selected);
        if (button.tag == 102) {
            button.selected = !button.selected;
        }
    }
}

@end
