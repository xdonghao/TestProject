//
//  MarketListViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 01/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMMarketListViewController.h"
#import "EIBMMarketListTableViewCell.h"
#import "EIBMMarketListHeaderView.h"
#import "EIBMMarketDetailViewController.h"
#import "EIBMMarketListListCollectionViewCell.h"
@interface EIBMMarketListViewController ()

@end

@implementation EIBMMarketListViewController
- (BOOL)isLoadNavigationBar {
    return NO;
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (self.type == MarketListSelf) {
        [self loadData];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"MarketListListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MarketListListCollectionViewCell"];
    WEAKSELF
    self.myCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.myCollectionView.mj_footer resetNoMoreData];
        [weakSelf loadData];
    }];
    [self.myCollectionView.mj_header beginRefreshing];
    [self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
}

- (void)loadData {
    if (self.type == MarketListSelf) {
        self.prod_code = @"";
        NSString *collect = [EIBMUserUtil sharedUserUtil].user.collectStrings;
        if (collect.length >0) {
            self.prod_code = collect;
        }
    }
    if (self.type == MarketListSelf) {
        NSString *fieldStr = @"prod_code,prod_name,last_px,px_change,px_change_rate";
        NSDictionary* dic = @{@"prod_code":self.prod_code,
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
                [weakSelf.myCollectionView reloadData];
                
            }
        }];
    } else {
        NSString *api = @"";
        if (self.type == MarketListNengYuan) {
            api = @"nengyuanList";
        } else if (self.type == MarketListGuZhi) {
            api = @"guzhiList";
        } else if (self.type == MarketListJinShu) {
            api = @"jinshuList";
        } else if (self.type == MarketListNongChanPin) {
            api = @"mynongchanpinList";
        }
        //                   编号          名称     最新价     涨跌额          涨跌幅
        NSString *fieldStr = @"prod_code,prod_name,last_px,px_change,px_change_rate";
        NSDictionary* dic = @{@"prod_code":self.prod_code,
                              @"fields":fieldStr,
                              @"token":@"3f39051e89e1cea0a84da126601763d8",
                              @"api" : api,
                              @"project":Project
                              };
        
        WEAKSELF
        [[EIBMNetworkTool sharedNetworkTool] toolRequestWithHTTPMethod:HTTPRequestMethodGet URLString:NETWORK_QiHuo parameters:dic complete:^(id  _Nonnull responseObject, EIBMError * _Nonnull error) {
            [weakSelf headerEndRefresh];
            if (!error) {
                NSDictionary *dict = (NSDictionary *)responseObject;
                NSDictionary *data = dict[@"data"][@"snapshot"];
                [weakSelf.dataArr removeAllObjects];
                [weakSelf.dataArr addObjectsFromArray:data.allValues];
                [weakSelf eibm_AddNoDataView];
                [weakSelf.myCollectionView reloadData];
                
            } else {
                [NSObject showHudTipStr:@"网络异常，请稍后再试"];
            }
        }];
    }
    
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EIBMMarketListListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MarketListListCollectionViewCell" forIndexPath:indexPath];
    [cell setDataWithSourceData:[self.dataArr objectAtIndex:indexPath.row]];
    cell.bottomLine.hidden = NO;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *arr = [self.dataArr objectAtIndex:indexPath.row];
    EIBMMarketDetailViewController *detail = [[EIBMMarketDetailViewController alloc] init];
    detail.codeString = arr[0];
    detail.nameString = arr[1];
    [self.navigationController pushViewController:detail animated:YES];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath

{
    CGFloat w = ((SCREEN_WIDTH)/3) - 0.01;
    return CGSizeMake(w, [EIBMMarketListListCollectionViewCell getCellHeightWithString:nil]);
}

//定义每个UICollectionView 的间距

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0,0);

}

//横间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{

    return 0.01;

}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0.01;
}

- (void)eibm_AddNoDataView{
    if (self.dataArr.count ==0) {
        NSString * description = @"暂无数据";
        if (self.type == MarketListSelf) {
            description = @"您还没有添加自选期货";
        }
        LLNoDataView *dataView = [[LLNoDataView alloc] initImageWithFrame:self.myCollectionView.bounds image:[UIImage imageNamed:IMAGENOPIC] description:description canTouch:NO];
        self.myCollectionView.backgroundView = dataView;
    }else
        self.myCollectionView.backgroundView = nil;
}

@end
