//
//  PersonalInfoCustomTableViewCell.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 05/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMPersonalInfoCustomTableViewCell : EIBMBaseTableViewCell <UITextFieldDelegate>

/**
 *  图标
 */
@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UILabel *infoLabel;

@end

NS_ASSUME_NONNULL_END
