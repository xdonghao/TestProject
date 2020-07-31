//
//  AANavigationBarView.m
//  Masnory
//
//  Created by shaobo on 15/11/16.
//  Copyright (c) 2015年 Harry Huang. All rights reserved.
//

#import "EIBMNavigationBarView.h"
#import "UIView+ITTAdditions.h"
#import "UIButton+FillColor.h"

@implementation EIBMNavigationBarView

#pragma mark - LifeCycle

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = NavgationBarBackgroundColor;
        [self createTitleLabel];
        [self setNavigationBar];
        NSInteger i = 1;
//        self.lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 63.5, SCREEN_WIDTH, 0.5)];
//        self.lineImageView.backgroundColor = LINECOLOR;
//        [self addSubview:self.lineImageView];
    }
    return self;
}

#pragma mark - Private

- (void)createTitleLabel {
    if (_titleLabel == nil) {
//        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight - 44, SCREEN_WIDTH, 44)];
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(50, SafeAreaTopHeight - 44, SCREEN_WIDTH - 100, 44)];
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = NavigationBarTitleFont;
        _titleLabel.textColor = LLNavTitleColor;
        _titleLabel.backgroundColor = [UIColor clearColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
}

- (void)setNavigationBar {
    [self createLeftButton];
    [self createRightButton];
}

-(void)setLeftSingle{
    [_leftItem setBackgroundColor:SUREBUTTONBACKGROUNDCOLOR forState:UIControlStateDisabled];
    [_leftItem setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateDisabled];
    [_rightItem setBackgroundColor:UniversalBackGround forState:UIControlStateDisabled];
    [_rightItem setTitleColor:UNIVERSALLIGHTTEXTCOLOR forState:UIControlStateDisabled];
     [_leftItem.superview layer].borderColor=[UIColor clearColor].CGColor;
    [_rightItem setEnabled:NO];
    [_leftItem setEnabled:NO];
}

-(void)SetRightSigle{
    [_rightItem setBackgroundColor:SUREBUTTONBACKGROUNDCOLOR forState:UIControlStateDisabled];
    [_rightItem setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateDisabled];
    [_leftItem setBackgroundColor:UniversalBackGround forState:UIControlStateDisabled];
    [_leftItem setTitleColor:UNIVERSALLIGHTTEXTCOLOR forState:UIControlStateDisabled];
    [_leftItem.superview layer].borderColor=[UIColor clearColor].CGColor;
    [_rightItem setEnabled:NO];
    [_leftItem setEnabled:NO];
}

-(void)resetItem{
    [_rightItem setEnabled:YES];
    [_leftItem setEnabled:YES];
    [_leftItem setBackgroundColor:SUREBUTTONBACKGROUNDCOLOR forState:UIControlStateNormal];
    [_leftItem setBackgroundColor:SUREBUTTONHIGHLIGHTEDBACKGROUNDCOLOR forState:UIControlStateHighlighted];
    [_leftItem setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    [_rightItem setBackgroundColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
    [_rightItem setBackgroundColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateHighlighted];
    [_rightItem setTitleColor:UNIVERSALTEXTCOLOR forState:UIControlStateNormal];
    [_leftItem.superview layer].borderColor=[UIColor colorWithHexString:@"101010"].CGColor;
    [_leftItem.superview layer].borderWidth=1;
}

- (void)createLeftButton
{
    if (_leftButton == nil) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *leftImage = [UIImage imageNamed:@"common_close"];
        _leftButton.frame = CGRectMake(0, SafeAreaTopHeight - 64 + 20, leftImage.size.width, leftImage.size.height);
        [_leftButton setTitleColor:NavgationBarItemColor forState:UIControlStateNormal];
        _leftButton.titleLabel.font = NavigationBarLeftTitleFont;
        [_leftButton addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_leftButton];
    }
}

- (void)createRightButton
{
    if (_rightButton == nil) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightButton.frame = CGRectMake(SCREEN_WIDTH-150-15, SafeAreaTopHeight - 64 + 20, 150, 44);
        [_rightButton setTitleColor:NavgationBarTitleColor forState:UIControlStateNormal];
        [_rightButton addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton.titleLabel.font = NavigationBarRightTitleFont;
        _rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        _arrow=[[UIImageView alloc] init];
        [self addSubview:_arrow];
        [self addSubview:_rightButton];
    }
}

- (UIButton *)leftButton
{
    if (_leftButton == nil) {
        [self createLeftButton];
    }
    return _leftButton;
}

- (UIButton *)rightButton
{
    if (_rightButton == nil) {
        [self createRightButton];
    }
    
    return _rightButton;
}
//设置左右uibutton样式。   左边默认返回按钮；右边默认无按钮
- (void)setLeftButtonStyle:(AAButtonStyle)style
{
    [self setUIButtonStyle:style withUIButton:self.leftButton];
}

- (void)setRightButtonStyle:(AAButtonStyle)style
{
    [self setUIButtonStyle:style withUIButton:self.rightButton];
}

-(void)setUIButtonStyle:(AAButtonStyle)style withUIButton:(UIButton *)button
{
    if(style == AAButtonStyleBack)
    {
        [button setImage:[UIImage imageNamed:@"left_back"] forState:UIControlStateNormal];
        
    }else if (style == AAButtonStyleNone){
        button.hidden = YES;
    }else if (style == AAButtonStyleClose){
        [button setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@""] forState:UIControlStateHighlighted];
        [button setTitle:@"关闭" forState:UIControlStateNormal];
        
    }else if (style == AAButtonStyleCoustomSevervice){
        button.width = 70;
//        [button setTitle:@"客服咨询" forState:UIControlStateNormal];
        button.left = SCREEN_WIDTH-button.width-10;
    }else if (style == AAButtonStylePersonInfo){
       [button setImage:[UIImage imageNamed:@"home_personInformation_6.0"] forState:UIControlStateNormal];
    }else if(style == AAButtonStyleMustSure){
        [button setTitle:@"确定" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor colorWithHexString:@"101010"] forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
    }else if (style == AAButtonStyleMy){
        UIImage *img = [UIImage imageNamed:@"home_person"];
        _arrow.image = img;
        _arrow.frame = CGRectMake(SCREEN_WIDTH - 15 - _arrow.image.size.width, CGRectGetMinY(button.frame) + (CGRectGetHeight(button.frame) - img.size.height) / 2, _arrow.image.size.width, _arrow.image.size.height);
    }else if (style == AAButtonStyleOrderCancel){
        button.width = 70;
        [button setTitle:@"取消行程" forState:UIControlStateNormal];
        button.left = SCREEN_WIDTH-button.width-10;
    } else if (style == AAButtonStylePop) {                  //5.0通用返回
        [button setImage:[UIImage imageNamed:@"common_top_back"] forState:UIControlStateNormal];
    } else if (style == AAButtonStyleDismiss) {             //5.0通用dismiss
        [button setImage:[UIImage imageNamed:@"common_close"] forState:UIControlStateNormal];

    } else if (style == AAButtonStyleMore) {
        UIImage *img = [UIImage imageNamed:@"eibm_icon_more"];
        _arrow.image = img;
        _arrow.frame = CGRectMake(SCREEN_WIDTH - 15 - _arrow.image.size.width, CGRectGetMinY(button.frame) + (CGRectGetHeight(button.frame) - img.size.height) / 2, _arrow.image.size.width, _arrow.image.size.height);
    }else if (style== AAButonStyleDetail){
        [button setTitle:@"更多" forState:UIControlStateNormal];
        button.titleLabel.font = [UIFont systemFontOfSize:17];
        _arrow.image=[UIImage imageNamed:@"common_arrow.png"];
        _arrow.frame=CGRectMake(SCREEN_WIDTH-15-_arrow.image.size.width, CGRectGetMinY(button.frame)+18, _arrow.image.size.width, _arrow.image.size.width);
        button.left=button.left+((button.width-_arrow.width)/2);
    } else if (style == AAButtonStyleAdd) {
        UIImage *img = [UIImage imageNamed:@"common_add"];
        _arrow.image = img;
        _arrow.frame = CGRectMake(SCREEN_WIDTH - 15 - _arrow.image.size.width, CGRectGetMinY(button.frame) + (CGRectGetHeight(button.frame) - img.size.height) / 2, _arrow.image.size.width, _arrow.image.size.height);
    } else if (style == AAButtonStyleNotice) {
        UIImage *img = [UIImage imageNamed:@"home_gonggao"];
        _arrow.image = img;
        _arrow.frame = CGRectMake(SCREEN_WIDTH - 15 - _arrow.image.size.width, CGRectGetMinY(button.frame) + (CGRectGetHeight(button.frame) - img.size.height) / 2, _arrow.image.size.width, _arrow.image.size.height);
    } else if (style == AAButtonStyleTime) {
        UIImage *img = [UIImage imageNamed:@"common_date"];
        _arrow.image = img;
        _arrow.frame = CGRectMake(SCREEN_WIDTH - 15 - _arrow.image.size.width, CGRectGetMinY(button.frame) + (CGRectGetHeight(button.frame) - img.size.height) / 2, _arrow.image.size.width, _arrow.image.size.width);
    } else if (style == AAButtonStyleSearch) {
        UIImage *img = [UIImage imageNamed:@"eibm_home_search"];
        _arrow.image = img;
        _arrow.frame = CGRectMake(SCREEN_WIDTH - 15 - _arrow.image.size.width, CGRectGetMinY(button.frame) + (CGRectGetHeight(button.frame) - img.size.height) / 2, _arrow.image.size.width, _arrow.image.size.height);
    }
}
#pragma mark - NavigationBarViewButtonClick

- (void)leftButtonClick:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(leftButtonClick)]) {
        [self.delegate leftButtonClick];
    }
}

- (void)rightButtonClick:(id)sender
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rightButtonClick)]) {
        [self.delegate rightButtonClick];
    }
}
- (void)leftItemClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(leftItemClick)]) {
          [_leftItem setBackgroundColor:SUREBUTTONBACKGROUNDCOLOR forState:UIControlStateNormal];
         [_leftItem setBackgroundColor:SUREBUTTONHIGHLIGHTEDBACKGROUNDCOLOR forState:UIControlStateHighlighted];
          [_leftItem setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
           [_rightItem setTitleColor:UNIVERSALTEXTCOLOR forState:UIControlStateNormal];
           [_rightItem setBackgroundColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
          [_rightItem setBackgroundColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateHighlighted];
        [self.delegate leftItemClick];
    }
}

- (void)rightItemClick:(id)sender {
    if (self.delegate && [self.delegate respondsToSelector:@selector(rightItemClick)]) {
        [_leftItem setTitleColor:UNIVERSALTEXTCOLOR forState:UIControlStateNormal];
           [_leftItem setBackgroundColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
         [_leftItem setBackgroundColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateHighlighted];
        [_rightItem setTitleColor:[UIColor colorWithHexString:@"FFFFFF"] forState:UIControlStateNormal];
        [_rightItem setBackgroundColor:SUREBUTTONBACKGROUNDCOLOR forState:UIControlStateNormal];
          [_rightItem setBackgroundColor:SUREBUTTONHIGHLIGHTEDBACKGROUNDCOLOR forState:UIControlStateHighlighted];
        [self.delegate rightItemClick];
    }
}


@end
