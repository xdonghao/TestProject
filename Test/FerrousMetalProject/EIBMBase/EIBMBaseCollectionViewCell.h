//
//  BaseCollectionViewCell.h
//  BusinessOfArt
//
//  Created by 董浩 on 2017/10/29.
//  Copyright © 2017年 donghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EIBMBaseCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong)UILabel *bottomLine;
- (void)configUI;

//赋值的方法
- (void)setDataWithSourceData:(id)model;

+(CGFloat)getCellHeightWithString:(NSString *)str;
@end
