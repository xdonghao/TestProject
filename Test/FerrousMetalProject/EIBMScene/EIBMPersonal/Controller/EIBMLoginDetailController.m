//
//  LoginDetailController.m
//  MusicShow
//
//  Created by pg on 16/8/25.
//  Copyright © 2016年 PhoenixDaoDao. All rights reserved.
//

#import "EIBMLoginDetailController.h"
#import "AppDelegate.h"
#import "EIBMRegisterDetailController.h"
#import "EIBMValidateTools.h"
#import "EIBMServerHtmlViewController.h"
@interface EIBMLoginDetailController ()<UITextFieldDelegate>
@property(nonatomic, strong) UITextField *phoneField;
@property(nonatomic, strong) UITextField *passwordField;
@property(nonatomic, strong) UIButton *loginButton;
@property(nonatomic, strong) UIButton *regButton;
@property(nonatomic, strong) NSString *loginUserName;
@property(nonatomic, strong) NSString *loginUserId;
@property(nonatomic, strong) NSString *loginToken;
@property(nonatomic, strong) NSString *loginPassword;
@property(nonatomic, strong) UIImageView *iconView;

@property(nonatomic) NSInteger loginFailureTimes;

@end

@implementation EIBMLoginDetailController

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarTitle:@"登录"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    self.view.backgroundColor = kWhiteColor;
    [self addDefaultUser];
    self.iconView.layer.masksToBounds = YES;
    self.iconView.layer.cornerRadius = 2;
    self.loginButton.layer.masksToBounds = YES;
    self.loginButton.layer.cornerRadius = 22;
    self.phoneField.delegate = self;
    
    [self.contentView addSubview:self.iconView];
    [self.contentView addSubview:self.loginButton];
    [self.contentView addSubview:self.regButton];
    [self.contentView addSubview:self.phoneField];
    [self.contentView addSubview:self.passwordField];
    
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView.mas_top).offset(60);
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.centerX.equalTo(self.contentView.mas_centerX);
    }];
    
    [self.phoneField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
        make.height.mas_equalTo(45);
        make.top.equalTo(self.iconView.mas_bottom).offset(50);
    }];
    [self.passwordField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(30);
        make.right.equalTo(self.contentView.mas_right).offset(-30);
        make.height.mas_equalTo(45);
        make.top.equalTo(self.phoneField.mas_bottom).offset(18);
    }];
    
    [self.loginButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(15);
        make.right.equalTo(self.contentView.mas_right).offset(-15);
        make.height.mas_equalTo(45);
        make.top.equalTo(self.passwordField.mas_bottom).offset(36);
    }];
    
    [self.regButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 20));
        make.top.equalTo(self.loginButton.mas_bottom).offset(20);
        make.right.equalTo(self.loginButton.mas_right);
    }];
    
    UILabel *ruleLabel = [EIBMFactoryTool labelWithFont:[UIFont systemFontOfSize:13.0] textAlignment:NSTextAlignmentRight textColor:[UIColor lightGrayColor]];
    ruleLabel.text = @"登录表示您已阅读并同意";
    [self.contentView addSubview:ruleLabel];
    [ruleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset((SCREEN_WIDTH - 213) / 2);
        make.width.mas_equalTo(150);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-30);
        make.height.mas_equalTo(13);
    }];
    UIButton *serviceBtn = [EIBMFactoryTool buttonWithType:UIButtonTypeSystem Target:self action:@selector(serverClick) forControlEvents:UIControlEventTouchUpInside font:[UIFont systemFontOfSize:13.0] textColor:MainColor];
    [serviceBtn setTitle:@"《隐私条款》" forState:UIControlStateNormal];
    [self.contentView addSubview:serviceBtn];
    [serviceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ruleLabel.mas_right).offset(0);
        make.size.mas_equalTo(CGSizeMake(90, 43));
        make.centerY.equalTo(ruleLabel.mas_centerY);
    }];
}

- (void)serverClick {
    EIBMServerHtmlViewController *html = [EIBMServerHtmlViewController new];
    html.title = @"隐私条款";
    [self.navigationController pushViewController:html animated:YES];
}

- (void)leftButtonClick{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    NSLog(@"♻️ %@ is dealloc",NSStringFromClass([self class]));
}

#pragma mark - Actions

- (void)loginAction:(id)sender {
    [self.view endEditing:YES];
    if (![EIBMValidateTools isValidatePasswd:self.phoneField.text]) {
        [NSObject showHudTipStr:@"请输入正确格式用户名"];
        return;
    }
    
    if (![EIBMValidateTools isValidatePasswd:self.passwordField.text]) {
        [NSObject showHudTipStr:@"请输入正确格式的密码"];
        return;
    }
    
    [self login:self.phoneField.text password:self.passwordField.text];
}

//验证用户信息格式
- (BOOL)validateUserName:(NSString *)userName userPwd:(NSString *)userPwd {
    NSString *alertMessage = nil;
    if (userName.length == 0) {
        alertMessage = @"用户名不能为空!";
        return NO;
    } else if (userPwd.length == 0) {
        alertMessage = @"密码不能为空!";
        return NO;
    }
    return YES;
}
- (void)registAction:(id)sender {
    EIBMRegisterDetailController *vc = [EIBMRegisterDetailController new];
    [self.navigationController pushViewController:vc animated:YES];
}

/**
 *  登陆
 */
- (void)login:(NSString *)userName password:(NSString *)password {
    if ([self validateUserName:userName userPwd:password]) {
        EIBMUser *user = [self getUserWihtUserName:userName];
        if ([user.password isEqualToString:password]) {
            [[EIBMUserUtil sharedUserUtil] saveCache:user];
            if (self.successBlock) {
                self.successBlock();
            }
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
        } else {
            [NSObject showHudErrorStr:@"登录失败"];
        }
    } else {
        [NSObject showHudErrorStr:@"请检查用户名和密码"];
    }
}

- (void)addDefaultUser {
    NSString *userName = @"TopA12";
    NSString *password = @"t11111111";
    EIBMUser *user = [self getUserWihtUserName:userName];
    if (!user) {
        NSArray *all = [EIBMUser findAll];
        user = [[EIBMUser alloc] init];
        user.userId = [NSString stringWithFormat:@"%ld",all.count + 100000];
        user.userName = userName;
        user.password = password;
        user.collectStrings = @"UK100F.OTC,ES35F.OTC,STOXX50F.OTC,AU200F.OTC,USTEC100F.OTC,US30F.OTC,CNA50F.OTC,XAGUSD.OTC,USSI.OTC,USGC.OTC,XAUUSD.OTC,HK40F.OTC";
        [user save];
    }
}

- (EIBMUser *)getUserWihtUserName:(NSString *)userName {
    NSArray *all = [EIBMUser findAll];
    NSMutableArray *users = [NSMutableArray array];
    for (EIBMUser *user in all) {
        if ([user.userName isEqualToString:userName]) {
            [users addObject:user];
        }
    }
    if (users.count >0) {
        return users[0];
    } else {
        return nil;
    }
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"appIogal"]];
    }
    return _iconView;
}

- (UIButton *)loginButton {
    if (!_loginButton) {
        _loginButton = [EIBMFactoryTool buttonWithType:UIButtonTypeCustom Target:self action:@selector(loginAction:) forControlEvents:UIControlEventTouchUpInside font:[UIFont systemFontOfSize:17] textColor:[UIColor whiteColor]];
        [_loginButton setTitle:@"登录" forState:UIControlStateNormal];
        _loginButton.backgroundColor = MainColor;
    }
    return _loginButton;
}

- (UIButton *)regButton {
    if (!_regButton) {
        _regButton = [EIBMFactoryTool buttonWithType:UIButtonTypeCustom Target:self action:@selector(registAction:) forControlEvents:UIControlEventTouchUpInside font:[UIFont systemFontOfSize:14] textColor:MainColor];
        [_regButton setTitle:@"马上注册" forState:UIControlStateNormal];
    }
    return _regButton;
}

- (UITextField *)phoneField {
    if (!_phoneField) {
        _phoneField = [EIBMFactoryTool fieldWithPlaceholder:@"请输入用户名(6-13位)" font:[UIFont systemFontOfSize:16]];
        _phoneField.borderStyle = UITextBorderStyleRoundedRect;
    }
    return _phoneField;
}

- (UITextField *)passwordField {
    if (!_passwordField) {
        _passwordField = [EIBMFactoryTool fieldWithPlaceholder:@"请输入密码(6-13位)" font:[UIFont systemFontOfSize:16]];
        _passwordField.borderStyle = UITextBorderStyleRoundedRect;
        _passwordField.secureTextEntry = YES;
    }
    return _passwordField;
}

@end
