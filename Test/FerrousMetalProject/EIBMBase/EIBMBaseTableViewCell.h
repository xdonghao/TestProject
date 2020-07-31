//
//  BaseTableViewCell.h
//  BusinessOfArt
//
//  Created by 董浩 on 2017/9/3.
//  Copyright © 2017年 donghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EIBMBaseTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *bottomLine;

- (void)configUI;

//赋值的方法
- (void)setDataWithSourceData:(id)model;

- (void)showBottomLine;

- (void)hiddenBottomLine;

+(CGFloat)getCellHeightWithString:(NSString *)str;
@end
