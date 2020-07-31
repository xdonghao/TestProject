//
//  BaseTableViewCell.m
//  BusinessOfArt
//
//  Created by 董浩 on 2017/9/3.
//  Copyright © 2017年 donghao. All rights reserved.
//

#import "EIBMBaseTableViewCell.h"

@implementation EIBMBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = kWhiteColor;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self configUI];
        self.bottomLine = [[UILabel alloc] init];
        self.bottomLine.backgroundColor = LINECOLOR;
        [self addSubview:self.bottomLine];
        [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_left).offset(0);
            make.right.equalTo(self.mas_right).offset(0);
            make.bottom.equalTo(self.mas_bottom).offset(0);
            make.height.mas_equalTo(0.5);
        }];
        self.bottomLine.hidden = YES;
    }
    return self;
}

- (void)showBottomLine{
    self.bottomLine.hidden = NO;
}
- (void)hiddenBottomLine{
    self.bottomLine.hidden = YES;
}
-(void)configUI {
    
}

- (void)setDataWithSourceData:(id)model{
    
}

+(CGFloat)getCellHeightWithString:(NSString *)str{
    return 40;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = kWhiteColor;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.bottomLine = [[UILabel alloc] init];
    self.bottomLine.backgroundColor = LINECOLOR;
    self.bottomLine.hidden = YES;
    [self addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.bottom.equalTo(self.mas_bottom).offset(0);
        make.height.mas_equalTo(0.5);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
