//
//  EIBMPersonalInfoRemarkTableViewCell.m
//  EIBMForwardProject
//
//  Created by MAC on 18/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMPersonalInfoRemarkTableViewCell.h"

@interface EIBMPersonalInfoRemarkTableViewCell ()<UITextViewDelegate>


@end

@implementation EIBMPersonalInfoRemarkTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configUI {
    UILabel *title = [EIBMFactoryTool labelWithFont:[UIFont systemFontOfSize:13] textAlignment:NSTextAlignmentLeft textColor:TitleColor];
    title.text = @"签名：";
    [self.contentView addSubview:title];
    
    _text = [[UITextView alloc] init];
    _text.maxInputLength = 20;
    _text.placeholder = @"您还没有签名哦！";
    _text.delegate = self;
    _text.backgroundColor = kWhiteColor;
    [self.contentView addSubview:_text];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.size.mas_equalTo(CGSizeMake(100, 20));
        make.top.equalTo(self.contentView.mas_top).offset(10);
    }];
    
    [_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(title.mas_left);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(title.mas_bottom).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
}

- (void)textViewDidChange:(UITextView *)textView {
    if (self.successBlock) {
        self.successBlock(textView.text);
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    if (self.successBlock) {
        self.successBlock(textView.text);
    }
}

+(CGFloat)getCellHeightWithString:(NSString *)str {
    return 180;
}

@end
