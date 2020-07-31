//
//  TalkDetailModel.h
//  EIBMGoodsProject
//
//  Created by MAC on 19/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMTalkDetailModel : EIBMBaseModel

/**
 标题
 */
@property (nonatomic, copy) NSString *content;


/**
 话题ID
 */
@property (nonatomic, copy) NSNumber *talkId;

@property (nonatomic, copy) NSString *created;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *userImageUrl;

@end

NS_ASSUME_NONNULL_END
