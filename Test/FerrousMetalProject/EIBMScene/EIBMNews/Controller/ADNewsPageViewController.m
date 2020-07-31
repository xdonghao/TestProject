//
//  NewsPageViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 04/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "SYZNewsPageViewController.h"
#import "ADNewsViewController.h"
#import "ADNewsFlashViewController.h"
#import "ADNewsFarstViewController.h"
@interface SYZNewsPageViewController ()

@property (nonatomic, strong)ADNewsViewController *listOne;
@property (nonatomic, strong)ADNewsFarstViewController *listTwo;

@end

@implementation SYZNewsPageViewController

- (void)viewDidLoad {
    [self setUp];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"资讯";
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
    self.showOnNavigationBar = YES;
    self.menuViewStyle = WMMenuViewStyleLine;
    self.progressColor = TitleColor;
    self.progressHeight = 3;
    self.menuItemWidth = 40;
    self.titleSizeSelected = 18;
    self.titleColorSelected = TitleColor;
    self.titleSizeNormal = 14;
    
}


- (instancetype)initADNewsListCenter{
    self = [super initWithViewControllerClasses:@[[ADNewsFarstViewController class],[ADNewsViewController class]] andTheirTitles:@[@"快讯",@"新闻"]];
    return self;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, 0, SCREEN_WIDTH, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, 0, SCREEN_WIDTH, self.view.frame.size.height);
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
- (ADNewsViewController *)listOne {
    if (!_listOne) {
        _listOne = [[ADNewsViewController alloc] init];
    }
    return _listOne;
}

/**
 快讯
 */
- (ADNewsFarstViewController *)listTwo {
    if (!_listTwo) {
        _listTwo = [[ADNewsFarstViewController alloc] init];
    }
    return _listTwo;
}

@end
