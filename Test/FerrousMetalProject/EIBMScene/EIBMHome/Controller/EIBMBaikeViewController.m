//
//  EIBMBaikeViewController.m
//  EIBMForwardProject
//
//  Created by MAC on 18/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaikeViewController.h"
#import "EIBMSettingTableViewCell.h"
#import "EIBMBaikeModel.h"
#import "EIBMBaikeDetailViewController.h"
@interface EIBMBaikeViewController ()

@end

@implementation EIBMBaikeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"期货学堂"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    self.myTableView.backgroundColor = LLBackGroundWhiteColor;
    [self.myTableView registerNib:[UINib nibWithNibName:@"SettingTableViewCell" bundle:nil] forCellReuseIdentifier:@"SettingTableViewCell"];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    WEAKSELF
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.myTableView.mj_footer resetNoMoreData];
        [weakSelf loadData];
    }];
    [self.myTableView.mj_header beginRefreshing];
}

- (void)loadData {
    [self headerEndRefresh];
    [self.dataArr removeAllObjects];
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"baike_k_data" ofType:@"json"];
    NSData *dataStock2 = [NSData dataWithContentsOfFile:path2];
    NSArray *stockJson2 = [NSJSONSerialization JSONObjectWithData:dataStock2 options:0 error:nil];
    
    for (NSDictionary *modelDic in stockJson2) {
        EIBMBaikeModel *model = [EIBMBaikeModel mj_objectWithKeyValues:modelDic];
        [self.dataArr addObject:model];
    }
    [self.myTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EIBMSettingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingTableViewCell" forIndexPath:indexPath];
    EIBMBaikeModel *model = [self.dataArr objectAtIndex:indexPath.section];
    [cell setDataWithTitle:model.title detail:@""];
    cell.bottomLine.hidden = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 8;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HEADER"];
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EIBMBaikeDetailViewController *de = [EIBMBaikeDetailViewController new];
    EIBMBaikeModel *model = [self.dataArr objectAtIndex:indexPath.section];
    de.title = model.title;
    de.content = model.content;
    [self.navigationController pushViewController:de animated:YES];
    
    
}

@end
