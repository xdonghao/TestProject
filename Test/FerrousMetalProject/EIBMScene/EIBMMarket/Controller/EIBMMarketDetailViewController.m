//
//  MarketDetailViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 01/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMMarketDetailViewController.h"
#import "EIBMMarketMessageTableViewCell.h"
#import "EIBMMarketKLineTableViewCell.h"
#import "EIBMMarketKLineHeaderView.h"
#import "EIBMNewsTableViewCell.h"
#import "EIBMNewsOtherModel.h"
#import "EIBMNewsDetailViewController.h"
#import "EIBMTitleHeaderFooterView.h"
@interface EIBMMarketDetailViewController ()<MarketKLineDelegate>

@property (nonatomic, strong)NSMutableArray *kLineArray;

@property (strong, nonatomic) SimpleKLineVolView *simpleKLineView;
/**
 分时切换按钮
 */
@property (strong, nonatomic) UIButton *timeButton;
/**
 K线切换按钮
 */
@property (strong, nonatomic) UIButton *klineButton;

@property (assign, nonatomic) KStyleType type;

@end

@implementation EIBMMarketDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setLeftButtonStyle:AAButtonStyleBack];
    self.type = KStyleTypeKline;
    [self.contentView addSubview:self.timeButton];
    [self.contentView addSubview:self.klineButton];
    [self.timeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.contentView.mas_right).offset(-20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.height.mas_equalTo(44);
        make.left.equalTo(self.klineButton.mas_right).offset(10);
    }];
    [self.klineButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(20);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
        make.height.mas_equalTo(44);
        make.width.equalTo(self.timeButton.mas_width);
    }];
    NSArray *collectArray = [[EIBMUserUtil sharedUserUtil].user.collectStrings componentsSeparatedByString:@","];
    UIButton *button = self.navigationBarView.rightButton;
    if ([collectArray containsObject:self.codeString]) {
        [button setImage:[UIImage imageNamed:@"eibm_collect_del"] forState:UIControlStateNormal];
    } else {
        [button setImage:[UIImage imageNamed:@"eibm_collect_add"] forState:UIControlStateNormal];
    }
    
    
    NSArray *nameArray = [self.codeString componentsSeparatedByString:@"."];
    [self setNavigationBarTitle:[NSString stringWithFormat:@"%@(%@)",self.nameString,nameArray[0]]];
    [self.myTableView registerNib:[UINib nibWithNibName:@"MarketMessageTableViewCell" bundle:nil] forCellReuseIdentifier:@"MarketMessageTableViewCell"];
    [self.myTableView registerClass:[EIBMMarketKLineTableViewCell class] forCellReuseIdentifier:@"MarketKLineTableViewCell"];
    [self.myTableView registerClass:[EIBMMarketKLineHeaderView class] forHeaderFooterViewReuseIdentifier:@"MarketKLineHeaderView"];
    [self.myTableView registerClass:[EIBMTitleHeaderFooterView class] forHeaderFooterViewReuseIdentifier:@"TitleHeaderFooterView"];
    [self.myTableView registerNib:[UINib nibWithNibName:@"NewsTableViewCell" bundle:nil] forCellReuseIdentifier:@"NewsTableViewCell"];
    [self loadData];
    [self loadKLineDataWithPeriodType:@(60 * 5) tickCount:@(200) timestamp:[[NSDate date] utcTimeStamp]];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.bottom.equalTo(self.klineButton.mas_top).offset(-10);
    }];
}

- (void)rightButtonClick {
    UIButton *button = self.navigationBarView.rightButton;
    if (![EIBMUserUtil sharedUserUtil].user) {
        EIBMLoginDetailController *login = [EIBMLoginDetailController new];
        EIBMBaseNavigationViewController *loginNav =[[EIBMBaseNavigationViewController alloc]initWithRootViewController:login];
        [login setSuccessBlock:^{
            
        }];
        [self presentViewController:loginNav animated:YES completion:^{
            
        }];
        return;
    }
    
    
    EIBMUser *user = [EIBMUserUtil sharedUserUtil].user;
    NSMutableArray *collectArray = [NSMutableArray arrayWithArray:[user.collectStrings componentsSeparatedByString:@","]];
    if ([collectArray containsObject:self.codeString]){
        [collectArray removeObject:self.codeString];
        [button setImage:[UIImage imageNamed:@"eibm_collect_add"] forState:UIControlStateNormal];
        [NSObject showHudTipStr:@"已从自选列表删除"];
    } else {
        [collectArray addObject:self.codeString];
        [button setImage:[UIImage imageNamed:@"eibm_collect_del"] forState:UIControlStateNormal];
        [NSObject showHudTipStr:@"已添加到自选"];
    }
    
    NSMutableString *muStr = [NSMutableString stringWithFormat:@""];
    for (NSInteger i = 0; i< collectArray.count; i++) {
        NSString *codeString = collectArray[i];
        if (![codeString isEqualToString:@","] && codeString.length >0) {
            [muStr appendString:codeString];
            if (i != collectArray.count - 1) {
                [muStr appendString:@","];
            }
        }
    }
    user.collectStrings = muStr;
    [[EIBMUserUtil sharedUserUtil] saveCache:user];
    [user update];
}

- (void)loadData {
    //                   编号          名称     最新价     涨跌额          涨跌幅    开盘价    最高价  昨日收盘价    最低价
    NSString *fieldStr = @"prod_code,prod_name,last_px,px_change,px_change_rate,open_px,high_px,preclose_px,low_px";
    NSDictionary* dic = @{@"prod_code":self.codeString,
                          @"fields":fieldStr,
                          @"token":@"3f39051e89e1cea0a84da126601763d8",
                          @"api" : @"detail",
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
            [weakSelf.myTableView reloadData];
        }
    }];
}

- (void)loadKLineDataWithPeriodType:(NSNumber *)type
                             tickCount:(NSNumber *)count
                          timestamp:(long)time {
    
    //                   数据时间戳  收盘价      成交量          成交额        开盘价    最高价  最低价    涨跌额    涨跌幅
    NSString *fieldStr = @"tick_at,close_px,turnover_volume,turnover_value,open_px,high_px,low_px,px_change,px_change_rate";
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    dic[@"prod_code"] = self.codeString;
    dic[@"token"] = @"3f39051e89e1cea0a84da126601763d8";
    dic[@"period_type"] = type;
    dic[@"tick_count"] = count;
    dic[@"timestamp"] = [NSNumber numberWithLong:time];
    dic[@"fields"] = fieldStr;
    dic[@"api"] = @"kLine";
    dic[@"project"] = Project;
    WEAKSELF
    [NSObject showHUDQueryStr:@""];
    [[EIBMNetworkTool sharedNetworkTool] toolRequestWithHTTPMethod:HTTPRequestMethodGet URLString:NETWORK_KLine parameters:dic complete:^(id  _Nonnull responseObject, EIBMError * _Nonnull error) {
        [NSObject hideHUDQuery];
        if (!error) {
            [weakSelf.kLineArray removeAllObjects];
            NSDictionary *dict = (NSDictionary *)responseObject;
            NSDictionary *data = dict[@"data"][@"candle"][self.codeString];
            NSArray *dataArray = data[@"lines"];
            for (NSInteger i = 0; i<dataArray.count; i++) {
                NSArray *modelArr = dataArray[i];
                KLineModel *lineModel = [KLineModel createWithArray:modelArr];
                lineModel.index = i;
                [weakSelf.kLineArray addObject:lineModel];
            }
            [weakSelf.myTableView reloadData];
        }
    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [EIBMMarketMessageTableViewCell getCellHeightWithString:nil];
    } else if (indexPath.section == 1) {
        return 460;
    } else {
        return 100;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 0.01;
    } else {
        return 40;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        UITableViewHeaderFooterView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"HEADER"];
        return header;
    } else {
        EIBMMarketKLineHeaderView *header =[tableView dequeueReusableHeaderFooterViewWithIdentifier:@"MarketKLineHeaderView"];
        header.delegate = self;
        return header;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        EIBMMarketMessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MarketMessageTableViewCell" forIndexPath:indexPath];
        if (self.dataArr.count > 0) {
            [cell setDataWithSourceData:[self.dataArr objectAtIndex:indexPath.row]];
        }
        cell.bottomLine.hidden = NO;
        return cell;
    } else{
        EIBMMarketKLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MarketKLineTableViewCell" forIndexPath:indexPath];
        [cell setKLineArray:self.kLineArray];
        
        self.simpleKLineView = cell.simpleKLineView;
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (void)kLineViewDidSelesctedIndex:(KLineStyle)style currentIndex:(NSInteger)currentIndex {
    if (style == KLineStyle5Min) {
        [self loadKLineDataWithPeriodType:@(60 *5) tickCount:@(400) timestamp:[[NSDate date] utcTimeStamp]];
    } else if (style == KLineStyle30Min) {
        [self loadKLineDataWithPeriodType:@(60 * 30) tickCount:@(400) timestamp:[[NSDate date] utcTimeStamp]];
    } else if (style == KLineStyle1Hour) {
        [self loadKLineDataWithPeriodType:@(60 * 60) tickCount:@(400) timestamp:[[NSDate date] utcTimeStamp]];
    } else if (style == KLineStyle2Hour) {
        [self loadKLineDataWithPeriodType:@(60 * 60 * 2) tickCount:@(400) timestamp:[[NSDate date] utcTimeStamp]];
    } else if (style == KLineStyleDay) {
        [self loadKLineDataWithPeriodType:@(86400) tickCount:@(400) timestamp:[[NSDate date] utcTimeStamp]];
    }
}

-(NSMutableArray *)kLineArray {
    if (!_kLineArray) {
        _kLineArray = [NSMutableArray array];
    }
    return _kLineArray;
}

- (UIButton *)timeButton {
    if (!_timeButton) {
        _timeButton = [EIBMFactoryTool buttonWithType:UIButtonTypeCustom Target:self action:@selector(timeAction) forControlEvents:UIControlEventTouchUpInside font:UIFontSize(17) textColor:[UIColor whiteColor]];
        [_timeButton setTitle:@"分时图" forState:UIControlStateNormal];
        [_timeButton setBackgroundColor:[UIColor lightGrayColor]];
        _timeButton.layer.cornerRadius = 22;
        _timeButton.layer.masksToBounds = YES;
    }
    return _timeButton;
}

- (void)timeAction {
    [self.klineButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.timeButton setBackgroundColor:MainColor];
    [self.simpleKLineView switchKLineMainViewToType:KLineMainViewTypeTimeLine];
}

- (UIButton *)klineButton {
    if (!_klineButton) {
        _klineButton = [EIBMFactoryTool buttonWithType:UIButtonTypeCustom Target:self action:@selector(klineAction) forControlEvents:UIControlEventTouchUpInside font:UIFontSize(17) textColor:[UIColor whiteColor]];
        [_klineButton setTitle:@"K线图" forState:UIControlStateNormal];
        _klineButton.layer.cornerRadius = 22;
        _klineButton.layer.masksToBounds = YES;
        [_klineButton setBackgroundColor:MainColor];
    }
    return _klineButton;
}

- (void)klineAction {
    [self.klineButton setBackgroundColor:MainColor];
    [self.timeButton setBackgroundColor:[UIColor lightGrayColor]];
    [self.simpleKLineView switchKLineMainViewToType:KLineMainViewTypeKLine];
}

@end
