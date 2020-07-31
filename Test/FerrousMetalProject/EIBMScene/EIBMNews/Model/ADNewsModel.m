//
//  NewsModel.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 31/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "SYZNewsModel.h"

@implementation SYZNewsModel

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{ @"mainId" : @"id",
              };
}

@end
