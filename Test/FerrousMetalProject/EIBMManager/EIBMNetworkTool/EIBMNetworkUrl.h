//
//  NetworkUrl.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 01/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/** 快讯接口 */
FOUNDATION_EXPORT NSString * const NEWS_KuaiXun;

/** 期货接口 */
FOUNDATION_EXPORT NSString * const NETWORK_QiHuo;

/** K线图接口 */
FOUNDATION_EXPORT NSString * const NETWORK_KLine;

FOUNDATION_EXPORT NSString * const Project;

@interface EIBMNetworkUrl : NSObject

@end

NS_ASSUME_NONNULL_END
