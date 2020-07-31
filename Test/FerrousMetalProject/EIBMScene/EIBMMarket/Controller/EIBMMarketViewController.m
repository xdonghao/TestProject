//
//  MarketViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 31/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMMarketViewController.h"
#import "EIBMMarketListViewController.h"
#import "EIBMMarketAddViewController.h"
#import "EIBMMarketSearchViewController.h"
@interface EIBMMarketViewController ()<WMPageControllerDataSource,WMPageControllerDelegate>

@property (nonatomic, strong)EIBMMarketListViewController *listSelf;
@property (nonatomic, strong)EIBMMarketListViewController *listOne;
@property (nonatomic, strong)EIBMMarketListViewController *listTwo;
@property (nonatomic, strong)EIBMMarketListViewController *listThree;
@property (nonatomic, strong)EIBMMarketListViewController *listFour;

@end

@implementation EIBMMarketViewController

- (void)viewDidLoad {
    [self setUp];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"行情"];
    [self setRightButtonStyle:AAButtonStyleSearch];
}

- (void)setUp{
    self.showOnNavigationBar = NO;
    self.menuViewStyle = WMMenuViewStyleLine;
    self.menuItemWidth = 60;
    self.progressColor = MainColor;
    self.progressHeight = 2;
    self.titleSizeSelected = 14;
    self.titleColorSelected = MainColor;
    self.titleSizeNormal = 12;
}

- (void)rightButtonClick {
    [self.navigationController pushViewController:[EIBMMarketSearchViewController new] animated:YES];
//    if (![SYZUserUtil sharedUserUtil].user) {
//        SYZLoginDetailController *login = [SYZLoginDetailController new];
//        AABaseNavigationViewController *loginNav =[[AABaseNavigationViewController alloc]initWithRootViewController:login];
//        [login setSuccessBlock:^{
//
//        }];
//        [self presentViewController:loginNav animated:YES completion:^{
//
//        }];
//        return;
//    }
//    [self.navigationController pushViewController:[SYZMarketAddViewController new] animated:YES];
}

- (instancetype)initEIBMMarketCenter{
    self = [super initWithViewControllerClasses:@[[EIBMMarketListViewController class],[EIBMMarketListViewController class],[EIBMMarketListViewController class], [EIBMMarketListViewController class]] andTheirTitles:@[@"贵金属",@"能源",@"股指",@"农产品"]];
    return self;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, SafeAreaTopHeight + 44, SCREEN_WIDTH, self.view.frame.size.height - 44 - SafeAreaTopHeight);
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            return self.listThree;
            
        }
            break;
        case 1:
        {
            return self.listOne;
        }
            break;
        case 2:
        {
            return self.listTwo;
        }
            break;
        case 3:
        {
            return self.listFour;
        }
            break;
        default:{
            return self.listSelf;
        }
            break;
    }
}

- (EIBMMarketListViewController *)listSelf {
    if (!_listSelf) {
        _listSelf = [[EIBMMarketListViewController alloc] init];
        _listSelf.type = MarketListSelf;
        _listSelf.prod_code = @"";
    }
    return _listSelf;
}


/**
 能源期货
 */
- (EIBMMarketListViewController *)listOne {
    if (!_listOne) {
        _listOne = [[EIBMMarketListViewController alloc] init];
        _listOne.prod_code = @"UKOIL.OTC,USCL.OTC,USNG.OTC";
        _listOne.type = MarketListNengYuan;
    }
    return _listOne;
}

/**
 股指期货
 */
- (EIBMMarketListViewController *)listTwo {
    if (!_listTwo) {
        _listTwo = [[EIBMMarketListViewController alloc] init];
        _listTwo.prod_code = @"CNA50F.OTC,HK40F.OTC,US30F.OTC,US500F.OTC,USTEC100F.OTC,DE30F.OTC,AU200F.OTC,JP225F.OTC,STOXX50F.OTC,ES35F.OTC,UK100F.OTC,FR40F.OTC";
        _listTwo.type = MarketListGuZhi;
    }
    return _listTwo;
}
/**
 金属期货
 */
- (EIBMMarketListViewController *)listThree {
    if (!_listThree) {
        _listThree = [[EIBMMarketListViewController alloc] init];
        _listThree.prod_code = @"XAUUSD.OTC,XAGUSD.OTC,USGC.OTC,USSI.OTC,USPL.OTC,USPA.OTC,USHG.OTC,AUTD.SGE,AGTD.SGE,AU100G.SGE,AU9995.SGE,AU9999.SGE,mAUTD.SGE,PT9995.SGE,UKCA.OTC,UKAH.OTC,UKNI.OTC,UKPB.OTC,UKSN.OTC,UKZS.OTC";
        _listThree.type = MarketListJinShu;
    }
    return _listThree;
}
/**
 农产品期货
 */
- (EIBMMarketListViewController *)listFour {
    if (!_listFour) {
        _listFour = [[EIBMMarketListViewController alloc] init];
        _listFour.prod_code = @"USYO.OTC,USZC.OTC,USZS.OTC,USZW.OTC";
        _listFour.type = MarketListNongChanPin;
    }
    return _listFour;
}

@end
