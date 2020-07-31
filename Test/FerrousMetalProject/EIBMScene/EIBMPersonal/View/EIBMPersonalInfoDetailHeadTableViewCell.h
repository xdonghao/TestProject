//
//  PersonalInfoDetailHeadTableViewCell.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 05/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMPersonalInfoDetailHeadTableViewCell : EIBMBaseTableViewCell

/**
 *  背景imageView
 */
@property (nonatomic, strong) UIImageView *backImageView;

/**
 *  头像
 */
@property (nonatomic, strong) UIImageView *iconImageView;

/**
 *  箭头指示
 */
//@property (nonatomic, strong) UIImageView *indicateImageView;

/**
 *  更改头像，用在个人资料页面
 */
@property (nonatomic, strong) UILabel *chageIconLabel;

/**
 *  实例化一个cell
 */
+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
