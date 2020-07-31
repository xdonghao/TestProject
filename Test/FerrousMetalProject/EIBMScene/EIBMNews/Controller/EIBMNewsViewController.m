//
//  NewsViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 31/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMNewsViewController.h"
#import "EIBMNewsModel.h"
#import "EIBMNewsTableViewCell.h"
#import "EIBMNewsOtherModel.h"
#import "EIBMNewsDetailViewController.h"

@interface EIBMNewsViewController ()

@end

@implementation EIBMNewsViewController

- (BOOL)isLoadNavigationBar {
    return NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    [self.myTableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTableViewCell"];
    WEAKSELF
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.myTableView.mj_footer resetNoMoreData];
        [weakSelf loadData];
    }];
    [self.myTableView.mj_header beginRefreshing];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"♻️ %@ is dealloc",NSStringFromClass([self class]));
}

- (void)loadData {
    NSString *url = @"https://zixun.hsmdb.com/news/getDailyNews";
    NSDictionary *dic = @{@"pageNo":@"1",
                          @"pageSize":@"30"};
    WEAKSELF
    [[EIBMNetworkTool sharedNetworkTool] toolRequestWithHTTPMethod:HTTPRequestMethodGet URLString:url parameters:dic complete:^(id  _Nonnull responseObject, EIBMError * _Nonnull error) {
        [weakSelf headerEndRefresh];
        if (!error) {
            NSDictionary *data = (NSDictionary *)responseObject;
            NSArray *dataArr = data[@"data"];
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *modelDic in dataArr) {
                EIBMNewsOtherModel *model = [EIBMNewsOtherModel mj_objectWithKeyValues:modelDic];
                model.title = [model.title stringByReplacingOccurrencesOfString:@"来牛日报：" withString:@""];
                [array addObject:model];
            }
            [weakSelf.dataArr removeAllObjects];
            [weakSelf.dataArr addObjectsFromArray:array];
            [weakSelf eibm_AddNoDataView];
            [weakSelf.myTableView reloadData];
        } else {
            
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EIBMNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsTableViewCell" forIndexPath:indexPath];
    [cell setDataWithSourceData:[self.dataArr objectAtIndex:indexPath.row]];
    cell.bottomLine.hidden = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [EIBMNewsTableViewCell getCellHeightWithString:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSObject *model = [self.dataArr objectAtIndex:indexPath.row];
    if ([model isKindOfClass:[EIBMNewsOtherModel class]]) {
        EIBMNewsDetailViewController *web = [[EIBMNewsDetailViewController alloc] init];
        EIBMNewsOtherModel *temp = (EIBMNewsOtherModel *)model;
        web.model = temp;
        [self.navigationController pushViewController:web animated:YES];
    }
}
@end
