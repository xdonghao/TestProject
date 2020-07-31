//
//  MyCollectCenterViewController.m
//  EIBMBestMetal
//
//  Created by MAC on 20/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMMyCollectCenterViewController.h"
#import "EIBMMyCollectViewController.h"
#import "EIBMMyCollectNewsViewController.h"
@interface EIBMMyCollectCenterViewController ()

@property (nonatomic, strong)EIBMMyCollectViewController *wenda;
@property (nonatomic, strong)EIBMMyCollectNewsViewController *news;

@end

@implementation EIBMMyCollectCenterViewController

- (void)viewDidLoad {
    [self setUp];
    [super viewDidLoad];
    [self setNavigationBarTitle:@"我的收藏"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    // Do any additional setup after loading the view.
}

- (instancetype)initPersonCenter {
    self = [super initWithViewControllerClasses:@[[EIBMMyCollectViewController class],[EIBMMyCollectNewsViewController class]] andTheirTitles:@[@"圈子",@"资讯"]];
    return self;
}

- (void)setUp{
    self.showOnNavigationBar = NO;
    self.menuViewStyle = WMMenuViewStyleLine;
    self.menuItemWidth = 60;
    self.progressColor = MainColor;
    self.progressHeight = 3;
    self.titleSizeSelected = 14;
    self.titleColorSelected = MainColor;
    self.titleSizeNormal = 14;
}

- (EIBMMyCollectViewController *)wenda {
    if (!_wenda) {
        _wenda = [[EIBMMyCollectViewController alloc] init];
    }
    return _wenda;
}

- (EIBMMyCollectNewsViewController *)news {
    if (!_news) {
        _news = [[EIBMMyCollectNewsViewController alloc] init];
    }
    return _news;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, SafeAreaTopHeight + 44, SCREEN_WIDTH, self.view.frame.size.height - 44 - SafeAreaTopHeight);
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    if (index == 0) {
        return self.wenda;
    } else {
        return self.news;
    }
}
@end
