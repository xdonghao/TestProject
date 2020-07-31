//
//  TalkSendViewController.h
//  EIBMGoodsProject
//
//  Created by MAC on 20/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseViewController.h"
#import "TalkListModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface TalkSendViewController : EIBMBaseViewController
@property (nonatomic, copy) void(^success)(TalkListModel *model);
@end

NS_ASSUME_NONNULL_END
