//
//  ClassroomViewController.m
//  BlackWhiteFuProject
//
//  Created by MAC on 02/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMClassroomViewController.h"
#import "EIBMClassroomTableViewCell.h"
#import "EIBMClassroomHeaderView.h"
#import "EIBMClassroomModel.h"

@interface EIBMClassroomViewController ()

@end

@implementation EIBMClassroomViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"专家课堂"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView);
    }];
    [self.myTableView registerClass:[EIBMClassroomTableViewCell class] forCellReuseIdentifier:@"ClassroomTableViewCell"];
    [self.myTableView registerClass:[EIBMClassroomHeaderView class] forHeaderFooterViewReuseIdentifier:@"ClassroomHeaderView"];
    WEAKSELF
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.myTableView.mj_footer resetNoMoreData];
        [weakSelf loadData];
    }];
    [self.myTableView.mj_header beginRefreshing];
}

- (void)loadData {
    [self headerEndRefresh];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"classroom_k_data" ofType:@"json"];
    NSData *dataStock = [NSData dataWithContentsOfFile:path];
    NSArray *data = [NSJSONSerialization JSONObjectWithData:dataStock options:0 error:nil];
    [self.dataArr removeAllObjects];
    for (NSDictionary *dic in data) {
        EIBMClassroomModel *model = [EIBMClassroomModel mj_objectWithKeyValues:dic];
        [self.dataArr addObject:model];
    }
    [self.myTableView reloadData];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    EIBMClassroomHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"ClassroomHeaderView"];
//    EIBMClassroomModel *model = self.dataArr[section];
    header.backgroundColor = LLBackGroundWhiteColor;
//    header.timeLabel.text = model.time;
    header.timeLabel.backgroundColor = LLBackGroundWhiteColor;
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    EIBMClassroomModel *model = self.dataArr[indexPath.section];
    return [EIBMClassroomTableViewCell getCellHeightWithString:model.content];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EIBMClassroomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ClassroomTableViewCell" forIndexPath:indexPath];
    EIBMClassroomModel *model = self.dataArr[indexPath.section];
    [cell setDataWithSourceData:model];
    return cell;
}

@end
