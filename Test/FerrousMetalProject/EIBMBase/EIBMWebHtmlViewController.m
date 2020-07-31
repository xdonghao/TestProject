//
//  WebHtmlViewController.m
//  DrivingSafety
//
//  Created by 董浩 on 15/11/1.
//  Copyright (c) 2015年 zhengkai. All rights reserved.
//

#import "EIBMWebHtmlViewController.h"
#import <WebKit/WebKit.h>
@interface EIBMWebHtmlViewController ()<WKUIDelegate>{
    WKWebView *_webView;
}

@end

@implementation EIBMWebHtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:self.titleStr];
    [self setLeftButtonStyle:AAButtonStyleBack];
    [self initSubviews];
}

#pragma mark 初始化子控件
- (void)initSubviews{
    _webView = [[WKWebView alloc] init];
    _webView.UIDelegate = self;
    _webView.backgroundColor=[UIColor whiteColor];
    [self.contentView addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
