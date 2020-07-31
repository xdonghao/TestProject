//
//  BaseCollectionViewCell.m
//  BusinessOfArt
//
//  Created by 董浩 on 2017/10/29.
//  Copyright © 2017年 donghao. All rights reserved.
//

#import "EIBMBaseCollectionViewCell.h"

@implementation EIBMBaseCollectionViewCell

//+(BOOL)requiresConstraintBasedLayout{
//    return YES;
//}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.contentView.backgroundColor = kWhiteColor;
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

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = kWhiteColor;
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

- (void)configUI{
    
}

- (void)setDataWithSourceData:(id)model{
    
}

+(CGFloat)getCellHeightWithString:(NSString *)str{
    return 40;
}

@end
