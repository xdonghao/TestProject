//
//  FactoryTool.h
//  BusinessOfArt
//
//  Created by 董浩 on 2017/10/25.
//  Copyright © 2017年 donghao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EIBMFactoryTool : NSObject
/**
 Label工厂方法
 
 @param font          字体
 @param textAlignment 对齐方式
 @param color         字体颜色
 
 @return Label
 */
+ (nullable UILabel *)labelWithFont:(nullable UIFont *)font
                      textAlignment:(NSTextAlignment)textAlignment
                          textColor:(nullable UIColor *)color;
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
                                 font:(nullable UIFont *)font
                            textColor:(nullable UIColor *)color;

+ (nullable UITextField *)fieldWithPlaceholder:(nullable NSString *)placeholder
                                          font:(nullable UIFont *)font;

/**
 ImageView工厂方法
 
 @param name 图片名称
 
 @return ImageView
 */
+ (nullable UIImageView *)imageViewWithImageName:(nullable NSString *)name;
/**
 向右的箭头
 
 @return 向右的箭头
 */

+ (nullable UIImageView *)arrowImageView;
@end
