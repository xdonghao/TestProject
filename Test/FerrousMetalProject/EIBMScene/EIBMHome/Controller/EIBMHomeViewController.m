//
//  HomeViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 30/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMHomeViewController.h"
#import "EIBMAdScrollCollectionViewCell.h"
#import "EIBMMarketListListCollectionViewCell.h"
#import "EIBMHeaderLineCollectionReusableView.h"
#import "EIBMMarketDetailViewController.h"
#import "EIBMNewsPageViewController.h"
#import "EIBMForumNewListCollectionViewCell.h"
#import "EIBMForumListModel.h"
#import "EIBMForumManager.h"
#import "EIBMForumDetailViewController.h"
#import "EIBMMarketSearchViewController.h"
#import "EIBMNewsViewController.h"
#import "EIBMNewsOtherModel.h"
#import "EIBMHomeHotNewsCollectionViewCell.h"
#import "EIBMNewsDetailViewController.h"
#import "EIBMPersonCenterViewController.h"
#import "EIBMBaikeViewController.h"
#import "EIBMButtonCollectionViewCell.h"
#import "EIBMBaikeDetailViewController.h"
#import "EIBMBaikeModel.h"
#import "EIBMHomeClassroomCollectionViewCell.h"
#import "EIBMTalkListViewController.h"
#import "EIBMHomeTalkListCollectionViewCell.h"
#import "HomeNoticeCollectionViewCell.h"
#import "EIBMNewsFlashViewController.h"
#import "EIBMStoreMenuCollectionViewCell.h"
#import "EIBMNewsCalendarViewController.h"
#import "EIBMBaikeViewController.h"
#import "EIBMMarketMyViewController.h"
#import "EIBMRateToolVC.h"
#import "EIBMClassroomViewController.h"

@interface EIBMHomeViewController ()
@property (nonatomic, strong) EIBMNewsPageViewController *newsPage;
@property (nonatomic, strong) NSMutableArray *forumList;
@property (nonatomic, strong) NSMutableArray *hotNewsList;
@end

@implementation EIBMHomeViewController

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    [self setNavigationBarTitle:@"首页"];
    [self setNavigationBarBackgroundColor:[UIColor clearColor]];
    self.navigationBarView.titleLabel.backgroundColor = [UIColor clearColor];
    self.navigationBarView.titleLabel.textColor = [UIColor whiteColor];
    self.myCollectionView.backgroundColor = kWhiteColor;
    [self.myCollectionView registerClass:[EIBMHomeHotNewsCollectionViewCell class] forCellWithReuseIdentifier:@"HomeHotNewsCollectionViewCell"];
    [self.myCollectionView registerClass:[EIBMForumNewListCollectionViewCell class] forCellWithReuseIdentifier:@"ForumNewListCollectionViewCell"];
    [self.myCollectionView registerClass:[EIBMAdScrollCollectionViewCell class] forCellWithReuseIdentifier:@"AdScrollCollectionViewCell"];
    
    [self.myCollectionView registerClass:[EIBMHomeTalkListCollectionViewCell class] forCellWithReuseIdentifier:@"HomeTalkListCollectionViewCell"];
    
    
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"MarketListListCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MarketListListCollectionViewCell"];
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"HomeNoticeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomeNoticeCollectionViewCell"];
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"HomeClassroomCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"HomeClassroomCollectionViewCell"];
    
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"StoreMenuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"StoreMenuCollectionViewCell"];
    
    [self.myCollectionView registerClass:[EIBMHeaderLineCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderLineCollectionReusableView"];
    
    [self.myCollectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
    
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"ButtonCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"ButtonCollectionViewCell"];
    WEAKSELF
    self.myCollectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf.myCollectionView.mj_footer resetNoMoreData];
        [weakSelf loadData];
    }];
    [self.myCollectionView.mj_header beginRefreshing];
    CGFloat y = IS_IPHONE_X ? 44 : 20;
    [self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top).offset(-y);
        make.left.right.equalTo(self.contentView);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 7;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (section == 0) {
        return 1;
    } else if(section == 1) {
           return 1;
    }  else if(section == 2) {
        return self.dataArr.count > 6 ? 6 : self.dataArr.count;
    } else if(section == 3) {
        return 4;
    }else if(section == 4) {
        return 2;
    }else if(section == 5) {
        return self.hotNewsList.count;
        
    } else {
        return self.forumList.count > 6 ? 6 : self.forumList.count;
    }
}

//设置每个 UICollectionView 的大小

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath

{
    if (indexPath.section == 0) {
        return CGSizeMake(SCREEN_WIDTH, [EIBMAdScrollCollectionViewCell getCellHeightWithString:nil]);
    } else if (indexPath.section == 1) {
           return CGSizeMake(SCREEN_WIDTH, 40);
    }  else if (indexPath.section == 2) {
        CGFloat w = ((SCREEN_WIDTH)/3) - 0.01;
        return CGSizeMake(w, [EIBMMarketListListCollectionViewCell getCellHeightWithString:nil]);
    } else if (indexPath.section == 3) {
        CGFloat collectionCellWidth = (SCREEN_WIDTH)/4-0.01;
        CGFloat collectionCellHeight = 92;
        return CGSizeMake(collectionCellWidth, collectionCellHeight);
//        return CGSizeMake(SCREEN_WIDTH, 170);
    } else if (indexPath.section == 4) {
              return CGSizeMake((SCREEN_WIDTH-30)/2-0.01, 90);
    }  else if (indexPath.section == 5) {
        EIBMNewsModel *model = (EIBMNewsModel *)[self.hotNewsList objectAtIndex:indexPath.row];
        return CGSizeMake(SCREEN_WIDTH, [EIBMHomeHotNewsCollectionViewCell getCellHeightWithString:model.title]);
//        EIBMForumListModel *model = [self.forumList objectAtIndex:indexPath.row];
//        return CGSizeMake(SCREEN_WIDTH, [EIBMForumNewListCollectionViewCell getCellHeightWithString:model.content]);
    } else if (indexPath.section == 6) {
        return CGSizeMake(SCREEN_WIDTH, 50);
    }
    return CGSizeMake(SCREEN_WIDTH, 0);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        EIBMAdScrollCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"AdScrollCollectionViewCell" forIndexPath:indexPath];
        cell.vc = self;
        [cell setDataWithSourceData:nil];
        return cell;
    } else if (indexPath.section == 1) {
        HomeNoticeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeNoticeCollectionViewCell" forIndexPath:indexPath];
        return cell;
    } else if (indexPath.section == 2) {
        EIBMMarketListListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MarketListListCollectionViewCell" forIndexPath:indexPath];
        if (self.dataArr.count > indexPath.row) {
            [cell setDataWithSourceData:[self.dataArr objectAtIndex:indexPath.row]];
        }
        cell.bottomLine.hidden = NO;
        if (indexPath.row == 2 || indexPath.row == 5) {
            cell.line.hidden= YES;
        }else {
            cell.line.hidden= NO;
        }
        return cell;
    } else if (indexPath.section == 3) {

        EIBMStoreMenuCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"StoreMenuCollectionViewCell" forIndexPath:indexPath];
        if (indexPath.row == 0) {
            cell.menuLabel.text = @"期货学堂";
        } else if (indexPath.row == 1) {
            cell.menuLabel.text = @"期货换算";
        } else if (indexPath.row == 2) {
            cell.menuLabel.text = @"专家课堂";
        } else if (indexPath.row == 3) {
            cell.menuLabel.text = @"我的自选";
        } 
//        if (indexPath.row == 0) {
//            cell.menuLabel.text = @"要闻";
//        } else if (indexPath.row == 1) {
//            cell.menuLabel.text = @"热门快讯";
//        } else if (indexPath.row == 2) {
//            cell.menuLabel.text = @"财经日历";
//        } else if (indexPath.row == 3) {
//            cell.menuLabel.text = @"名师指导";
//        } else if (indexPath.row == 4) {
//            cell.menuLabel.text = @"利率表";
//        } else if (indexPath.row == 5) {
//            cell.menuLabel.text = @"指数表";
//        } else if (indexPath.row == 6) {
//            cell.menuLabel.text = @"工具";
//        } else if (indexPath.row == 7) {
//            cell.menuLabel.text = @"在线客服";
//        }
        [cell.menuImageView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"home_item_%ld",(long)indexPath.row]]];
        return cell;
        
    }  else if (indexPath.section == 4) {
          EIBMHomeClassroomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeClassroomCollectionViewCell" forIndexPath:indexPath];
          return cell;
    }   else if (indexPath.section == 5) {
        EIBMHomeHotNewsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"HomeHotNewsCollectionViewCell" forIndexPath:indexPath];
        [cell setDataWithSourceData:[self.hotNewsList objectAtIndex:indexPath.row]];
        cell.bottomLine.hidden = NO;
        return cell;
    } else if(indexPath.section == 6) {
//        EIBMForumNewListCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ForumNewListCollectionViewCell" forIndexPath:indexPath];
//        EIBMForumListModel *model = [self.forumList objectAtIndex:indexPath.row];
//        [cell setDataWithSourceData:model];
        
        EIBMButtonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ButtonCollectionViewCell" forIndexPath:indexPath];
        EIBMBaikeModel *model = [self.forumList objectAtIndex:indexPath.row];
        cell.titleLabel.text = [NSString stringWithFormat:@"    %@",model.title];
        cell.titleLabel.textAlignment = NSTextAlignmentLeft;
        cell.titleLabel.font = [UIFont systemFontOfSize:14];
        cell.bottomLine.hidden = NO;
        return cell;
    }else {
        return nil;
    }
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        EIBMNewsFlashViewController *new = [[EIBMNewsFlashViewController alloc] init];
        new.listDataJsonPath = [[NSBundle mainBundle] pathForResource:@"dashijian_k_data" ofType:@"json"];
        new.show = YES;
        new.title = @"公告";
        self.navigationController.delegate = new;
        [self.navigationController pushViewController:new animated:YES];
    } else if (indexPath.section == 2) {
        if (self.dataArr.count > indexPath.row) {
            NSArray *arr = [self.dataArr objectAtIndex:indexPath.row];
            EIBMMarketDetailViewController *detail = [[EIBMMarketDetailViewController alloc] init];
            detail.codeString = arr[0];
            detail.nameString = arr[1];
            [self.navigationController pushViewController:detail animated:YES];
        }
    } else if (indexPath.section == 3) {
        
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[EIBMBaikeViewController new] animated:YES];
        }else if (indexPath.row == 1) {
            [self.navigationController pushViewController:[EIBMRateToolVC new] animated:YES];
        }else if (indexPath.row == 2) {
            EIBMClassroomViewController *room = [EIBMClassroomViewController new];
            [self.navigationController pushViewController:room animated:YES];
            
        }else if (indexPath.row == 3) {
            
            [self.navigationController pushViewController:[EIBMMarketMyViewController new] animated:YES];
        }
//        [self.navigationController pushViewController:[EIBMTalkListViewController new] animated:YES];
    }  else if (indexPath.section == 4) {
        if (indexPath.row == 0) {
            [self.navigationController pushViewController:[EIBMTalkListViewController new] animated:YES];
        } else {
            [self.navigationController pushViewController:[EIBMNewsCalendarViewController new] animated:YES];
        }
    }   else if (indexPath.section == 5) {
        EIBMNewsDetailViewController *web = [[EIBMNewsDetailViewController alloc] init];
        EIBMNewsModel *model = (EIBMNewsModel *)[self.hotNewsList objectAtIndex:indexPath.row];
        web.hotModel = model;
        [self.navigationController pushViewController:web animated:YES];
    } else if (indexPath.section == 6) {
//        EIBMForumDetailViewController *detail = [[EIBMForumDetailViewController alloc] init];
//        EIBMForumListModel *model = (EIBMForumListModel *)[self.forumList objectAtIndex:indexPath.row];
//        detail.model = model;
//        WEAKSELF
//        [detail setDelSuccess:^{
//            [weakSelf eibm_LoadForumListData];
//        }];
//        [self.navigationController pushViewController:detail animated:YES];
        
        EIBMBaikeDetailViewController *de = [EIBMBaikeDetailViewController new];
        EIBMBaikeModel *model = [self.forumList objectAtIndex:indexPath.row];
        de.title = model.title;
        de.content = model.content;
        [self.navigationController pushViewController:de animated:YES];
    }
}

//这个方法是返回 Header的大小 size
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section == 5 ||section == 6) {
        return CGSizeMake(SCREEN_WIDTH, 40);
    }
    return CGSizeMake(SCREEN_WIDTH, 0.01);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    if (section == 0 ||section == 1 ||section == 2 ||section == 3||section == 4||section == 5) {
        return CGSizeMake(SCREEN_WIDTH, 8);
    }
    return CGSizeMake(SCREEN_WIDTH, 0.01);
}

//这个也是最重要的方法 获取Header的 方法。
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
        WEAKSELF
        EIBMHeaderLineCollectionReusableView *cell = (EIBMHeaderLineCollectionReusableView *)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderLineCollectionReusableView" forIndexPath:indexPath];
        cell.bottomLine.hidden = YES;
        cell.leftLabel.hidden = YES;
        cell.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        if(indexPath.section == 5){
            cell.titleLabel.text = @"市场快讯";
            cell.leftLabel.hidden = NO;
            cell.moreLabel.hidden = YES;
            cell.arrowImageView.hidden = YES;
        }else if(indexPath.section == 6){
            cell.titleLabel.text = @"百科小贴士";
            cell.leftLabel.hidden = NO;
            cell.moreLabel.hidden = NO;
            cell.arrowImageView.hidden = NO;
        }else{
            cell.moreLabel.hidden = YES;
             cell.arrowImageView.hidden = YES;
            cell.titleLabel.text = @"";
        }
        [cell setMoreBlock:^{
            if (indexPath.section == 6) {
//                weakSelf.tabBarController.selectedIndex = 1;
                [weakSelf.navigationController pushViewController:[EIBMBaikeViewController new] animated:YES];
            }
        }];
        return cell;
    }else{
        UICollectionReusableView *footerView =  [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        
        footerView.backgroundColor = LLBackGroundWhiteColor;
        return footerView;
    }
}
//横间距
-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 4) {
        return 10;
    } else {
        return 0.01;
    }
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    if (section == 1) {
        return 0.01;
    } else {
        return 0.01;
    }
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section == 4 ) {
        return UIEdgeInsetsMake(0, 10, 0,10);
    } else {
        return UIEdgeInsetsMake(0, 0, 0,0);
    }
    
}

- (void)loadData {
//    NSString *prod_code = @"USCL.OTC,P225F.OTC,AGTD.SGE,UKCA.OTC,USSI.OTC,USYO.OTC,UKNI.OTC,UKSN.OTC,UK100F.OTC";
    NSString *prod_code = @"ES35F.OTC,USSI.OTC,USPL.OTC,UK100F.OTC,FR40F.OTC,USZC.OTC";
    //                   编号          名称     最新价     涨跌额          涨跌幅
    NSString *fieldStr = @"prod_code,prod_name,last_px,px_change,px_change_rate";
    NSDictionary* dic = @{@"prod_code":prod_code,
                          @"fields":fieldStr,
                          @"token":@"3f39051e89e1cea0a84da126601763d8",
                          @"api" : @"homeTuijian",
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
            [weakSelf eibm_LoadForumListData];
            [weakSelf loadHotNews];
        } else {
            [NSObject showHudTipStr:@"网络异常，请稍后再试"];
        }
    }];
}

- (void)eibm_LoadForumListData {
    /*
    [self.forumList removeAllObjects];
    [self.forumList addObjectsFromArray:[[EIBMForumManager shared] getForumList]];
    
    //屏蔽列表
    NSArray *shieldArr = [EIBMForumManager getShieldForumList];
    NSMutableArray *muArr = [NSMutableArray array];
    for (EIBMForumListModel *model in self.forumList) {
        if ([shieldArr containsObject:model]) {
            [muArr addObject:model];
        }
    }
    [self.forumList removeObjectsInArray:muArr];
    
    if (self.forumList.count>1) {
        for (int i = 0; i < self.forumList.count - 1; i++) {
            //比较的躺数
            for (int j = 0; j < self.forumList.count - 1 - i; j++) {
                //比较的次数
                EIBMForumListModel *model = (EIBMForumListModel *)[self.forumList objectAtIndex:j];
                EIBMForumListModel *model2 = (EIBMForumListModel *)[self.forumList objectAtIndex:j+1];
                if ([model.created intValue] < [model2.created intValue]) {
                    //这里为升序排序
                    [self.forumList exchangeObjectAtIndex:j withObjectAtIndex:j+1];
                }
            }
        }
    }
    [self.myCollectionView reloadData];
    */
    
    [self.forumList removeAllObjects];
    NSString *path2 = [[NSBundle mainBundle] pathForResource:@"baike_k_data" ofType:@"json"];
    NSData *dataStock2 = [NSData dataWithContentsOfFile:path2];
    NSArray *stockJson2 = [NSJSONSerialization JSONObjectWithData:dataStock2 options:0 error:nil];
    
    for (NSDictionary *modelDic in stockJson2) {
        EIBMBaikeModel *model = [EIBMBaikeModel mj_objectWithKeyValues:modelDic];
        [self.forumList addObject:model];
    }
    [self.myCollectionView reloadData];
}

+ (NSData *)dataWithBase64String:(NSString *)base64String {
    const char *string = [base64String cStringUsingEncoding:NSASCIIStringEncoding];
    NSInteger inputLength = base64String.length;
    
    if (string == NULL/* || inputLength % 4 != 0*/) {
        return nil;
    }
    
    while (inputLength > 0 && string[inputLength - 1] == '=') {
        inputLength--;
    }
    
    NSInteger outputLength = inputLength * 3 / 4;
    NSMutableData* data = [NSMutableData dataWithLength:outputLength];
    
    return data;
}

- (void)loadHotNews {
    NSString *url = @"http://m.vamarket.net//user/news/findNewsList.do";
    NSDictionary *dic = @{@"offset":@"0",
                          @"size":@"12",
                          @"type":@"4"
                          };
    WEAKSELF
    [[EIBMNetworkTool sharedNetworkTool] toolRequestWithHTTPMethod:HTTPRequestMethodGet URLString:url parameters:dic complete:^(id  _Nonnull responseObject, EIBMError * _Nonnull error) {
        [weakSelf headerEndRefresh];
        if (!error) {
            NSDictionary *data = (NSDictionary *)responseObject;
            NSArray *dataArr = data[@"data"][@"data"];
            NSMutableArray *array = [NSMutableArray array];
            for (NSInteger i = 0; i<dataArr.count; i++) {
                NSDictionary *modelDic = dataArr[i];
                EIBMNewsModel *model = [EIBMNewsModel mj_objectWithKeyValues:modelDic];
                if (i%2 ==1) {
                    [array addObject:model];
                }
            }
            [weakSelf.hotNewsList removeAllObjects];
            [weakSelf.hotNewsList addObjectsFromArray:array];
            [weakSelf.myCollectionView reloadData];
        } else {
            
        }
    }];
}

- (EIBMNewsPageViewController *)newsPage {
    if (!_newsPage) {
        _newsPage = [[EIBMNewsPageViewController alloc] initEIBMNewsListCenter];
    }
    return _newsPage;
}

- (NSMutableArray *)forumList {
    if (!_forumList) {
        _forumList = [NSMutableArray array];
    }
    return _forumList;
}

- (NSMutableArray *)hotNewsList {
    if (!_hotNewsList) {
        _hotNewsList = [NSMutableArray array];
    }
    return _hotNewsList;
}



@end
