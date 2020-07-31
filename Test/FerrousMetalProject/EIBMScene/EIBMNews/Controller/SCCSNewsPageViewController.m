//
//  NewsPageViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 04/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "ADNewsPageViewController.h"
#import "SCCSNewsViewController.h"
#import "SCCSNewsFlashViewController.h"
@interface ADNewsPageViewController ()

@property (nonatomic, strong)SCCSNewsViewController *listOne;
@property (nonatomic, strong)SCCSNewsFlashViewController *listTwo;
@property (nonatomic, strong)SCCSNewsFlashViewController *listThree;

@end

@implementation ADNewsPageViewController

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
    self.showOnNavigationBar = NO;
    self.menuViewStyle = WMMenuViewStyleLine;
    self.progressColor = TitleColor;
    self.progressHeight = 3;
    self.menuItemWidth = 80;
    self.titleSizeSelected = 14;
    self.titleColorSelected = TitleColor;
    self.titleSizeNormal = 14;
    
}


- (instancetype)initSCCSNewsListCenter{
    self = [super initWithViewControllerClasses:@[[SCCSNewsViewController class],[SCCSNewsFlashViewController class],[SCCSNewsFlashViewController class]] andTheirTitles:@[@"要闻",@"快讯",@"大事件"]];
    return self;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    return CGRectMake(0, 0, SCREEN_WIDTH, 44);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    return CGRectMake(0, 44, SCREEN_WIDTH, self.view.frame.size.height - 44);
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    switch (index) {
        case 0:
        {
            return self.listOne;
        }
            break;
        case 1:
        {
            return self.listTwo;
        }
            break;
        case 2:
        {
            return self.listThree;
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
- (SCCSNewsViewController *)listOne {
    if (!_listOne) {
        _listOne = [[SCCSNewsViewController alloc] init];
    }
    return _listOne;
}

/**
 快讯
 */
- (SCCSNewsFlashViewController *)listTwo {
    if (!_listTwo) {
        _listTwo = [[SCCSNewsFlashViewController alloc] init];
        _listTwo.listDataJsonPath = [[NSBundle mainBundle] pathForResource:@"kuaixun_k_data" ofType:@"json"];
    }
    return _listTwo;
}
/**
 大事件
 */
- (SCCSNewsFlashViewController *)listThree {
    if (!_listThree) {
        _listThree = [[SCCSNewsFlashViewController alloc] init];
        _listThree.listDataJsonPath = [[NSBundle mainBundle] pathForResource:@"dashijian_k_data" ofType:@"json"];
        _listThree.show = YES;
    }
    return _listThree;
}

@end
