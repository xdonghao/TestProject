//
//  NewsChatViewController.m
//  EIBMBestMetal
//
//  Created by MAC on 19/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMNewsChatViewController.h"
#import "NewsChatView.h"
#import "NewsChatModel.h"
#import "EIBMNewsChatManager.h"
#import "EIBMForumDetailHeadTableViewCell.h"
@interface EIBMNewsChatViewController ()
@property (nonatomic, strong) NewsChatView *tool;
@end

@implementation EIBMNewsChatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"评论"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    [self.myTableView registerClass:[EIBMForumDetailHeadTableViewCell class] forCellReuseIdentifier:@"ForumDetailHeadTableViewCell"];
    [self.contentView addSubview:self.tool];
    [self.tool mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.contentView);
        make.height.mas_equalTo(50);
    }];
    
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.bottom.equalTo(self.tool.mas_top);
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
    NSArray *arr = [[EIBMNewsChatManager shared] getNewsChatListWithNewsId:self.newsId];
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:arr];

    //屏蔽列表
    NSArray *blackArr = [EIBMNewsChatManager getBlackChatMessageListWithNewsId:self.newsId];
    NSMutableArray *muArr = [NSMutableArray array];
    for (NewsChatModel *model in self.dataArr) {
        if ([blackArr containsObject:model]) {
            [muArr addObject:model];
        }
    }
    [self.dataArr removeObjectsInArray:muArr];
    
    if (self.dataArr.count >1) {
        for (int i = 0; i < self.dataArr.count - 1; i++) {
            //比较的躺数
            for (int j = 0; j < self.dataArr.count - 1 - i; j++) {
                //比较的次数
                NewsChatModel *model = (NewsChatModel *)[self.dataArr objectAtIndex:j];
                NewsChatModel *model2 = (NewsChatModel *)[self.dataArr objectAtIndex:j+1];
                if ([model.created intValue] > [model2.created intValue]) {
                    //这里为升序排序
                    [self.dataArr exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                }
            }
        }
    }
    [self eibm_AddNoDataView];
    [self.myTableView reloadData];
}

- (void)eibm_AddNoDataView {
    if (self.dataArr.count ==0) {
        NSString * description = @"暂无评论";
        LLNoDataView *dataView = [[LLNoDataView alloc] initImageWithFrame:self.myTableView.bounds image:[UIImage imageNamed:IMAGENOPIC] description:description canTouch:NO];
        self.myTableView.backgroundView = dataView;
    }else
        self.myTableView.backgroundView = nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    EIBMForumDetailHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ForumDetailHeadTableViewCell" forIndexPath:indexPath];
    cell.nameLabel.textColor = RGB(100, 152, 206);
    cell.moreButton.hidden = NO;
    [cell setDataWithSourceData:self.dataArr[indexPath.row]];
    WEAKSELF
    [cell setMoreBlock:^{
        [weakSelf eibm_More:indexPath.row];
    }];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NewsChatModel *model = (NewsChatModel *)[self.dataArr objectAtIndex:indexPath.row];
    return [EIBMForumDetailHeadTableViewCell getCellHeightWithString:model.content];
}

- (void)eibm_More:(NSInteger)index
{
    WEAKSELF
    NewsChatModel *model = self.dataArr[index];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:@"如发现违规言论可如下操作" preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"举报" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf ivst_jubao];
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"屏蔽" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [EIBMNewsChatManager addBlackChatMessageList:model];
        [weakSelf loadData];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)ivst_jubao
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"举报信息" message:@"" preferredStyle: UIAlertControllerStyleActionSheet];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"虚假内容" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [NSObject showHudTipStr:@"感谢您的反馈！"];
    }];
    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"敏感政治" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [NSObject showHudTipStr:@"感谢您的反馈！"];
    }];
    UIAlertAction *artAction = [UIAlertAction actionWithTitle:@"广告信息" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [NSObject showHudTipStr:@"感谢您的反馈！"];
    }];
    UIAlertAction *noAction = [UIAlertAction actionWithTitle:@"其他" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [NSObject showHudTipStr:@"感谢您的反馈！"];
    }];
    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];
    [alertController addAction:artAction];
    [alertController addAction:noAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (NewsChatView *)tool {
    if (!_tool) {
        _tool = [[NewsChatView alloc] init];
        WEAKSELF
        EIBMUser *user = [EIBMUserUtil sharedUserUtil].user;
        [_tool setChatBlock:^(NSString * _Nonnull content) {
            NewsChatModel *model = [[NewsChatModel alloc] init];
            model.userName = user.userName;
            model.content = content;
            model.newsId = weakSelf.newsId;
            model.created = [NSNumber numberWithLong:[[NSDate date] utcTimeStamp]];
            model.userImageUrl = @"";
            [[EIBMNewsChatManager shared] insertWithNewsChatListObjects:model];
            [weakSelf loadData];
        }];
    }
    return _tool;
}

@end
