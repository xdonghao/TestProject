//
//  Defination.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 30/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#ifndef Defination_h
#define Defination_h


#define WEAKSELF  typeof(self) __weak weakSelf=self;
// color
#define TitleColor DYHexColor(0x292421, 0xFFFFFF)
#define MainColor [UIColor colorWithHexString:@"E3CF57"]

#define kRedColor [UIColor colorWithHexString:@"B0171F"]
#define kGreenColor [UIColor colorWithHexString:@"308014"]

#define kWhiteColor DYUIColor([UIColor colorWithHexString:@"FFFFFF"], [UIColor colorWithHexString:@"373739"])
#define kBlackColor DYUIColor([UIColor colorWithHexString:@"000000"], [UIColor colorWithHexString:@"FFFFFF"])
//页面背景色
#define LLBackGroundWhiteColor DYUIColor([UIColor colorWithHexString:@"f7f7f7"], [UIColor colorWithHexString:@"28282a"])
//导航栏背景色
#define NavgationBarBackgroundColor DYHexColor(0xFFFFFF, 0x373739)
//导航栏标题颜色
#define LLNavTitleColor DYHexColor(0x292421, 0xFFFFFF)
//导航栏标题字体大小
#define NavigationBarTitleFont [UIFont systemFontOfSize:17]
#define NavgationBarTitleColor DYHexColor(0x101010, 0xFFFFFF)
#define NavgationBarItemColor kRGB(0x666666)
#define NavigationBarLeftTitleFont [UIFont systemFontOfSize:17]
#define NavigationBarRightTitleFont [UIFont systemFontOfSize:14]
//导航栏颜色
#define LLNavDarkGrayColor [UIColor colorWithHexString:@"f7f7f7"]
//NavItem颜色
#define LLNavItemTitleColor DYHexColor(0xFFFFFF, 0x000000)
//TabBar颜色
#define LLTabBarColor DYHexColor(0xFFFFFF, 0x373739)
//下划线颜色
#define LINECOLOR                   DYHexColor(0xe5e5e5, 0x76767c)
//通用字体深色颜色
#define UNIVERSALTEXTCOLOR          kRGB(0x101010)
//通用字体浅色颜色
#define UNIVERSALLIGHTTEXTCOLOR     kRGB(0xb4b4b4)
//通用背景色
#define UniversalBackGround         kRGB(0xf0f0f0)
//确认按钮通用背景色
#define SUREBUTTONBACKGROUNDCOLOR   kRGB(0x101010)
#define SUREBUTTONHIGHLIGHTEDBACKGROUNDCOLOR kRGBA(0x101010, 0.6)

#define kRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:1.0]
#define kRGBA(rgbValue,a) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16)) / 255.0 green:((float)((rgbValue & 0xFF00) >> 8)) / 255.0 blue:((float)(rgbValue & 0xFF)) / 255.0 alpha:(a)]
//获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:1]




// screen
#define SCREEN_SIZE             ([UIScreen mainScreen].bounds.size)
#define SCREEN_WIDTH            ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT           ([UIScreen mainScreen].bounds.size.height)
#define MAIN_SCREEN_HEIGHT      (SCREEN_HEIGHT - (IS_IPhoneX_All ? 88 : 64))
#define SafeAreaTopHeight       (IS_IPhoneX_All ? 88 : 64)
#define SafeAreaBottomHeight    (IS_IPhoneX_All ? 34 : 0)


/*状态栏和导航栏总高度*/
#define kNavBarAndStatusBarHeight (CGFloat)(IS_IPhoneX_All?(88.0):(64.0))
/*导航条和Tabbar总高度*/
#define kNavAndTabHeight (kNavBarAndStatusBarHeight + kTabBarHeight)
#define kTabBarHeight  (CGFloat)(IS_IPhoneX_All?(49.0 + 34.0):(49.0))



#define is_iPhone4              (SCREEN_HEIGHT == 480)
//是否iPhoneX
#define IS_IPHONE_X             ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPHoneXr
#define IS_IPHONE_Xr            ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(828, 1792), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhoneXs
#define IS_IPHONE_Xs            ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)
//判断iPhoneXs Max
#define IS_IPHONE_Xs_Max        ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size) : NO)

//判断设备是否带刘海的iPhone
//#define IS_IPhoneX_All (IS_IPHONE_X == YES || IS_IPHONE_Xr == YES || IS_IPHONE_Xs == YES || IS_IPHONE_Xs_Max== YES)

#define IS_IPhoneX_All ([UIScreen mainScreen].bounds.size.height == 812 || [UIScreen mainScreen].bounds.size.height == 896)

#define SIDE_MARGIN             15
// 根据iPhone6的尺寸进行适配
#define AutoScale               ([UIScreen mainScreen].bounds.size.width/375.0)
#define AutoScaleWidth(x)       (([UIScreen mainScreen].bounds.size.width/375.0)*(x))
#define AutoScaleHeight(x)      (([UIScreen mainScreen].bounds.size.height/667.0)*(x))





// app version
#define APP_VERSION             [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"]


// font
#define UIFontSize(size)        [UIFont kk_systemFontOfSize:(size)]
#define UIBoldFontSize(size)    [UIFont kk_boldSystemFontOfSize:(size)]

#define kKeyWindow [UIApplication sharedApplication].keyWindow

#define IMAGENOPIC @"nopic"




#endif /* Defination_h */
