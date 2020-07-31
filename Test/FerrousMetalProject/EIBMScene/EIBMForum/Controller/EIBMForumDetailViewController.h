//
//  ForumDetailViewController.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseTableViewController.h"
#import "EIBMForumListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMForumDetailViewController : EIBMBaseTableViewController

@property (nonatomic, strong) EIBMForumListModel *model;

@property (nonatomic, copy) void(^delSuccess)();

@end

NS_ASSUME_NONNULL_END
