//
//  NewsCalendarViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 14/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMNewsCalendarViewController.h"
#import "EIBMNewsCalendarModel.h"
#import "EIBMNewsCalendarTableViewCell.h"
@interface EIBMNewsCalendarViewController ()

@end

@implementation EIBMNewsCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"财经日历"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    [self.myTableView registerNib:[UINib nibWithNibName:@"NewsCalendarTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsCalendarTableViewCell"];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.contentView);
    }];
    WEAKSELF
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.myTableView.mj_footer resetNoMoreData];
        [weakSelf loadData];
    }];
    [self.myTableView.mj_header beginRefreshing];
}

- (void)loadData {
    NSString *dateTime = [NSDate datestrFromDate:[NSDate date] withDateFormat:@"yyyy-MM-dd"];
    NSString *url = @"https://api.oil-fut.com/new-article";
    NSDictionary *dic = @{@"type":@"2",
                          @"pageSize":@"20",
                          @"pageNumber":@"1",
                          @"dataTime":dateTime,
                          @"api" : @"newsContentList",
                          @"project":Project
                          };
    WEAKSELF
    [[EIBMNetworkTool sharedNetworkTool] toolRequestWithHTTPMethod:HTTPRequestMethodGet URLString:url parameters:dic complete:^(id  _Nonnull responseObject, EIBMError * _Nonnull error) {
        [weakSelf headerEndRefresh];
        if (!error) {
            NSDictionary *data = (NSDictionary *)responseObject;
            NSArray *dataArr = data[@"data"][@"list"][@"list"];
            if (dataArr.count > 0) {
                NSMutableArray *array = [NSMutableArray array];
                for (NSDictionary *modelDic in dataArr) {
                    EIBMNewsCalendarModel *model = [EIBMNewsCalendarModel mj_objectWithKeyValues:modelDic];
                    [array addObject:model];
                }
                [weakSelf.dataArr removeAllObjects];
                [weakSelf.dataArr addObjectsFromArray:array];
                [weakSelf eibm_AddNoDataView];
                [weakSelf.myTableView reloadData];
            } else {
                [weakSelf loadLoalData];
            }
            
        } else {
            [weakSelf loadLoalData];
        }
    }];
}

- (void)loadLoalData {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Calendar_k_data" ofType:@"json"];
    NSData *dataStock = [NSData dataWithContentsOfFile:path];
    NSDictionary *data = [NSJSONSerialization JSONObjectWithData:dataStock options:0 error:nil];
    NSArray *dataArr = data[@"data"][@"list"][@"list"];
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *modelDic in dataArr) {
        EIBMNewsCalendarModel *model = [EIBMNewsCalendarModel mj_objectWithKeyValues:modelDic];
        [array addObject:model];
    }
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:array];
    [self eibm_AddNoDataView];
    [self.myTableView reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EIBMNewsCalendarTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"NewsCalendarTableViewCell" forIndexPath:indexPath];
    [cell setDataWithSourceData:[self.dataArr objectAtIndex:indexPath.row]];
    [cell showBottomLine];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 85;
}

@end
