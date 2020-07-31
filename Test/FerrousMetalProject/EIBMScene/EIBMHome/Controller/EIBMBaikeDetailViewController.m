//
//  EIBMBaikeDetailViewController.m
//  EIBMForwardProject
//
//  Created by MAC on 18/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaikeDetailViewController.h"
#import <WebKit/WebKit.h>
@interface EIBMBaikeDetailViewController ()<WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation EIBMBaikeDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLeftButtonStyle:AAButtonStyleBack];
    _webView = [[WKWebView alloc] init];
    _webView.UIDelegate = self;
    _webView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_webView];
    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    [self.webView loadHTMLString:[self reSizeImageWithHTML:self.content title:self.title] baseURL:nil];
}

- (NSString *)reSizeImageWithHTML:(NSString *)html title:(NSString *)title {
    return [NSString stringWithFormat:@"<html><head><meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0\"><style>html {width: 100%%;margin: 0;padding: 0;} body {width: 100%%;font-family: \"PingFangSC-Regular\", \"Helvetica Neue\", Helvetica, Arial, sans-serif;color: #555;font-size: 16px;margin: 0;padding: 0;} .wrapper { padding: 15px; } h2 { width: 100%%; display: block; } img {width: 100%%;display: block;} p { margin-bottom: 15px; line-height: 1.6 } .tip-declare { margin-top: 30px; color: #666; padding-bottom: 20px; } .declare-title { font-size: 14px; } .declare-text { color: #999999; font-family: \"PingFangSC-Regular\"; font-size: 13px; } </style> </head> <body> <div class=\"wrapper\"><h2>%@</h2>%@</div> </body> </html>",title,html];
}

@end
