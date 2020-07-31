//
//  NewsChatView.m
//  EIBMBestMetal
//
//  Created by MAC on 19/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "NewsChatView.h"

@interface NewsChatView ()<UITextFieldDelegate>

@property (nonatomic, strong)UILabel *line;
@property (nonatomic, strong)UITextField *textField;
@property (nonatomic, strong)UIButton *chatButton;

@end

@implementation NewsChatView

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
    [self addSubview:self.textField];
    [self addSubview:self.chatButton];
}

- (void)layoutSubviews {
    [_line mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.mas_left).offset(0);
        make.right.equalTo(self.mas_right).offset(0);
        make.top.equalTo(self.mas_top).offset(0);
        make.height.mas_equalTo(0.5);
    }];
    [self.chatButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.mas_right).offset(-10);
        make.centerY.equalTo(self.mas_centerY);
        make.size.mas_equalTo(CGSizeMake(50, 35));
    }];
    [self.textField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top).offset(10);
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.left.equalTo(self.mas_left).offset(10);
        make.right.equalTo(self.chatButton.mas_left).offset(-10);
    }];
}

- (UITextField *)textField {
    if (!_textField) {
        _textField  = [EIBMFactoryTool fieldWithPlaceholder:@"说点儿什么吧" font:UIFontSize(16)];
        _textField.borderStyle = UITextBorderStyleRoundedRect;
        _textField.delegate = self;
        _textField.returnKeyType = UIReturnKeySend;
    }
    return _textField;
}

- (UIButton *)chatButton {
    if (!_chatButton) {
        _chatButton = [EIBMFactoryTool buttonWithType:UIButtonTypeCustom Target:self action:@selector(sendAction) forControlEvents:UIControlEventTouchUpInside font:UIFontSize(14) textColor:[UIColor whiteColor]];
        [_chatButton setTitle:@"发送" forState:UIControlStateNormal];
        _chatButton.layer.cornerRadius = 2;
        _chatButton.layer.masksToBounds = YES;
        _chatButton.backgroundColor = MainColor;
    }
    return _chatButton;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if (textField.text.length > 0) {
        if (self.chatBlock) {
            self.chatBlock(textField.text);
            textField.text = @"";
            [textField endEditing:YES];
        }
    } else {
        [NSObject showHudTipStr:@"请输入评论内容"];
    }
    return YES;
}

- (void)sendAction {
    if (![EIBMUserUtil sharedUserUtil].user) {
        [NSObject showHudTipStr:@"请先登录"];
        return;
    }
    
    if (self.textField.text.length > 0) {
        if (self.chatBlock) {
            self.chatBlock(self.textField.text);
            self.textField.text = @"";
            [self.textField endEditing:YES];
        }
    } else {
        [NSObject showHudTipStr:@"请输入评论内容"];
    }
}

@end
