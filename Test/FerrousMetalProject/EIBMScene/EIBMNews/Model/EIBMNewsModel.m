//
//  NewsModel.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 31/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMNewsModel.h"

@implementation EIBMNewsModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{ @"mainId" : @"id",
              };
}

@end
