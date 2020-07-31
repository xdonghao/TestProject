//
//  MyShieldViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 08/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMMyShieldViewController.h"
#import "EIBMPublishForumViewController.h"
#import "EIBMForumDetailViewController.h"
#import "EIBMForumManager.h"
#import "EIBMForumListModel.h"
#import "EIBMForumNewListTableViewCell.h"
#import "EIBMForumZanManager.h"
@interface EIBMMyShieldViewController ()

@end

@implementation EIBMMyShieldViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"黑名单"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.myTableView registerClass:[EIBMForumNewListTableViewCell class] forCellReuseIdentifier:@"ForumNewListTableViewCell"];
    WEAKSELF
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.myTableView.mj_footer resetNoMoreData];
        [weakSelf loadData];
    }];
}

- (void)loadData {
    [self headerEndRefresh];
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:[EIBMForumManager getShieldForumList]];
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
    [cell setDataWithSourceData:[self.dataArr objectAtIndex:indexPath.section]];
    EIBMForumListModel *model = (EIBMForumListModel *)[self.dataArr objectAtIndex:indexPath.section];
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
    WEAKSELF
    [detail setDelSuccess:^{
        [weakSelf loadData];
    }];
    [self.navigationController pushViewController:detail animated:YES];
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EIBMForumListModel *model = (EIBMForumListModel *)[self.dataArr objectAtIndex:indexPath.section];
        [self.dataArr removeObject:model];
        [EIBMForumManager setShieldForumList:self.dataArr];
        [NSObject showHudTipStr:@"已解除屏蔽"];
        [self.myTableView reloadData];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"解除屏蔽";
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (NSString *)stringWithMoney:(CGFloat)money {
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = NSNumberFormatterCurrencyStyle;
    formatter.currencySymbol = @"￥";
    formatter.minimumFractionDigits = 0;
    formatter.maximumFractionDigits = 2;
    return [formatter stringFromNumber:@(money)];
}

@end
