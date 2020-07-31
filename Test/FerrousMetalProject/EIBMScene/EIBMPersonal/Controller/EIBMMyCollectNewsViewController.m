//
//  MyCollectNewsViewController.m
//  EIBMBestMetal
//
//  Created by MAC on 20/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMMyCollectNewsViewController.h"
#import "EIBMNewsTableViewCell.h"
#import "EIBMNewsDetailViewController.h"
#import "EIBMNewsChatManager.h"

@interface EIBMMyCollectNewsViewController ()

@end

@implementation EIBMMyCollectNewsViewController

- (BOOL)isLoadNavigationBar {
    return NO;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self.myTableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTableViewCell"];
    WEAKSELF
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.myTableView.mj_footer resetNoMoreData];
        [weakSelf loadData];
    }];
}

- (void)loadData {
    [self headerEndRefresh];
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:[EIBMNewsChatManager getNewsToCollectList]];
//    if (self.dataArr.count>1) {
//        for (int i = 0; i < self.dataArr.count - 1; i++) {
//            //比较的躺数
//            for (int j = 0; j < self.dataArr.count - 1 - i; j++) {
//                //比较的次数
//                EIBMNewsOtherModel *model = (EIBMNewsOtherModel *)[self.dataArr objectAtIndex:j];
//                EIBMNewsOtherModel *model2 = (EIBMNewsOtherModel *)[self.dataArr objectAtIndex:j+1];
//                if ([model.created intValue] < [model2.created intValue]) {
//                    //这里为升序排序
//                    [self.dataArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
//                }
//            }
//        }
//    }
    [self eibm_AddNoDataView];
    [self.myTableView reloadData];
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

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        EIBMForumListModel *model = (EIBMForumListModel *)[self.dataArr objectAtIndex:indexPath.section];
//        [self.dataArr removeObject:model];
//        [EIBMForumManager setForumList:self.dataArr];
//        [NSObject showHudTipStr:@"已取消收藏"];
//        [self.myTableView reloadData];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"取消收藏";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

@end
