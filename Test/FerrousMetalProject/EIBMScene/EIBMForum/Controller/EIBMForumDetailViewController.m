//
//  ForumDetailViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMForumDetailViewController.h"
#import "EIBMForumDetailHeadTableViewCell.h"
#import "EIBMForumManager.h"
#import "EIBMForumReplyManager.h"
#import "EIBMPublishForumViewController.h"
#import "EIBMActionSheetView.h"
#import "NewsChatView.h"

@interface EIBMForumDetailViewController ()
@property (nonatomic, strong) NewsChatView *tool;
@end

@implementation EIBMForumDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLeftButtonStyle:AAButtonStyleBack];
    [self setRightButtonStyle:AAButtonStyleMore];
    [self.myTableView registerClass:[EIBMForumDetailHeadTableViewCell class] forCellReuseIdentifier:@"ForumDetailHeadTableViewCell"];
    [self.view addSubview:self.tool];
    [self.tool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.bottom.equalTo(self.tool.mas_top);
    }];
    [self loadData];
}

- (void)loadData {
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:[[EIBMForumReplyManager shared] getForumReplyListWithArticleId:self.model.articleId]];
    if (self.dataArr.count >1) {
        for (int i = 0; i < self.dataArr.count - 1; i++) {
            //比较的躺数
            for (int j = 0; j < self.dataArr.count - 1 - i; j++) {
                //比较的次数
                EIBMForumListModel *model = (EIBMForumListModel *)[self.dataArr objectAtIndex:j];
                EIBMForumListModel *model2 = (EIBMForumListModel *)[self.dataArr objectAtIndex:j+1];
                if ([model.created intValue] > [model2.created intValue]) {
                    //这里为升序排序
                    [self.dataArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                }
            }
        }
    }
    [self.myTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else {
        return self.dataArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    } else {
        return 25;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [super tableView:tableView viewForHeaderInSection:section];
    } else {
        UILabel *label = [EIBMFactoryTool labelWithFont:[UIFont boldSystemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:TitleColor];
        label.text = @"    全部评论";
        return label;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        EIBMForumDetailHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForumDetailHeadTableViewCell" forIndexPath:indexPath];
        cell.nameLabel.textColor = TitleColor;
        cell.moreButton.hidden = YES;
        [cell setDataWithSourceData:self.model];
        return cell;
    } else {
        EIBMForumDetailHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForumDetailHeadTableViewCell" forIndexPath:indexPath];
        cell.nameLabel.textColor = RGB(100, 152, 206);
        cell.moreButton.hidden = NO;
        [cell setDataWithSourceData:self.dataArr[indexPath.row]];
        WEAKSELF
        [cell setMoreBlock:^{
            [weakSelf jubaopinglunWithRow:indexPath.row];
        }];
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [EIBMForumDetailHeadTableViewCell getCellHeightWithString:self.model.content];
    } else {
        EIBMForumListModel *model = self.dataArr[indexPath.row];
        return [EIBMForumDetailHeadTableViewCell getCellHeightWithString:model.content];
    }
    
}


- (void)btnClick {
//    if (![EIBMUserUtil sharedUserUtil].user) {
//        EIBMLoginDetailController *login = [EIBMLoginDetailController new];
//        EIBMBaseNavigationViewController *loginNav =[[EIBMBaseNavigationViewController alloc]initWithRootViewController:login];
//        [login setSuccessBlock:^{
//
//        }];
//        [self presentViewController:loginNav animated:YES completion:^{
//
//        }];
//        return;
//    }
//    EIBMPublishForumViewController *vc = [[EIBMPublishForumViewController alloc] init];
//    vc.articleId = self.model.articleId;
//    WEAKSELF
//    [vc setSuccess:^(EIBMForumListModel * _Nonnull model) {
//        [weakSelf.dataArr addObject:model];
//        [weakSelf.myTableView reloadData];
//    }];
//    [self.navigationController pushViewController:vc animated:YES];
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
    NSMutableArray * arr = [NSMutableArray arrayWithArray:[EIBMForumManager getForumList]];
    BOOL havCollect = NO;
    NSMutableArray *collectArr = [NSMutableArray array];
    for (EIBMForumListModel *model in arr) {
        if ([model.articleId integerValue] == [self.model.articleId integerValue]) {
            havCollect = YES;
            [collectArr addObject:model];
        }
    }
    NSMutableArray * shieldArr = [NSMutableArray arrayWithArray:[EIBMForumManager getShieldForumList]];
    BOOL havShield = NO;
    NSMutableArray *shieldMuArr = [NSMutableArray array];
    for (EIBMForumListModel *model in shieldArr) {
        if ([model.articleId integerValue] == [self.model.articleId integerValue]) {
            havShield = YES;
            [shieldMuArr addObject:model];
        }
    }
    
    WEAKSELF
    NSMutableArray *titlearr = [NSMutableArray arrayWithObject:@"举报"];
    if (havShield) {
        [titlearr addObject:@"解除屏蔽"];
    } else {
        [titlearr addObject:@"屏蔽"];
    }
    if (havCollect) {
        [titlearr addObject:@"取消收藏"];
    } else {
        [titlearr addObject:@"收藏"];
    }
    
    
    EIBMActionSheetView *actionsheet = [[EIBMActionSheetView alloc] initWithShareHeadOprationWith:titlearr andImageArry:@[] andProTitle:@"" and:ShowTypeIsActionSheetStyle];
    [actionsheet setBtnClick:^(NSInteger btnTag) {
        if (btnTag == 0) {
            [weakSelf eibm_JubaoClick];
        } else if (btnTag == 1){
            
            if (shieldArr.count >0) {
                if (havShield == NO) { // shieldArr addObject:self.model];
                    [shieldArr addObject:self.model];
                    [EIBMForumManager setShieldForumList:shieldArr];
                    [NSObject showHudTipStr:@"已帮您屏蔽此条信息"];
                } else { //取消屏蔽
                    [shieldArr removeObjectsInArray:shieldMuArr];
                    [EIBMForumManager setShieldForumList:shieldArr];
                    [NSObject showHudTipStr:@"已解除屏蔽"];
                }
            } else {
                NSArray *newarr = [NSArray arrayWithObject:self.model];
                [EIBMForumManager setShieldForumList:newarr];
                [NSObject showHudTipStr:@"已帮您屏蔽此条信息"];
            }
            if (weakSelf.delSuccess) {
                weakSelf.delSuccess();
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
//            [[ForumManager shared] delateObjectWithAritcleID:weakSelf.model.articleId];
            
        } else {
            if (arr.count > 0) {
                if (havCollect == NO) {
                    [arr addObject:self.model];
                    [EIBMForumManager setForumList:arr];
                    [NSObject showHudTipStr:@"收藏成功"];
                } else {
                    [arr removeObjectsInArray:collectArr];
                    [EIBMForumManager setForumList:arr];
                    [NSObject showHudTipStr:@"已取消收藏"];
                }
            } else {
                NSArray *newarr = [NSArray arrayWithObject:self.model];
                [EIBMForumManager setForumList:newarr];
                [NSObject showHudTipStr:@"收藏成功"];
            }
            
        }
        [weakSelf.myTableView reloadData];
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:actionsheet];
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
    WEAKSELF
    NSArray *titlearr = @[@"恶意评论",@"广告宣传",@"其他"];
    EIBMActionSheetView *actionsheet = [[EIBMActionSheetView alloc] initWithShareHeadOprationWith:titlearr andImageArry:@[] andProTitle:@"" and:ShowTypeIsActionSheetStyle];
    [actionsheet setBtnClick:^(NSInteger btnTag) {
        [NSObject showHudTipStr:@"举报成功，我们会在24小时内对内容进行审核"];
        [weakSelf.myTableView reloadData];
    }];
    [[UIApplication sharedApplication].keyWindow addSubview:actionsheet];
}

- (void)jubaopinglunWithRow:(NSInteger)row {
    if (![EIBMUserUtil sharedUserUtil].user) {
        EIBMLoginDetailController *login = [EIBMLoginDetailController new];
        EIBMBaseNavigationViewController *loginNav =[[EIBMBaseNavigationViewController alloc]initWithRootViewController:login];
        [login setSuccessBlock:^{
            
        }];
        [self presentViewController:loginNav animated:YES completion:^{
            
        }];
        return;
    }
    EIBMForumListModel *model = self.dataArr[row];
    if ([model.userName isEqualToString:[EIBMUserUtil sharedUserUtil].user.userName]) {
        return;
    }
    NSString *message = [NSString stringWithFormat:@"是否举报用户”%@“的评论",model.userName];
    WEAKSELF
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        [weakSelf eibm_JubaoClick];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (NewsChatView *)tool {
    if (!_tool) {
        _tool = [[NewsChatView alloc] init];
        WEAKSELF
        [_tool setChatBlock:^(NSString * _Nonnull content) {
            EIBMForumListModel *model = [[EIBMForumListModel alloc] init];
            model.content = content;
            model.userName = [EIBMUserUtil sharedUserUtil].user.userName;
            model.created = [NSNumber numberWithLong:[[NSDate date] utcTimeStamp]];
            model.userImageUrl = @"";
            model.articleId = weakSelf.model.articleId;
            [[EIBMForumReplyManager shared] addDBDataWithForumReplyObjects:@[model]];
            [weakSelf.dataArr addObject:model];
            [weakSelf.myTableView reloadData];
            
        }];
    }
    return _tool;
}

@end
