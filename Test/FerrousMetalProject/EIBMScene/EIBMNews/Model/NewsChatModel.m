//
//  NewsChatModel.m
//  EIBMBestMetal
//
//  Created by MAC on 19/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "NewsChatModel.h"

@implementation NewsChatModel

- (BOOL)isEqual:(id)object {
    if (self == object) {
        
        return YES;
        
    }
    
    if (object ==nil){
        
        return NO;
        
    }
    
    if (![object isKindOfClass:[NewsChatModel class]]) {
        
        return NO;
        
    }
    
    NewsChatModel *other = object;
    
    return other.newsId != nil && [other.newsId integerValue] == [_newsId integerValue] && [other.userName isEqualToString:_userName] && [other.content isEqualToString:_content] && [other.userImageUrl isEqualToString:_userImageUrl] && [other.created integerValue] == [_created integerValue];
    
}

@end
