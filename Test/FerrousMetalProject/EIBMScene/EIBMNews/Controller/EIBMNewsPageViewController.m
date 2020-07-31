//
//  NewsPageViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 04/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMNewsPageViewController.h"
#import "EIBMNewsViewController.h"
#import "EIBMNewsFlashViewController.h"
#import "EIBMNewsFarstViewController.h"
#import "EIBMHotNewsViewController.h"
@interface EIBMNewsPageViewController ()

@property (nonatomic, strong)EIBMNewsViewController *listOne;
@property (nonatomic, strong)EIBMNewsFarstViewController *listTwo;
@property (nonatomic, strong)EIBMHotNewsViewController *hotNews0;
@property (nonatomic, strong)EIBMHotNewsViewController *hotNews1;
@property (nonatomic, strong)EIBMHotNewsViewController *hotNews2;
@property (nonatomic, strong)EIBMHotNewsViewController *hotNews3;
@property (nonatomic, strong) NSMutableArray *listArray;

@end

@implementation EIBMNewsPageViewController

- (void)viewDidLoad {
    [self setUp];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"资讯"];
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

- (void)setUp{
    self.showOnNavigationBar = NO;
    self.menuViewStyle = WMMenuViewStyleLine;
    self.progressColor = MainColor;
    self.progressHeight = 3;
    self.menuItemWidth = 40;
    self.titleSizeSelected = 18;
    self.titleColorSelected = MainColor;
    self.titleSizeNormal = 14;
    
}

- (instancetype)initEIBMNewsListCenter{
    self = [super initWithViewControllerClasses:@[[EIBMHotNewsViewController class],[EIBMHotNewsViewController class],[EIBMHotNewsViewController class],[EIBMHotNewsViewController class],[EIBMNewsViewController class],[EIBMNewsFarstViewController class]] andTheirTitles:@[@"推荐",@"债券",@"货币",@"外汇",@"股市",@"快讯"]];
    return self;
}

//- (instancetype)initEIBMNewsListCenter{
//    self = [super initWithViewControllerClasses:@[[EIBMHotNewsViewController class],[EIBMNewsViewController class],[EIBMNewsFarstViewController class]] andTheirTitles:@[@"头条要闻",@"期货新闻",@"实时快讯"]];
//    return self;
//}

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
            return self.hotNews0;
        }
            break;
        case 1:
        {
            return self.hotNews1;
        }
            break;
        case 2:
        {
            return self.hotNews2;
        }
            break;
        case 3:
        {
            return self.hotNews3;
        }
            break;
        case 4:
        {
            return self.listOne;
            
        }
            break;
        case 5:
        {
            return self.listTwo;
            
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
- (EIBMNewsViewController *)listOne {
    if (!_listOne) {
        _listOne = [[EIBMNewsViewController alloc] init];
    }
    return _listOne;
}

/**
 快讯
 */
- (EIBMNewsFarstViewController *)listTwo {
    if (!_listTwo) {
        _listTwo = [[EIBMNewsFarstViewController alloc] init];
    }
    return _listTwo;
}

- (EIBMHotNewsViewController *)hotNews0 {
    if (!_hotNews0) {
        _hotNews0 = [[EIBMHotNewsViewController alloc] init];
        _hotNews0.type = @(0);
    }
    return _hotNews0;
}

- (EIBMHotNewsViewController *)hotNews1 {
    if (!_hotNews1) {
        _hotNews1 = [[EIBMHotNewsViewController alloc] init];
        _hotNews1.type = @(1);
    }
    return _hotNews1;
}
- (EIBMHotNewsViewController *)hotNews2 {
    if (!_hotNews2) {
        _hotNews2 = [[EIBMHotNewsViewController alloc] init];
        _hotNews2.type = @(2);
    }
    return _hotNews2;
}
- (EIBMHotNewsViewController *)hotNews3 {
    if (!_hotNews3) {
        _hotNews3 = [[EIBMHotNewsViewController alloc] init];
        _hotNews3.type = @(3);
    }
    return _hotNews3;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    NSLog(@"♻️ %@ is dealloc",NSStringFromClass([self class]));
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (NSMutableArray *)listArray {
    if (!_listArray) {
        _listArray = [NSMutableArray array];
    }
    return _listArray;
}

@end
