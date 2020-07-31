//
//  BaseTableViewController.m
//  carrental
//
//  Created by liu on 16/6/18.
//  Copyright © 2016年 maple. All rights reserved.
//
#import "EIBMBaseTableViewController.h"

@implementation EIBMBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _myTableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.backgroundColor = LLBackGroundWhiteColor;

        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.rowHeight = 60;
        [self.contentView addSubview:tableView];
        tableView;
    });
    [self.myTableView registerClass:[UITableViewHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"HEADER"];
}

- (void)eibm_AddNoDataView{
    if (self.dataArr.count ==0) {
        NSString * description = @"暂无数据";
        LLNoDataView *dataView = [[LLNoDataView alloc] initImageWithFrame:self.myTableView.bounds image:[UIImage imageNamed:IMAGENOPIC] description:description canTouch:NO];
        self.myTableView.backgroundView = dataView;
    }else
        self.myTableView.backgroundView = nil;
}

- (void)setupRefresh{
    
    WEAKSELF
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.myTableView.mj_footer resetNoMoreData];
        [weakSelf loadData];
    }];
    
    self.myTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
    
}

- (NSInteger)getDay {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitDay) fromDate:[NSDate new]];
    return [dayComponents day];
}

- (void)headerEndRefresh{
    [self.myTableView.mj_header endRefreshing];
}

- (void)footerEndRefresh{
    [self.myTableView.mj_footer endRefreshing];
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell=[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    if (nil==cell) {
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"Cell"];
    }
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HEADER"];
    return header;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HEADER"];
    return header;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    self.myTableView.delegate = nil;
    self.myTableView.dataSource = nil;
}

#pragma mark
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.myTableView) {
        [self.view endEditing:YES];
    }
}

@end
