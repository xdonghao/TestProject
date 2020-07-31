//
//  ServerHtmlViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 07/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMServerHtmlViewController.h"
#import <WebKit/WebKit.h>

@interface EIBMServerHtmlViewController ()<WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation EIBMServerHtmlViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"隐私条款"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    _webView = [[WKWebView alloc] init];
    _webView.UIDelegate = self;
    _webView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"server"
                                                          ofType:@"html"];
    NSString * htmlCont = [NSString stringWithContentsOfFile:htmlPath
                                                    encoding:NSUTF8StringEncoding
                                                       error:nil];
    [self.webView loadHTMLString:[self reSizeImageWithHTML:htmlCont] baseURL:nil];
}

- (NSString *)reSizeImageWithHTML:(NSString *)html {
    return [NSString stringWithFormat:@"<meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0'><meta name='apple-mobile-web-app-capable' content='yes'><meta name='apple-mobile-web-app-status-bar-style' content='black'><meta name='format-detection' content='telephone=no'><style type='text/css'>img{width:%@} p{font-size:17px}</style>%@",@"100%",html];
}

@end
