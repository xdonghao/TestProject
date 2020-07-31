//
//  ClassroomTableViewCell.m
//  BlackWhiteFuProject
//
//  Created by MAC on 02/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMClassroomTableViewCell.h"
#import "EIBMClassroomModel.h"

@interface EIBMClassroomTableViewCell ()

@property (nonatomic, strong)UILabel *nameLabel;
@property (nonatomic, strong)UIImageView *headerImageView;
@property (nonatomic, strong)UILabel *contentLabel;
@property (nonatomic, strong)UILabel *timeLabel;

@end

@implementation EIBMClassroomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configUI {
    self.contentView.backgroundColor = LLBackGroundWhiteColor;
    UIView *bgView = [[UIView alloc] init];
    bgView.backgroundColor = kWhiteColor;
    [self.contentView addSubview:bgView];
    [bgView addSubview:self.nameLabel];
    [bgView addSubview:self.headerImageView];
    [bgView addSubview:self.contentLabel];
    [bgView addSubview:self.timeLabel];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(5);
        make.top.equalTo(self.contentView.mas_top).offset(5);
        make.right.equalTo(self.contentView.mas_right).offset(-5);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-5);
    }];
    
    [self.headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.equalTo(bgView.mas_left).offset(10);
        make.top.equalTo(bgView.mas_top).offset(10);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageView.mas_right).offset(10);
        make.right.equalTo(bgView.mas_right).offset(-10);
        make.top.equalTo(self.headerImageView.mas_top);
        make.height.mas_equalTo(20);
    }];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).offset(10);
        make.height.mas_equalTo(20);
    }];
    [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.headerImageView.mas_left);
        make.right.equalTo(self.nameLabel.mas_right);
        make.top.equalTo(self.headerImageView.mas_bottom).offset(5);
        make.bottom.equalTo(bgView.mas_bottom).offset(-10);
    }];
}

- (void)setDataWithSourceData:(EIBMClassroomModel *)model {
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.headerUrl] placeholderImage:[UIImage imageNamed:@"eibm_person_touxiang"]];
    self.nameLabel.text = model.name;
    self.contentLabel.text = model.content;
    self.timeLabel.text = model.time;
}

+ (CGFloat)getCellHeightWithString:(NSString *)str {
    CGFloat height = [str heightWithFont:[UIFont systemFontOfSize:13] forWidth:(SCREEN_WIDTH - 30)] + 95;
    return height;
}

- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [EIBMFactoryTool labelWithFont:[UIFont systemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:TitleColor];
    }
    return _nameLabel;
}

- (UILabel *)contentLabel{
    if (!_contentLabel) {
        _contentLabel = [EIBMFactoryTool labelWithFont:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:TitleColor];
        _contentLabel.numberOfLines = 0;
    }
    return _contentLabel;
}

- (UILabel *)timeLabel{
    if (!_timeLabel) {
        _timeLabel = [EIBMFactoryTool labelWithFont:[UIFont systemFontOfSize:12] textAlignment:NSTextAlignmentLeft textColor:TitleColor];
        _timeLabel.numberOfLines = 0;
    }
    return _timeLabel;
}

- (UIImageView *)headerImageView {
    if (!_headerImageView) {
        _headerImageView = [[UIImageView alloc] init];
        _headerImageView.layer.masksToBounds = YES;
        _headerImageView.layer.cornerRadius = 4;
    }
    return _headerImageView;
}

@end
