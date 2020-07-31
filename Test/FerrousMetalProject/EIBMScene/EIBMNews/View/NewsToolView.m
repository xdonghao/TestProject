//
//  NewsToolView.m
//  EIBMBestMetal
//
//  Created by MAC on 19/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "NewsToolView.h"

@interface NewsToolView ()

@property (nonatomic, strong)UILabel *line;
@property (nonatomic, strong)UIButton *chatButton;
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UIButton *bigButton;
@end

@implementation NewsToolView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI {
    _line = [[UILabel alloc] init];
    _line.backgroundColor = [UIColor lightGrayColor];
    _line.alpha = 0.5;
    [self addSubview:_line];
    [self addSubview:self.saveButton];
    [self addSubview:self.chatButton];
    [self addSubview:self.textField];
    [self addSubview:self.bigButton];
}

- (void)layoutSubviews {
    [_line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    [self.saveButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.chatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.saveButton.mas_left).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(40, 40));
    }];
    
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.chatButton.mas_left).offset(-10);
    }];
    [self.bigButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.right.equalTo(self.saveButton.mas_left).offset(-10);
    }];
}

- (UIButton *)saveButton{
    if (!_saveButton) {
        _saveButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_saveButton setImage:[UIImage imageNamed:@"eibm_collect_add"] forState:UIControlStateNormal];
        [_saveButton setImage:[UIImage imageNamed:@"eibm_collect_del"] forState:UIControlStateSelected];
        [_saveButton addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saveButton;
}

- (UIButton *)chatButton {
    if (!_chatButton) {
        _chatButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chatButton setImage:[UIImage imageNamed:@"news_tool_chat"] forState:UIControlStateNormal];
    }
    return _chatButton;
}

- (UIButton *)bigButton {
    if (!_bigButton) {
        _bigButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_bigButton addTarget:self action:@selector(chatClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _bigButton;
}

- (void)chatClick {
    if (self.chatBlock) {
        self.chatBlock();
    }
}

- (UITextField *)textField {
    if (!_textField) {
        _textField  = [EIBMFactoryTool fieldWithPlaceholder:@"说点儿什么吧" font:UIFontSize(16)];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _textField;
}

-(void)saveClick:(UIButton *)button{
    if (![EIBMUserUtil sharedUserUtil].user) {
        [NSObject showHudTipStr:@"请先登录"];
        return;
    }
    if (self.saveBlock) {
        self.saveBlock();
        button.selected = !button.selected;
    }
}

@end
