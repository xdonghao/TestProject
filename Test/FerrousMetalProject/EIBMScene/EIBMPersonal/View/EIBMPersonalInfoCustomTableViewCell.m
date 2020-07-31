//
//  PersonalInfoCustomTableViewCell.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 05/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMPersonalInfoCustomTableViewCell.h"

@implementation EIBMPersonalInfoCustomTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configUI {
    self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 16, 18, 18)];
    [self.contentView addSubview:self.iconImageView];
    
    self.infoLabel = [EIBMFactoryTool labelWithFont:[UIFont systemFontOfSize:14] textAlignment:NSTextAlignmentLeft textColor:TitleColor];
    [self.contentView addSubview:self.infoLabel];
    [self.infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconImageView.mas_right).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.bottom.equalTo(self.contentView);
    }];
    
}
@end
