//
//  NewsCalendarModel.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 14/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMNewsCalendarModel : EIBMBaseModel
@property (nonatomic, copy) NSString *announce_value;
@property (nonatomic, copy) NSString *area_img;
@property (nonatomic, copy) NSString *area_name;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *data_str;
@property (nonatomic, copy) NSString *dict_key;
@property (nonatomic, copy) NSString *forecast_value;
@property (nonatomic, copy) NSString *former_value;
@property (nonatomic, copy) NSNumber *is_emphasis;
@property (nonatomic, copy) NSString *time_str;
@end

NS_ASSUME_NONNULL_END
