//
//  CYINHotNewsViewController.m
//  CYINForwardProject
//
//  Created by MAC on 17/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "GHUKHotNewsViewController.h"
#import "GHUKNewsModel.h"
#import "GHUKNewsTableViewCell.h"
#import "CYINNewsDetailViewController.h"

@interface GHUKHotNewsViewController ()

@end

@implementation GHUKHotNewsViewController

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
    NSString *url = @"http://m.vamarket.net//user/news/findNewsList.do";
    NSDictionary *dic = @{@"offset":self.type,
                          @"size":@"20",
                          @"type":@"4"
                          };
    WEAKSELF
    [[GHUKNetworkTool sharedNetworkTool] toolRequestWithHTTPMethod:HTTPRequestMethodGet URLString:url parameters:dic complete:^(id  _Nonnull responseObject, GHUKError * _Nonnull error) {
        [weakSelf headerEndRefresh];
        if (!error) {
            NSDictionary *data = (NSDictionary *)responseObject;
            NSArray *dataArr = data[@"data"][@"data"];
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *modelDic in dataArr) {
                CYINNewsModel *model = [CYINNewsModel mj_objectWithKeyValues:modelDic];
                [array addObject:model];
            }
            [weakSelf.dataArr removeAllObjects];
            [weakSelf.dataArr addObjectsFromArray:array];
            [weakSelf cyin_AddNoDataView];
            [weakSelf.myTableView reloadData];
        } else {
            
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GHUKNewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsTableViewCell" forIndexPath:indexPath];
    [cell setDataWithSourceData:[self.dataArr objectAtIndex:indexPath.row]];
    cell.bottomLine.hidden = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [GHUKNewsTableViewCell getCellHeightWithString:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSObject *model = [self.dataArr objectAtIndex:indexPath.row];
    if ([model isKindOfClass:[GHUKNewsOtherModel class]]) {
        CYINNewsDetailViewController *web = [[CYINNewsDetailViewController alloc] init];
        GHUKNewsOtherModel *temp = (GHUKNewsOtherModel *)model;
        web.model = temp;
        [self.navigationController pushViewController:web animated:YES];
    }
    if ([model isKindOfClass:[GHUKNewsModel class]]) {
        CYINNewsDetailViewController *web = [[CYINNewsDetailViewController alloc] init];
        GHUKNewsModel *temp = (GHUKNewsModel *)model;
        web.hotModel = temp;
        [self.navigationController pushViewController:web animated:YES];
    }
}

@end
