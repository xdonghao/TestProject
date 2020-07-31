//
//  ADNewsFarstViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 12/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMNewsFarstViewController.h"
#import "EIBMNewsFarstTableViewCell.h"
#import "EIBMNewsFarstModel.h"

@interface EIBMNewsFarstViewController ()

@end

@implementation EIBMNewsFarstViewController
- (BOOL)isLoadNavigationBar {
    return NO;
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    [self.myTableView  registerClass:[EIBMNewsFarstTableViewCell class] forCellReuseIdentifier:@"NewsFarstTableViewCell"];
    WEAKSELF
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.myTableView.mj_footer resetNoMoreData];
        [weakSelf loadData];
    }];
    [self.myTableView.mj_header beginRefreshing];
}

- (void)loadData {
    self.page = 1;
    NSString *url = NEWS_KuaiXun;
    NSDictionary *dic = @{@"pageIndex":@(self.page),
                          @"api" : @"kuaixunList",
                          @"project":Project
                          };
    WEAKSELF
    [[EIBMNetworkTool sharedNetworkTool] toolRequestWithHTTPMethod:HTTPRequestMethodGet URLString:url parameters:dic complete:^(id  _Nonnull responseObject, EIBMError * _Nonnull error) {
        [weakSelf headerEndRefresh];
        if (!error) {
            NSDictionary *data = (NSDictionary *)responseObject;
            NSArray *dataArr = data[@"data"][@"Items"];
            NSDictionary *ddddic = dataArr[0];
            NSArray *aray = ddddic[@"Items"];
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *modelDic in aray) {
                EIBMNewsFarstModel *model = [EIBMNewsFarstModel mj_objectWithKeyValues:modelDic];
                model.Title = [weakSelf filterHTML:model.Title];
                [array addObject:model];
            }
            [weakSelf.dataArr removeAllObjects];
            [weakSelf.dataArr addObjectsFromArray:array];
            [weakSelf eibm_AddNoDataView];
            [weakSelf.myTableView reloadData];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EIBMNewsFarstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsFarstTableViewCell" forIndexPath:indexPath];
    [cell setDataWithSourceData:[self.dataArr objectAtIndex:indexPath.row]];
    cell.bottomLine.hidden = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    EIBMNewsFarstModel *model = [self.dataArr objectAtIndex:indexPath.row];
    return [EIBMNewsFarstTableViewCell getCellHeightWithString:model.Title];
}

-(NSString *)filterHTML:(NSString *)html
{
    NSScanner * scanner = [NSScanner scannerWithString:html];
    NSString * text = nil;
    while([scanner isAtEnd]==NO)
    {
        //找到标签的起始位置
        [scanner scanUpToString:@"<" intoString:nil];
        //找到标签的结束位置
        [scanner scanUpToString:@">" intoString:&text];
        //替换字符
        html = [html stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@>",text] withString:@""];     }
    return html;
}

@end
