//
//  MarketMyViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 14/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMMarketMyViewController.h"
#import "EIBMMarketListTableViewCell.h"
#import "EIBMMarketListHeaderView.h"
#import "EIBMMarketDetailViewController.h"
#import "EIBMMarketListListCollectionViewCell.h"
#import "EIBMMarketAddViewController.h"
@interface EIBMMarketMyViewController ()

@end

@implementation EIBMMarketMyViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"自选"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    [self setRightButtonStyle:AAButtonStyleAdd];
    [self.myTableView registerNib:[UINib nibWithNibName:@"MarketListTableViewCell" bundle:nil] forCellReuseIdentifier:@"MarketListTableViewCell"];
    [self.myTableView registerClass:[EIBMMarketListHeaderView class] forHeaderFooterViewReuseIdentifier:@"MarketListHeaderView"];
    WEAKSELF
    self.myTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.myTableView.mj_footer resetNoMoreData];
        [weakSelf loadData];
    }];
    [self.myTableView.mj_header beginRefreshing];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.contentView);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
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
    [self.navigationController pushViewController:[EIBMMarketAddViewController new] animated:YES];
}

- (void)loadData {
    NSString * prod_code = @"";
    NSString *collect = [EIBMUserUtil sharedUserUtil].user.collectStrings;
    if (collect.length >0) {
        prod_code = collect;
    }
    NSString *fieldStr = @"prod_code,prod_name,last_px,px_change,px_change_rate";
    NSDictionary* dic = @{@"prod_code":prod_code,
                          @"fields":fieldStr,
                          @"token":@"3f39051e89e1cea0a84da126601763d8",
                          };
    
    WEAKSELF
    [[EIBMNetworkTool sharedNetworkTool] toolRequestWithHTTPMethod:HTTPRequestMethodGet URLString:@"http://data.api51.cn/apis/integration/real/" parameters:dic complete:^(id  _Nonnull responseObject, EIBMError * _Nonnull error) {
        [weakSelf headerEndRefresh];
        if (!error) {
            NSDictionary *dict = (NSDictionary *)responseObject;
            NSDictionary *data = dict[@"data"][@"snapshot"];
            [weakSelf.dataArr removeAllObjects];
            [weakSelf.dataArr addObjectsFromArray:data.allValues];
            [weakSelf eibm_AddNoDataView];
            [weakSelf.myTableView reloadData];
            
        } else {
            [NSObject showHudTipStr:@"网络异常，请稍后再试"];
        }
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [EIBMMarketListTableViewCell getCellHeightWithString:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EIBMMarketListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MarketListTableViewCell" forIndexPath:indexPath];
    [cell setDataWithSourceData:[self.dataArr objectAtIndex:indexPath.section]];
    cell.bottomLine.hidden = YES;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arr = [self.dataArr objectAtIndex:indexPath.section];
    EIBMMarketDetailViewController *detail = [[EIBMMarketDetailViewController alloc] init];
    detail.codeString = arr[0];
    detail.nameString = arr[1];
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 35;
    } else
        return 0.01;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        EIBMMarketListHeaderView *header =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MarketListHeaderView"];
        return header;
    } else {
        UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HEADER"];
        header.contentView.backgroundColor = LLBackGroundWhiteColor;
        return header;
    }
}

- (void)eibm_AddNoDataView{
    if (self.dataArr.count ==0) {
        NSString * description = @"您还没有添加自选期货";
        LLNoDataView *dataView = [[LLNoDataView alloc] initImageWithFrame:self.myTableView.bounds image:[UIImage imageNamed:IMAGENOPIC] description:description canTouch:NO];
        self.myTableView.backgroundView = dataView;
    }else
        self.myTableView.backgroundView = nil;
}

@end
