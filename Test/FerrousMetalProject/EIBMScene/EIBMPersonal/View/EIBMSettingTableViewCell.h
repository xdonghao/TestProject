//
//  SettingTableViewCell.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 31/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMSettingTableViewCell : EIBMBaseTableViewCell

- (void)setDataWithTitle:(NSString *)title detail:(NSString *)detail;

@end

NS_ASSUME_NONNULL_END
