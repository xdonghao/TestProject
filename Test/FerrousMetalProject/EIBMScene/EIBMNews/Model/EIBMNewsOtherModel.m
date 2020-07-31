//
//  NewsOtherModel.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMNewsOtherModel.h"

@implementation EIBMNewsOtherModel

- (BOOL)isEqual:(id)object {
    if (self == object) {
        
        return YES;
        
    }
    
    if (object ==nil){
        
        return NO;
        
    }
    
    if (![object isKindOfClass:[EIBMNewsOtherModel class]]) {
        
        return NO;
        
    }
    
    EIBMNewsOtherModel *other = object;
    
    return other.newsId != nil && [other.newsId integerValue] == [_newsId integerValue];
    
}

+ (NSDictionary *)replacedKeyFromPropertyName{
    return @{ @"newsId" : @"id",
              };
}

@end
