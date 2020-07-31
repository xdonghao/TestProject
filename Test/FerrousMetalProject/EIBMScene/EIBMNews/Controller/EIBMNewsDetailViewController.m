//
//  NewsDetailViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 05/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMNewsDetailViewController.h"
#import <WebKit/WebKit.h>
#import "EIBMNewsDetailModel.h"
#import "NewsToolView.h"
#import "EIBMNewsChatViewController.h"
#import "EIBMNewsChatManager.h"

@interface EIBMNewsDetailViewController ()<WKUIDelegate>

@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) NewsToolView *tool;

@property (nonatomic, copy) NSArray *nameArray;
@property (nonatomic, copy) NSArray *contentArray;
@property (nonatomic, copy) NSArray *urlArray;

@end

@implementation EIBMNewsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"资讯详情"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    [[EIBMNewsChatManager shared] initSqlite];

//    NSArray *arr = [[NewsChatManager shared] getNewsChatListWithNewsId:[NSNumber numberWithInteger:[self.model.newsId integerValue]]];
//    if (arr.count == 0) {
//        int i = arc4random() % 2;
//        if (i == 1) {
//            [self insertDefaultModel];
//        }
//
//    }

    _webView = [[WKWebView alloc] init];
    _webView.UIDelegate = self;
    _webView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_webView];

//    [self.contentView addSubview:self.tool];
//    [self.tool mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self.contentView);
//        make.height.mas_equalTo(50);
//    }];

    [_webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
//        make.bottom.equalTo(self.tool.mas_top);
    }];



    NSMutableArray *muarr = [NSMutableArray arrayWithArray:[EIBMNewsChatManager getNewsToCollectList]];
    if ([muarr containsObject:self.model]) {
        self.tool.saveButton.selected = YES;
    } else {
        self.tool.saveButton.selected = NO;
    }
    if (self.hotModel) {
        [self.webView loadHTMLString:[self reSizeImageWithHTML:self.hotModel.content title:self.hotModel.title] baseURL:nil];
    }
    if (self.model) {
        [self loadData];
    }
    
}

- (void)loadData {
    NSString *urlStr = @"https://zixun.hsmdb.com/news/getNewsDetail";
    NSDictionary *dic = @{@"newId":self.model.newsId,
                          @"type":@"8"};
    WEAKSELF
    [[EIBMNetworkTool sharedNetworkTool] toolRequestWithHTTPMethod:HTTPRequestMethodGet URLString:urlStr parameters:dic complete:^(id  _Nonnull responseObject, EIBMError * _Nonnull error) {
        if (!error) {
            NSDictionary *data = (NSDictionary *)responseObject;
            NSString *string = data[@"data"][@"content"];
            string = [string stringByReplacingOccurrencesOfString:@"来牛日报" withString:@""];
            string = [string stringByReplacingOccurrencesOfString:@"来牛" withString:@""];
            [weakSelf.webView loadHTMLString:[self reSizeImageWithHTML:string title:self.model.title] baseURL:nil];
        }
    }];
}

- (NSString *)reSizeImageWithHTML:(NSString *)html title:(NSString *)title {
    return [NSString stringWithFormat:@"<html><head><meta name=\"viewport\" content=\"width=device-width,initial-scale=1.0\"><style>html {width: 100%%;margin: 0;padding: 0;} body {width: 100%%;font-family: \"PingFangSC-Regular\", \"Helvetica Neue\", Helvetica, Arial, sans-serif;color: #555;font-size: 16px;margin: 0;padding: 0;} .wrapper { padding: 15px; } h2 { width: 100%%; display: block; } img {width: 100%%;display: block;} p { margin-bottom: 15px; line-height: 1.6 } .tip-declare { margin-top: 30px; color: #666; padding-bottom: 20px; } .declare-title { font-size: 14px; } .declare-text { color: #999999; font-family: \"PingFangSC-Regular\"; font-size: 13px; } </style> </head> <body> <div class=\"wrapper\"><h2>%@</h2>%@</div> </body> </html>",title,html];
}

- (void)insertDefaultModel {
    int n = arc4random() % [self.nameArray count];
    NSString *name = self.nameArray[n];
    
    int c = arc4random() % [self.contentArray count];
    NSString *content = self.contentArray[c];
    
    int u = arc4random() % [self.urlArray count];
    NSString *url = self.urlArray[u];
    
    
    NewsChatModel *model = [[NewsChatModel alloc] init];
    model.userName = name;
    model.content = content;
    model.newsId = [NSNumber numberWithInteger:[self.model.newsId integerValue]];
    model.created = [NSNumber numberWithLong:[[NSDate date] utcTimeStamp] - 20];
    model.userImageUrl = url;
    [[EIBMNewsChatManager shared] insertWithNewsChatListObjects:model];
}

- (NSArray *)nameArray {
    if (!_nameArray) {
        _nameArray = @[@"上鼓", @"叮当",@"华哥230",@"西北小熊545",@"用户赤脚医生",@"云岭观世",@"铁岭文人",@"正亿使者",@"A5582",@"胖鸽子",@"ryih",@"爱吃肉肉的老鼠",@"我爱吃西瓜",@"i清心i",@"尾大的断段",@"花丶弄丶影",@"轻描SV淡写",@"和谐的小帅帅",@"十九啊",@"哎呦-我去",@"盗风-",@"EIena",@"鬼鬼鹏飞",@"雪之冰魄"];
    }
    return _nameArray;
}

- (NSArray *)urlArray {
    if (!_urlArray) {
        _urlArray = @[@"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/7f2b7869616fe5a790e8afb77869e9878ddc27.jpg",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/563178696e70656e67313130300d0d.jpg",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/f8106a6f686e5f6669f706.jpg",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/f363e9a38ee99ba8e59180690f9c.jpg",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/076573756e3238373333383837332a17.jpg",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/681ae5ae89e4b98be88ba5e88b8f301d31.jpg",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/7be3e697a0e9a38ee8b5b7e6b5aa6479bf52?t=1562244938",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/c081e889afe8a1abe99d92e5b9b4e935?t=1566240388",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/9817e591bce5bbb6e5bd925fe8?t=1564392191",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/9573e68095e5ada4e58d95e8b68ae5ada4e58d9570f9?t=1566045743",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/52a967676736363437bebc?t=1551253820",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/9958e99e8de5b1b1e5a5bde788b8e788b87d54?t=1561528547",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/244be591bde8bf903538397e30?t=1562163493",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/8c5ce69292e58aa030353330g77fa00100000?t=1564480897",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/c9226a69616e64616e34353637318329?t=1387179932",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/ef44e5bf83e4b8ade4b880e69d86e7a7b0e591807718",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/d1d1e8b081e695a2e697a5e68891e8bf99e69da1e78b97a57b?t=1517307011",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/69b9e9a9b1e5a49ce4b8b6e696ade68481a541?t=1509418360",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/e1e2e9b985e8868fe5909b5e61?t=1562424766",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/fec4e68891e4b88de683b3e68294e681a8ea4a?t=1486489172",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/3709e8bf87e69da5e68891e590a73838c997?t=1563906266",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/2ed3e98d9ae69b9ae7ac81e690b4e78784e78587c286?t=1565974826",
                      @"https://imgsa.baidu.com/forum/eWH=150,150;bp=1090134,0,0,200/sign=efb5c4ebbe003af35fd0a16d041ff670/83025aafa40f4bfb228bbab60b4f78f0f63618fc.jpg",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/a09ee5a2a8e79795799711",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/2cc44c5f6369636b7417",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/7f2b7869616fe5a790e8afb77869e9878ddc27",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/cd90e8bf98e69c89e688917a78633039?t=1515642330",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/8322e8a382e7a9bae982aae7a59e165c?t=1563865571",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/0f0ee88ab1e4b8b6e5bc84e4b8b6e5bdb1b42b?t=1479283748",
                      @"https://gss0.bdstatic.com/6LZ1dD3d1sgCo2Kml5_Y_D3/sys/portrait/item/ffb2e5b0bee5a4a7e79a84e696ade6aeb51297?t=1563879387"];
    }
    return _urlArray;
}

- (NSArray *)contentArray {
    if (!_contentArray) {
        _contentArray = @[@"赞同", @"OK",@"不错！！！！！",@"秘诀：盈利好似捞套牛，亏损胜过脱缰马",@"先买几手空浮亏再买几手多反转信号出现再多转空",@"跌了就把期货卖掉，买10吨现货回来",@"受用无穷，谢谢作者",@"很贴近现实",@"看的不过瘾啊",@"哎",@"难得吐真言，知者廖无几",@"把长线当做短线做",@"大道至简，真经难求",@"作者说的对"];
    }
    return _contentArray;
}

- (NewsToolView *)tool {
    if (!_tool) {
        _tool = [[NewsToolView alloc] init];
        WEAKSELF
        [_tool setChatBlock:^{
            if (![EIBMUserUtil sharedUserUtil].user) {
                [NSObject showHudTipStr:@"请先登录"];
                return;
            }
            EIBMNewsChatViewController *chat = [EIBMNewsChatViewController new];
            chat.newsId = [NSNumber numberWithInteger:[weakSelf.model.newsId integerValue]];
            [weakSelf.navigationController pushViewController:chat animated:YES];
        }];
        
        [_tool setSaveBlock:^{
            if (weakSelf.tool.saveButton.selected == YES) {
                [EIBMNewsChatManager delNewsFromCollectList:weakSelf.model];
                [NSObject showHudTipStr:@"已取消收藏"];
            } else {
                [EIBMNewsChatManager addNewsToCollectList:weakSelf.model];
                [NSObject showHudTipStr:@"收藏成功"];
            }
        }];
        
    }
    return _tool;
}
@end
