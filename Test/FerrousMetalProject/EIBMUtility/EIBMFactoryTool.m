//
//  FactoryTool.m
//  BusinessOfArt
//
//  Created by 董浩 on 2017/10/25.
//  Copyright © 2017年 donghao. All rights reserved.
//

#import "EIBMFactoryTool.h"

@implementation EIBMFactoryTool
/**
 Label工厂方法
 
 @param font          字体
 @param textAlignment 对齐方式
 @param color         字体颜色
 
 @return Label
 */
+ (nullable UILabel *)labelWithFont:(nullable UIFont *)font
                      textAlignment:(NSTextAlignment)textAlignment
                          textColor:(nullable UIColor *)color
{
    UILabel *label = [[UILabel alloc]init];
    label.font = font;
    label.textAlignment = textAlignment;
    label.textColor = color;
    return label;
}

/**
 Button工厂方法
 
 @param type          类型
 @param target        target
 @param action        方法
 @param controlEvents Events
 @param font          字体
 @param color         字体颜色
 
 @return Button
 */
+ (nullable UIButton *)buttonWithType:(UIButtonType)type
                               Target:(__nonnull id)target
                               action:(__nonnull SEL)action
                     forControlEvents:(UIControlEvents)controlEvents
                                 font:(UIFont *)font
                            textColor:(UIColor *)color;{
    UIButton *button = [UIButton buttonWithType:type];
    [button addTarget:target action:action forControlEvents:controlEvents];
    [button setTitleColor:color forState:UIControlStateNormal];
    [button.titleLabel setFont:font];
    [button setTitleColor:color forState:UIControlStateNormal];
    return button;
}

+ (nullable UITextField *)fieldWithPlaceholder:(nullable NSString *)placeholder
                                          font:(nullable UIFont *)font {
    UITextField *field = [[UITextField alloc] init];
    field.placeholder = placeholder;
    field.font = font;
    field.backgroundColor = kWhiteColor;
    return field;
}

/**
 ImageView工厂方法
 
 @param name 图片名称
 
 @return ImageView
 */
+ (nullable UIImageView *)imageViewWithImageName:(nullable NSString *)name{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
}

/**
 向右的箭头
 
 @return 向右的箭头
 */
+ (UIImageView *)arrowImageView{
    return [EIBMFactoryTool imageViewWithImageName:@"Arrow_right_icon"];//(7,12)
}
@end
