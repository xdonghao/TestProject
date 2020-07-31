//
//  PublishForumViewController.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseViewController.h"
#import "EIBMForumListModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMPublishForumViewController : EIBMBaseViewController

//是发布文章还是回复文章
@property (nonatomic, assign) BOOL isPublish;

//若为回复需穿文章ID， 发布则不传
@property (nonatomic, copy) NSNumber *articleId;

@property (nonatomic, copy) void(^success)(EIBMForumListModel *model);

@end

NS_ASSUME_NONNULL_END
