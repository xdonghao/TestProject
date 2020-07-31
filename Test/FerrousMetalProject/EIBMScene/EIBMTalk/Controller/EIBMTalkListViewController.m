//
//  TalkListViewController.m
//  EIBMGoodsProject
//
//  Created by MAC on 19/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMTalkListViewController.h"
#import "TalkListTableViewCell.h"
#import "TalkListModel.h"
#import "EIBMTalkListManager.h"
#import "TalkDetailViewController.h"
#import "EIBMActionSheetView.h"
#import "TalkSendViewController.h"
@interface EIBMTalkListViewController ()

@end

@implementation EIBMTalkListViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"话题"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    [self setRightButtonStyle:AAButtonStyleAdd];
//    [self.navigationBarView.rightButton setTitle:@"发布话题" forState:UIControlStateNormal];
    self.myTableView.backgroundColor = [UIColor whiteColor];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.bottom.equalTo(self.view);
    }];
    [self.myTableView registerClass:[TalkListTableViewCell class] forCellReuseIdentifier:@"TalkListTableViewCell"];
    WEAKSELF
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.myTableView.mj_footer resetNoMoreData];
        [weakSelf loadData];
    }];
    [self loadData];
}

- (void)loadData {
    [self headerEndRefresh];
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:[[EIBMTalkListManager shared] getTalkList]];
    //屏蔽列表
//    NSArray *shieldArr = [EIBMForumManager getShieldForumList];
//    NSMutableArray *muArr = [NSMutableArray array];
//    for (EIBMForumListModel *model in self.dataArr) {
//        if ([shieldArr containsObject:model]) {
//            [muArr addObject:model];
//        }
//    }
//    [self.dataArr removeObjectsInArray:muArr];
//    if (self.dataArr.count>1) {
//        for (int i = 0; i < self.dataArr.count - 1; i++) {
//            //比较的躺数
//            for (int j = 0; j < self.dataArr.count - 1 - i; j++) {
//                //比较的次数
//                EIBMForumListModel *model = (EIBMForumListModel *)[self.dataArr objectAtIndex:j];
//                EIBMForumListModel *model2 = (EIBMForumListModel *)[self.dataArr objectAtIndex:j+1];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TalkListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TalkListTableViewCell" forIndexPath:indexPath];
    TalkListModel *model = (TalkListModel *)[self.dataArr objectAtIndex:indexPath.section];
    [cell setDataWithSourceData:model];
    cell.bottomLine.hidden = NO;
    WEAKSELF
    [cell setSuccess:^(NSInteger index) {
        if (index == 0) {
            if (![EIBMUserUtil sharedUserUtil].user) {
                [NSObject showHudTipStr:@"请先登录"];
                return;
            }
            [weakSelf eibm_JubaoClick];
        }
        if (index == 1) {
            TalkDetailViewController *detail = [[TalkDetailViewController alloc] init];
            detail.model = model;
            [weakSelf.navigationController pushViewController:detail animated:YES];
        }
        
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TalkListModel *model = (TalkListModel *)[self.dataArr objectAtIndex:indexPath.section];
    return [TalkListTableViewCell getCellHeightWithString:model.title];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    } else {
        return 0.01;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    EIBMForumDetailViewController *detail = [[EIBMForumDetailViewController alloc] init];
//    EIBMForumListModel *model = (EIBMForumListModel *)[self.dataArr objectAtIndex:indexPath.section];
//    detail.model = model;
//    //    WEAKSELF
//    [detail setDelSuccess:^{
//        //        [weakSelf loadData];
//    }];
//    [self.navigationController pushViewController:detail animated:YES];
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
    
    TalkSendViewController *vc = [[TalkSendViewController alloc] init];
//    vc.isPublish = YES;
    WEAKSELF
    [vc setSuccess:^(TalkListModel * _Nonnull model) {
        [weakSelf loadData];
    }];
//    [vc setSuccess:^(EIBMForumListModel * _Nonnull model) {
//        //        [weakSelf loadData];
//    }];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)eibm_JubaoClick {
    if (![EIBMUserUtil sharedUserUtil].user) {
        EIBMLoginDetailController *login = [EIBMLoginDetailController new];
        EIBMBaseNavigationViewController *loginNav =[[EIBMBaseNavigationViewController alloc]initWithRootViewController:login];
        [login setSuccessBlock:^{
            
        }];
        [self presentViewController:loginNav animated:YES completion:^{
            
        }];
        return;
    }
    NSArray *titlearr = @[@"违法违规",@"不实信息",@"广告宣传",@"其他"];
    EIBMActionSheetView *actionsheet = [[EIBMActionSheetView alloc] initWithShareHeadOprationWith:titlearr andImageArry:@[] andProTitle:@"" and:ShowTypeIsActionSheetStyle];
    [actionsheet setBtnClick:^(NSInteger btnTag) {
        [NSObject showHudTipStr:@"举报成功，我们会在24小时内对内容进行审核"];
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:actionsheet];
}

@end
