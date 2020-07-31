//
//  MarketKLineHeaderView.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 02/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMMarketKLineHeaderView.h"
#import "WMMenuView.h"
@interface EIBMMarketKLineHeaderView ()<WMMenuViewDelegate, WMMenuViewDataSource>

@property (nonatomic, strong) WMMenuView *menuView;

@property (nonatomic, copy) NSArray *dataArray;

@end

@implementation EIBMMarketKLineHeaderView

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self configUI];
    }
    return self;
}

- (void)configUI{
    self.contentView.backgroundColor = LLBackGroundWhiteColor;
    WMMenuView *menuView = [[WMMenuView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    menuView.delegate = self;
    menuView.dataSource = self;
    menuView.style = WMMenuViewStyleLine;
    menuView.progressHeight = 3;
    menuView.progressWidths = @[@(20),@(20),@(20),@(20),@(20)];
//    menuView.layoutMode = self.menuViewLayoutMode;
//    menuView.progressHeight = self.progressHeight;
//    menuView.contentMargin = self.menuViewContentMargin;
//    menuView.progressViewBottomSpace = self.progressViewBottomSpace;
//    menuView.progressWidths = self.progressViewWidths;
//    menuView.progressViewIsNaughty = self.progressViewIsNaughty;
//    menuView.progressViewCornerRadius = self.progressViewCornerRadius;
    menuView.showOnNavigationBar = NO;
//    if (self.titleFontName) {
//        menuView.fontName = self.titleFontName;
//    }
//    if (self.progressColor) {
//        menuView.lineColor = self.progressColor;
//    }
    [self addSubview:menuView];
    self.menuView = menuView;
}

- (void)updateConstraints
{
    [super updateConstraints];
}

- (void)menuView:(WMMenuView *)menu didSelesctedIndex:(NSInteger)index currentIndex:(NSInteger)currentIndex {
    if (self.delegate && [self.delegate respondsToSelector:@selector(kLineViewDidSelesctedIndex:currentIndex:)]) {
        [self.delegate kLineViewDidSelesctedIndex:index currentIndex:currentIndex];
    }
}

- (UIColor *)menuView:(WMMenuView *)menu titleColorForState:(WMMenuItemState)state atIndex:(NSInteger)index {
    if (state == WMMenuItemStateNormal) {
        return TitleColor;
    } else {
        return MainColor;
    }
}

- (NSInteger)numbersOfTitlesInMenuView:(WMMenuView *)menu {
    return self.dataArray.count;
}
- (NSString *)menuView:(WMMenuView *)menu titleAtIndex:(NSInteger)index {
    return self.dataArray[index];
}

- (NSArray *)dataArray {
    if (!_dataArray) {
//        _dataArray = [NSArray arrayWithObjects:@"5分",@"30分钟",@"1小时",@"2小时",@"日K", nil];
        _dataArray = [NSArray arrayWithObjects:@"1分",@"5分钟",@"10分",@"15分",@"日线", nil];
    }
    return _dataArray;
}

@end
