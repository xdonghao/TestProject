//
//  NewsDetailViewController.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 05/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseViewController.h"
#import "EIBMNewsOtherModel.h"
#import "EIBMNewsModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface EIBMNewsDetailViewController : EIBMBaseViewController

@property (nonatomic, strong) EIBMNewsOtherModel *model;

@property (nonatomic, strong) EIBMNewsModel *hotModel;

@end

NS_ASSUME_NONNULL_END
