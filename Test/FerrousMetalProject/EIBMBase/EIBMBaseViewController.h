//
//  BaseViewController.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 30/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EIBMNavigationBarView.h"

NS_ASSUME_NONNULL_BEGIN

typedef enum {
    AARightButtonNormalFont,
    AARightButtonLittleFont
}AARightButtonFontType;

@interface EIBMBaseViewController : UIViewController

@property (nonatomic, strong) UIView * contentView;
@property (nonatomic, strong) EIBMNavigationBarView *navigationBarView;

@property (assign, nonatomic) NSInteger page;

@property (strong,nonatomic) NSMutableArray * dataArr;

- (void)loadMoreData;

- (void)loadData;

//初始化方法要子类复写
- (id)initWithDictionary:(NSDictionary *)dictionary;

-(void)setNavigationBarTitle:(NSString *)title;

- (void)setNavigationBarBackgroundColor:(UIColor *)color;

-(void)setNavigationBarHidden:(BOOL)isHidden;

-(void)setUpContentBgViewWithImg:(UIImage*)img;

-(void)setNavigationBarBgViewWithImg:(UIImage*)img;
//设置左右uibutton样式。   左边默认返回按钮；右边默认无按钮
- (void)setLeftButtonStyle:(AAButtonStyle)style;
- (void)setRightButtonStyle:(AAButtonStyle)style;

-(void)presentLoginViewController;

/**
 *  导航栏左侧点击事件
 */
- (void)leftButtonClick;
/**
 *  导航栏右侧按钮点击事件
 */
- (void)rightButtonClick;
/**
 导航栏含有两个按钮，左边按钮点击事件，如接送机页面接机
 */
- (void)leftItemClick;
/**
 导航栏含有两个按钮，左边按钮点击事件，如接送机页面送机
 */
- (void)rightItemClick;


-(void)AAPresentViewController:(UIViewController *)viewController animated:(BOOL)animated;
/**
 *  设置导航栏右面的按钮字体
 */
- (void)setNaviginationRightButtonFont:(AARightButtonFontType)fontType;

@end

NS_ASSUME_NONNULL_END
