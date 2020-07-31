//
//  ForumNewListTableViewCell.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMForumNewListTableViewCell : EIBMBaseTableViewCell

@property (nonatomic, copy) void(^success)(NSInteger index, BOOL sel);

@end

NS_ASSUME_NONNULL_END
