//
//  AANavigationBarView.h
//  Masnory
//
//  Created by shaobo on 15/11/16.
//  Copyright (c) 2015年 Harry Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AAButtonStyle) {
    AAButtonStyleBack,                          //返回
    AAButtonStyleClose,                         //带返回文字
    AAButtonStyleNone,                          //没有返回
    AAButtonStylePersonInfo,                    //我的主页
    AAButtonStyleRightButtonDone,               //完成按钮
    AAButtonStyleCoustomSevervice,              //客服咨询
    AAButtonStyleOrderCancel,                   //就是关闭字
    AAButtonStyleMustSure,                      //确定
    AAButtonStyleMy,                            //我的
    AAButtonStylePop,                           //返回
    AAButtonStyleDismiss,                       //叉号
    AAButtonStyleMore,                          //更多功能
    AAButtonStyleAdd,                           //添加
    AAButtonStyleNotice,                       //绑定信用卡更多
    AAButonStyleDetail,                          //紧急求助，行程分享
    AAButtonStyleTime,                           //选择日期
    AAButtonStyleSearch                          //搜索
};

@protocol AANavigationBarViewDelegate <NSObject>

- (void)leftButtonClick;
- (void)rightButtonClick;
- (void)leftItemClick;
- (void)rightItemClick;

@end
typedef enum {
    AA_DefaultType,
    AA_LeftType,
    AA_RightType
}AA_SlideType;
typedef enum{
    AA_planeType,
    AA_stationType,
    AA_rentType,
    AA_SlideNavType_Coupon,//优惠券
}AA_SlideNavType;
@interface EIBMNavigationBarView : UIView

@property (nonatomic, weak) id <AANavigationBarViewDelegate>delegate;
@property(nonatomic, strong)  UIButton * leftButton;
@property(nonatomic, strong)  UIButton * rightButton;
@property(nonatomic, strong)  UILabel  *  titleLabel;
@property(nonatomic, strong)  UIButton * leftItem;
@property(nonatomic, strong)  UIButton * rightItem;
@property (nonatomic, strong) UIImageView *lineImageView;
@property (nonatomic, strong) UIImageView *arrow;
////设置左右uibutton样式。   左边默认返回按钮；右边默认无按钮
- (void)setLeftButtonStyle:(AAButtonStyle)style;
- (void)setRightButtonStyle:(AAButtonStyle)style;
- (void)leftItemClick:(id)sender;
- (void)rightItemClick:(id)sender;
-(void)setLeftSingle;
-(void)SetRightSigle;
-(void)resetItem;
@end
