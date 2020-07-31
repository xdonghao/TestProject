//
//  ForumListViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 05/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMForumListViewController.h"
#import "EIBMPublishForumViewController.h"
#import "EIBMForumDetailViewController.h"
#import "EIBMForumManager.h"
#import "EIBMForumListModel.h"
#import "EIBMForumNewListTableViewCell.h"
#import "EIBMForumZanManager.h"
@interface EIBMForumListViewController ()

@end

@implementation EIBMForumListViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"圈子"];
    [self.navigationBarView.rightButton setTitle:@"发表" forState:UIControlStateNormal];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.bottom.equalTo(self.view);
    }];
    [self.myTableView registerClass:[EIBMForumNewListTableViewCell class] forCellReuseIdentifier:@"ForumNewListTableViewCell"];
    WEAKSELF
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.myTableView.mj_footer resetNoMoreData];
        [weakSelf loadData];
    }];
//    [self.myTableView.mj_header beginRefreshing];
}

- (void)loadData {
    [self headerEndRefresh];
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:[[EIBMForumManager shared] getForumList]];
    //屏蔽列表
    NSArray *shieldArr = [EIBMForumManager getShieldForumList];
    NSMutableArray *muArr = [NSMutableArray array];
    for (EIBMForumListModel *model in self.dataArr) {
        if ([shieldArr containsObject:model]) {
            [muArr addObject:model];
        }
    }
    [self.dataArr removeObjectsInArray:muArr];
    if (self.dataArr.count>1) {
        for (int i = 0; i < self.dataArr.count - 1; i++) {
            //比较的躺数
            for (int j = 0; j < self.dataArr.count - 1 - i; j++) {
                //比较的次数
                EIBMForumListModel *model = (EIBMForumListModel *)[self.dataArr objectAtIndex:j];
                EIBMForumListModel *model2 = (EIBMForumListModel *)[self.dataArr objectAtIndex:j+1];
                if ([model.created intValue] < [model2.created intValue]) {
                    //这里为升序排序
                    [self.dataArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                }
            }
        }
    }
    [self eibm_AddNoDataView];
    [self.myTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EIBMForumNewListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForumNewListTableViewCell" forIndexPath:indexPath];
    EIBMForumListModel *model = (EIBMForumListModel *)[self.dataArr objectAtIndex:indexPath.section];
    [cell setDataWithSourceData:model];
    cell.bottomLine.hidden = NO;
    WEAKSELF
    [cell setSuccess:^(NSInteger index, BOOL sel) {
        if (index == 0) {
            
        }
        if (index == 1) {
            EIBMForumDetailViewController *detail = [[EIBMForumDetailViewController alloc] init];
            detail.model = model;
            [weakSelf.navigationController pushViewController:detail animated:YES];
        }
        if (index == 2) {
            if (sel) {//删除
                [EIBMForumZanManager delForumFromZanList:model];
            } else {//添加
                [EIBMForumZanManager addForumToZanList:model];
            }
        }
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    EIBMForumListModel *model = (EIBMForumListModel *)[self.dataArr objectAtIndex:indexPath.section];
    return [EIBMForumNewListTableViewCell getCellHeightWithString:model.content];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    } else {
        return 0.01;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EIBMForumDetailViewController *detail = [[EIBMForumDetailViewController alloc] init];
    EIBMForumListModel *model = (EIBMForumListModel *)[self.dataArr objectAtIndex:indexPath.section];
    detail.model = model;
//    WEAKSELF
    [detail setDelSuccess:^{
//        [weakSelf loadData];
    }];
    [self.navigationController pushViewController:detail animated:YES];
}

- (void)rightButtonClick {
    if (![EIBMUserUtil sharedUserUtil].user) {
        EIBMLoginDetailController *login = [EIBMLoginDetailController new];
        EIBMBaseNavigationViewController *loginNav =[[EIBMBaseNavigationViewController alloc]initWithRootViewController:login];
        [login setSuccessBlock:^{
            
        }];
        [self presentViewController:loginNav animated:YES completion:^{
            
        }];
        return;
    }
    
    EIBMPublishForumViewController *vc = [[EIBMPublishForumViewController alloc] init];
    vc.isPublish = YES;
//    WEAKSELF
    [vc setSuccess:^(EIBMForumListModel * _Nonnull model) {
//        [weakSelf loadData];
    }];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
