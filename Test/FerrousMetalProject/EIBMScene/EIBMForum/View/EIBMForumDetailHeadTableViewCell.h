//
//  ForumDetailHeadTableViewCell.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMForumDetailHeadTableViewCell : EIBMBaseTableViewCell

@property (nonatomic, strong) UILabel *nameLabel;

@property (nonatomic, strong) UIButton *moreButton;

@property (nonatomic, copy) void(^moreBlock)();

@end

NS_ASSUME_NONNULL_END
