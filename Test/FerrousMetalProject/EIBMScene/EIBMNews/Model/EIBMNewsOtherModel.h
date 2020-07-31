//
//  NewsOtherModel.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN
@interface EIBMNewsOtherModel : EIBMBaseModel

@property (nonatomic, copy) NSString *newsId;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageUrl;
@property (nonatomic, copy) NSString *recordDate;
@end

NS_ASSUME_NONNULL_END
