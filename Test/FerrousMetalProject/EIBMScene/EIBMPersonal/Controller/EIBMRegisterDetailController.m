//
//  RegisterDetailController.m
//  MusicShow
//
//  Created by maple liu on 17/2/22.
//  Copyright © 2017年 浪浪. All rights reserved.
//

#import "EIBMRegisterDetailController.h"
#import "EIBMValidateTools.h"
#define MAX_STARWORDS_LENGTH 15

@interface EIBMRegisterDetailController ()<UITextFieldDelegate>
@property(nonatomic, strong) UITextField *passwordTF;
@property(nonatomic, strong) UITextField *nameTF;
@property(nonatomic, strong) UIButton *commitBtn;
@end

@implementation EIBMRegisterDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"注册"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    self.view.backgroundColor = kWhiteColor;
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldEditChanged:) name:@"UITextFieldTextDidChangeNotification" object:_nameTF];
    [self.contentView addSubview:self.nameTF];
    [self.contentView addSubview:self.passwordTF];
    [self.contentView addSubview:self.commitBtn];
    self.nameTF.delegate = self;
    [self.nameTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
        make.height.mas_equalTo(45);
        make.top.equalTo(self.contentView.mas_top).offset(80);
    }];
    [self.passwordTF mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
        make.height.mas_equalTo(45);
        make.top.equalTo(self.nameTF.mas_bottom).offset(18);
    }];
    
    [self.commitBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(45);
        make.top.equalTo(self.passwordTF.mas_bottom).offset(36);
    }];

}

- (void)registerAction:(id)sender{
    [self.view endEditing:YES];
    if (![EIBMValidateTools isValidatePasswd:self.nameTF.text]) {
        [NSObject showHudTipStr:@"请输入合法的用户名（6-13位）"];
        return;
    }
    if (![EIBMValidateTools isValidatePasswd:self.passwordTF.text]) {
        [NSObject showHudTipStr:@"请输入合法的确认密码（6-13位）"];
        return;
    }
    NSArray *all = [EIBMUser findAll];
    for (EIBMUser *user in all) {
        if ([user.userName isEqualToString:self.nameTF.text]) {
            [NSObject showHudSuccessStr:@"此用户已存在，请选择其他用户名"];
            return;
        }
    }
    EIBMUser *user = [[EIBMUser alloc] init];
    user.userId = [NSString stringWithFormat:@"%ld",all.count + 1000];
    user.userName = self.nameTF.text;
    user.password = self.passwordTF.text;
    
    BOOL ret = [user save];
    if (ret) {
        [NSObject showHudSuccessStr:@"注册成功"];
        [self.navigationController popToRootViewControllerAnimated:YES];
    } else {
        [NSObject showHudSuccessStr:@"注册失败"];
    }

}

-(void)textFieldEditChanged:(NSNotification *)obj
{
    
    UITextField *textField = (UITextField *)obj.object;
    if (textField == _nameTF) {
        NSString *toBeString = textField.text;
        
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > MAX_STARWORDS_LENGTH)
            {
                NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:MAX_STARWORDS_LENGTH];
                if (rangeIndex.length == 1)
                {
                    textField.text = [toBeString substringToIndex:MAX_STARWORDS_LENGTH];
                }
                else
                {
                    NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, MAX_STARWORDS_LENGTH)];
                    textField.text = [toBeString substringWithRange:rangeRange];
                }
            }
        }
    }
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (textField==_nameTF) {
        NSString *tem = [[string componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]componentsJoinedByString:@""];
        if (![string isEqualToString:tem]) {
            return NO;
        }
    }
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

- (UIButton *)commitBtn {
    if (!_commitBtn) {
        _commitBtn = [EIBMFactoryTool buttonWithType:UIButtonTypeCustom Target:self action:@selector(registerAction:) forControlEvents:UIControlEventTouchUpInside font:[UIFont systemFontOfSize:16] textColor:[UIColor whiteColor]];
        _commitBtn.backgroundColor = MainColor;
        [_commitBtn setTitle:@"注册" forState:UIControlStateNormal];
    }
    return _commitBtn;
}

- (UITextField *)nameTF {
    if (!_nameTF) {
        _nameTF = [EIBMFactoryTool fieldWithPlaceholder:@"请输入用户名(6-13位)" font:[UIFont systemFontOfSize:16]];
        _nameTF.backgroundColor = kWhiteColor;
        _nameTF.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _nameTF;
}

- (UITextField *)passwordTF {
    if (!_passwordTF) {
        _passwordTF = [EIBMFactoryTool fieldWithPlaceholder:@"请输入密码(6-13位)" font:[UIFont systemFontOfSize:16]];
        _passwordTF.secureTextEntry = YES;
        _passwordTF.backgroundColor = kWhiteColor;
        _passwordTF.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _passwordTF;
}

@end
