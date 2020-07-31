//
//  NewsFarstModel.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 12/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMNewsFarstModel : EIBMBaseModel

@property (nonatomic, copy) NSString *Title;
@property (nonatomic, copy) NSNumber *UpdateTime;

@end

NS_ASSUME_NONNULL_END
