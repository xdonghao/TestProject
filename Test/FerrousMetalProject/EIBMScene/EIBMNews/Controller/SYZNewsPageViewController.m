//
//  NewsPageViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 04/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "VISTNewsPageViewController.h"
#import "SYZNewsViewController.h"
#import "SYZNewsFlashViewController.h"
#import "SYZNewsFarstViewController.h"
#import "NewsCalendarViewController.h"
@interface VISTNewsPageViewController ()

@property (nonatomic, strong)SYZNewsViewController *listOne;
@property (nonatomic, strong)SYZNewsFarstViewController *listTwo;
@property (nonatomic, strong)NewsCalendarViewController *calendar;

@end

@implementation VISTNewsPageViewController

- (void)viewDidLoad {
    [self setUp];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"资讯"];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showNewsType:) name:@"Notification_NewsType" object:nil];
}

- (void)showNewsType:(NSNotification *)aNotification {
    NSString *type = aNotification.object;
    if ([type isEqualToString:@"0"]) {
        self.selectIndex = 0;
    } else if ([type isEqualToString:@"1"]) {
        self.selectIndex = 1;
    } else if ([type isEqualToString:@"2"]) {
        self.selectIndex = 2;
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)setUp{
    self.showOnNavigationBar = NO;
    self.menuViewStyle = WMMenuViewStyleLine;
    self.progressColor = MainColor;
    self.progressHeight = 3;
    self.menuItemWidth = 80;
    self.titleSizeSelected = 18;
    self.titleColorSelected = MainColor;
    self.titleSizeNormal = 14;
    
}


- (instancetype)initSYZNewsListCenter{
    self = [super initWithViewControllerClasses:@[[SYZNewsFarstViewController class],[NewsCalendarViewController class],[SYZNewsViewController class]] andTheirTitles:@[@"快讯",@"财经日历",@"新闻"]];
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
            return self.listTwo;
        }
            break;
        case 1:
        {
            return self.calendar;
        }
            break;
        case 2:
        {
            return self.listOne;
        }
            break;
        default:{
            return self.listOne;
        }
            break;
    }
}

/**
 新闻
 */
- (SYZNewsViewController *)listOne {
    if (!_listOne) {
        _listOne = [[SYZNewsViewController alloc] init];
    }
    return _listOne;
}

/**
 快讯
 */
- (SYZNewsFarstViewController *)listTwo {
    if (!_listTwo) {
        _listTwo = [[SYZNewsFarstViewController alloc] init];
    }
    return _listTwo;
}

- (NewsCalendarViewController *)calendar {
    if (!_calendar) {
        _calendar = [[NewsCalendarViewController alloc] init];
    }
    return _calendar;
}

@end
