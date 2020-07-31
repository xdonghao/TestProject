//
//  BaseViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 30/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "EIBMBaseNavigationViewController.h"
@interface EIBMBaseViewController ()<AANavigationBarViewDelegate>
{
    UIImageView* _contentBgView;
    UIImageView* NavigationBarBgView;
}

@end

@implementation EIBMBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = LLBackGroundWhiteColor;
    [self loadContentView];
    [self loadNavigationBar];
}

- (void)loadMoreData{
    
}

- (void)loadData{
    
}

#pragma mark - Public

- (id)initWithDictionary:(NSDictionary*)dictionary {
    if (self = [super init]) {
    }
    return self;
}

- (void)setUpContentBgViewWithImg:(UIImage*)img
{
    if (!_contentBgView) {
        _contentBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _contentBgView.userInteractionEnabled = YES;
        [_contentBgView setBackgroundColor:LLBackGroundWhiteColor];
        [self.view addSubview:_contentBgView];
        [self.view sendSubviewToBack:_contentBgView];
    }
    [_contentBgView setImage:img];
}

-(void)setNavigationBarBgViewWithImg:(UIImage*)img{
    if (!NavigationBarBgView) {
        NavigationBarBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight)];
        NavigationBarBgView.userInteractionEnabled = YES;
        [_navigationBarView addSubview:NavigationBarBgView];
        [_navigationBarView sendSubviewToBack:NavigationBarBgView];
    }
    [NavigationBarBgView setImage:img];
}

-(void)loadContentView{
    if (!_contentView) {
        _contentView = [[UIView alloc] init];
        _contentView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:_contentView];
    }
    _contentView.frame = CGRectMake(0, SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - SafeAreaTopHeight);
    self.view.backgroundColor = LLBackGroundWhiteColor;
    if ([self isNeedBgImage]&&!_contentBgView) {
        _contentBgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _contentBgView.userInteractionEnabled = YES;
        [_contentBgView setBackgroundColor:LLBackGroundWhiteColor];
        [self.view addSubview:_contentBgView];
        [self.view bringSubviewToFront:_contentBgView];
    }
    self.automaticallyAdjustsScrollViewInsets = NO;
}
-(void)loadNavigationBar{
    self.fd_prefersNavigationBarHidden = YES;
    if ([self isLoadNavigationBar]) {
        if (!_navigationBarView) {
            _navigationBarView = [[EIBMNavigationBarView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SafeAreaTopHeight)];
            _navigationBarView.delegate = self;
            [self.view addSubview:_navigationBarView];
        }
    } else {
        _contentView.top = 0;
        _contentView.height = SCREEN_HEIGHT ;
    }
}

#pragma mark - NavigationBarViewButtonStyle

- (void)setRightButtonStyle:(AAButtonStyle)style {
    [_navigationBarView setRightButtonStyle:style];
}

- (void)setLeftButtonStyle:(AAButtonStyle)style {
    [_navigationBarView setLeftButtonStyle:style];
}

- (void)setNaviginationRightButtonFont:(AARightButtonFontType)fontType {
    if (fontType == AARightButtonLittleFont) {
        _navigationBarView.rightButton.titleLabel.font = [UIFont systemFontOfSize:15.0];
    }
}

#pragma mark - NavigationBarViewTitle

- (void)setNavigationBarHidden:(BOOL)isHidden {
    _navigationBarView.hidden = isHidden;
}

- (void)setNavigationBarTitle:(NSString *)title {
    _navigationBarView.titleLabel.text = title;
}

- (void)setNavigationBarBackgroundColor:(UIColor *)color {
    _navigationBarView.backgroundColor = color;
}

- (NSString *)getTitle {
    return  _navigationBarView.titleLabel.text;
}

- (void)TokenExpire {
    
}

- (void)presentLoginViewController {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

#pragma mark - NavigationBarViewButtonClick(NavigationBarViewDelegate)

- (void)leftButtonClick {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)rightButtonClick {
    
}
- (void)leftItemClick {
    
}
- (void)rightItemClick {
    
}

- (void)AAPresentViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (viewController) {
        EIBMBaseNavigationViewController * navigationController = [[EIBMBaseNavigationViewController alloc]initWithRootViewController:viewController];
        [self presentViewController:navigationController animated:YES completion:^{
            
        }];
    }
}

#pragma mark - Private

- (BOOL)isLoadNavigationBar {
    return YES;
}

- (BOOL)isNeedBgImage {
    return NO;
}

- (NSMutableArray *)dataArr{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}

- (NSInteger)getMonth {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dayComponents = [calendar components:(NSCalendarUnitMonth) fromDate:[NSDate date]];
    return [dayComponents month];
}

- (void)dealloc {
    NSLog(@"♻️ %@ is dealloc",NSStringFromClass([self class]));
}

@end
