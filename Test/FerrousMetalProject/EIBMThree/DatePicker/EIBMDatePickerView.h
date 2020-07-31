//
//  AADatePickerView.h
//  AAYongZhe
//
//  Created by aayongche on 16/2/29.
//  Copyright © 2016年 程磊. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EIBMDatePickerViewDelegate <NSObject>
/**
 *  确定按钮
 */
- (void)sureClickWithString:(NSString *)dateStr;

@end
@interface EIBMDatePickerView : UIView

@property (nonatomic, strong) UIDatePicker *datePicker;


@property (nonatomic, strong) UIImageView *shadowImageView;
/**
 *  选择器跟toolbar的父视图
 */
@property (nonatomic, strong) UIView *backView;
/**
 *  代理
 */
@property (nonatomic, assign) id<EIBMDatePickerViewDelegate> delegate;

/**
 *  初始化一个时间选择器实例
 */
- (instancetype)initWithCancleTitle:(NSString *)cancleTitle andSureTitle:(NSString *)sureTitle;
/**
 *  显示在指定View
 */
- (void)showInView:(UIView *)view;

@end
