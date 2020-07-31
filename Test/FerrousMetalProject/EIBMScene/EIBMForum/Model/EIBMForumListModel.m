//
//  ForumListModel.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 05/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMForumListModel.h"

@implementation EIBMForumListModel

- (BOOL)isEqual:(id)object {
    if (self == object) {
        
        return YES;
        
    }
    
    if (object ==nil){
        
        return NO;
        
    }
    
    if (![object isKindOfClass:[EIBMForumListModel class]]) {
        
        return NO;
        
    }
    
    EIBMForumListModel *other = object;
    
    return other.articleId != nil && [other.articleId integerValue] == [_articleId integerValue];
    
}

@end
