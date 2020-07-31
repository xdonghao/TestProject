//
//  QuestionViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 31/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMQuestionViewController.h"

@interface EIBMQuestionViewController ()

/**
 *  textView
 */
@property (nonatomic, strong) UITextView *textView;
/**
 *  textView
 */
@property (nonatomic, strong) UITextView *emailView;

@end

@implementation EIBMQuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"意见反馈"];
    [self setLeftButtonStyle:AAButtonStyleBack];
//    [self.navigationBarView.rightButton setTitle:@"提交" forState:UIControlStateNormal];
    
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(7, 10, self.contentView.frame.size.width-14, 150)];
    _textView.backgroundColor = kWhiteColor;
    _textView.placeholder = @"请输入您遇到的问题或建议，我们将不断完善！";
    _textView.maxInputLength = 200;
    _textView.textColor = TitleColor;
    _textView.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:_textView];
    
    
    _emailView = [[UITextView alloc] initWithFrame:CGRectMake(7, 180, self.contentView.frame.size.width-14, 40)];
    _emailView.placeholder = @"请输入您的联系方式（可选）";
    _emailView.maxInputLength = 20;
    _emailView.backgroundColor = kWhiteColor;
    _emailView.textColor = TitleColor;
    _emailView.font = [UIFont systemFontOfSize:14.0];
    [self.contentView addSubview:_emailView];
    
    
    UIButton *btn = [EIBMFactoryTool buttonWithType:UIButtonTypeCustom Target:self action:@selector(rightButtonClick) forControlEvents:UIControlEventTouchUpInside font:[UIFont systemFontOfSize:17.0] textColor:[UIColor whiteColor]];
    btn.frame = CGRectMake(15, _emailView.bottom +20, SCREEN_WIDTH-30, 44);
    [btn setTitle:@"提交" forState:UIControlStateNormal];
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 3.0;
    [btn setBackgroundColor:MainColor];
    [self.contentView addSubview:btn];
}

- (void)rightButtonClick {
    if (_textView.text.length < 5) {
        [NSObject showHudTipStr:@"请至少输入五个字"];
        return;
    } else {
        [NSObject showHudTipStr:@"提交成功！"];
        [self.navigationController popViewControllerAnimated:YES];
    }
 
}

@end
