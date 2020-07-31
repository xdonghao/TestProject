//
//  TalkDetailViewController.m
//  EIBMGoodsProject
//
//  Created by MAC on 19/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "TalkDetailViewController.h"
#import "TalkListTableViewCell.h"
#import "NewsChatView.h"
#import "EIBMTalkDetailModel.h"
#import "EIBMTalkDetailManager.h"
#import "EIBMTalkDetailTableViewCell.h"
#import "EIBMActionSheetView.h"
@interface TalkDetailViewController ()
@property (nonatomic, strong) NewsChatView *tool;
@end

@implementation TalkDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"详情"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    //    [self.navigationBarView.rightButton setTitle:@"发布话题" forState:UIControlStateNormal];
    self.myTableView.backgroundColor = LLBackGroundWhiteColor;
    [self.view addSubview:self.tool];
    [self.tool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(50);
    }];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.bottom.equalTo(self.tool.mas_top);
    }];
    [self.myTableView registerClass:[TalkListTableViewCell class] forCellReuseIdentifier:@"TalkListTableViewCell"];
    [self.myTableView registerClass:[EIBMTalkDetailTableViewCell class] forCellReuseIdentifier:@"TalkDetailTableViewCell"];
    [self loadData];
}

- (void)loadData {
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:[[EIBMTalkDetailManager shared] getTalkListWithTalkId:self.model.talkId]];
//    if (self.dataArr.count >1) {
//        for (int i = 0; i < self.dataArr.count - 1; i++) {
//            //比较的躺数
//            for (int j = 0; j < self.dataArr.count - 1 - i; j++) {
//                //比较的次数
//                TalkDetailModel *model = (TalkDetailModel *)[self.dataArr objectAtIndex:j];
//                TalkDetailModel *model2 = (TalkDetailModel *)[self.dataArr objectAtIndex:j+1];
//                if ([model.created intValue] > [model2.created intValue]) {
//                    //这里为升序排序
//                    [self.dataArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
//                }
//            }
//        }
//    }
    [self.myTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    }else {
        return self.dataArr.count;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return 10;
    } else {
        return 35;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (section == 0) {
        return [super tableView:tableView viewForHeaderInSection:section];
    } else {
        UILabel *label = [EIBMFactoryTool labelWithFont:[UIFont boldSystemFontOfSize:15] textAlignment:NSTextAlignmentLeft textColor:MainColor];
        label.text = @"    全部评论";
        return label;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        TalkListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TalkListTableViewCell" forIndexPath:indexPath];
        cell.joinButton.hidden = YES;
        [cell setDataWithSourceData:self.model];
        cell.bottomLine.hidden = NO;
        WEAKSELF
        [cell setSuccess:^(NSInteger index) {
            if (![EIBMUserUtil sharedUserUtil].user) {
                [NSObject showHudTipStr:@"请先登录"];
                return;
            }
            if (index == 0) {
                [weakSelf eibm_JubaoClick];
            }
        }];
        return cell;
    } else {
        EIBMTalkDetailTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TalkDetailTableViewCell" forIndexPath:indexPath];
        EIBMTalkDetailModel *model = (EIBMTalkDetailModel *)[self.dataArr objectAtIndex:indexPath.row];
        [cell setDataWithSourceData:model];
        cell.bottomLine.hidden = NO;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [TalkListTableViewCell getCellHeightWithString:nil];
    } else {
        EIBMTalkDetailModel *model = (EIBMTalkDetailModel *)[self.dataArr objectAtIndex:indexPath.row];
        return [EIBMTalkDetailTableViewCell getCellHeightWithString:model.content];
    }
    
}

- (NewsChatView *)tool {
    if (!_tool) {
        _tool = [[NewsChatView alloc] init];
        WEAKSELF
        [_tool setChatBlock:^(NSString * _Nonnull content) {
            EIBMTalkDetailModel *model = [[EIBMTalkDetailModel alloc] init];
            model.content = content;
            model.userName = [EIBMUserUtil sharedUserUtil].user.userName;
            model.created = [NSDate datestrFromDate:[NSDate date] withDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            model.userImageUrl = @"";
            model.talkId = weakSelf.model.talkId;
            [[EIBMTalkDetailManager shared] addDBDataWithTalkObjects:@[model]];
            [weakSelf.dataArr addObject:model];
            [weakSelf.myTableView reloadData];
            
        }];
    }
    return _tool;
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
