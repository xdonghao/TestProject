//
//  TalkDetailTableViewCell.m
//  EIBMGoodsProject
//
//  Created by MAC on 19/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMTalkDetailTableViewCell.h"
#import "EIBMTalkDetailModel.h"
@implementation EIBMTalkDetailTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)configUI {
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.titleLabel];

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.height.mas_equalTo(20);
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}

+(CGFloat)getCellHeightWithString:(NSString *)str{
    CGFloat height = [str heightWithFont:[UIFont systemFontOfSize:14] forWidth:(SCREEN_WIDTH - 20)] + 50 + 5;
    return height;
}

- (void)setDataWithSourceData:(EIBMTalkDetailModel *)model {
    self.nameLabel.text = model.userName;
    self.titleLabel.text = model.content;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.textColor = [UIColor lightGrayColor];
        _nameLabel.font = [UIFont boldSystemFontOfSize:12];
    }
    return _nameLabel;
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
@end
