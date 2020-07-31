//
//  AADatePickerView.m
//  AAYongZhe
//
//  Created by aayongche on 16/2/29.
//  Copyright © 2016年 程磊. All rights reserved.
//

#import "EIBMDatePickerView.h"

@interface EIBMDatePickerView ()

@property (nonatomic, strong) NSString *selectDateStr;

@end

@implementation EIBMDatePickerView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    if (self = [super init]) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        self.shadowImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        self.shadowImageView.userInteractionEnabled = YES;
        self.shadowImageView.backgroundColor = kRGBA(0x000000, 0.4);
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(removeSelf)];
        [self.shadowImageView addGestureRecognizer:tap];
        [self addSubview:self.shadowImageView];
    }
    return self;
}

- (instancetype) initWithCancleTitle:(NSString *)cancleTitle andSureTitle:(NSString *)sureTitle{
    if (self = [self init]) {
        _backView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 195)];
        [self addSubview:_backView];
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 150)];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        NSDate *date = [NSDate date];
        _datePicker.maximumDate = date;
        _datePicker.backgroundColor = kRGBA(0xFFFFFF, 1);
        [_backView addSubview:_datePicker];
        UIView *toolBarView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
        toolBarView.backgroundColor = kRGB(0xFFFFFF);
        UIImageView *lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 44.5, SCREEN_WIDTH, 0.5)];
        lineImageView.backgroundColor = LINECOLOR;
        [toolBarView addSubview:lineImageView];
        [_backView addSubview:toolBarView];
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [leftButton setTitle:cancleTitle forState:UIControlStateNormal];
        [leftButton setTitleColor:kRGBA(0xb4b4b4, 1) forState:UIControlStateNormal];
        leftButton.tag = 101;
        [leftButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        leftButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
        leftButton.frame = CGRectMake(15, 0, 100, 45);
        leftButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [toolBarView addSubview:leftButton];
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeSystem];
        [rightButton setTitleColor:TitleColor forState:UIControlStateNormal];
        [rightButton setTitle:sureTitle forState:UIControlStateNormal];
        rightButton.tag = 102;
        [rightButton addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        rightButton.titleLabel.font = [UIFont systemFontOfSize:17.0];
        rightButton.frame = CGRectMake(self.bounds.size.width-100, 0, 85, 45);
        rightButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        [toolBarView addSubview:rightButton];
    }
    return self;
}

- (void)btnClick:(UIButton *)btn{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YYYY-MM-dd"];
    NSString *timeStr;
    timeStr = [dateFormatter stringFromDate:_datePicker.date];
    if (btn.tag == 102) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(sureClickWithString:)]) {
            if (!timeStr) {
                timeStr = @"1980-01-01";
            }
            [self.delegate sureClickWithString:timeStr];
        }
    }
    [self removeFromSuperview];
}

- (void)removeSelf{
    [UIView animateWithDuration:0.3 animations:^{
        _backView.frame = CGRectMake(_backView.left, SCREEN_HEIGHT, _backView.width, _backView.height);
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)showInView:(UIView *)view{
    [view addSubview:self];
    [UIView animateWithDuration:0.3 animations:^{
        _backView.frame = CGRectMake(_backView.left, SCREEN_HEIGHT-_backView.height, _backView.width, _backView.height);
    } completion:^(BOOL finished) {
    }];
}

@end
