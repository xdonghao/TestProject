//
//  TalkListModel.h
//  EIBMGoodsProject
//
//  Created by MAC on 19/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface TalkListModel : EIBMBaseModel
/**
 标题
 */
@property (nonatomic, copy) NSString *title;


/**
 话题ID
 */
@property (nonatomic, copy) NSNumber *talkId;

/**
 话题类型
 */
@property (nonatomic, copy) NSString *type;

/**
 图片url
 */
@property (nonatomic, copy) NSString *imageUrl;

@property (nonatomic, copy) NSString *created;

@property (nonatomic, copy) NSData *imageData;
@property (nonatomic, copy) NSNumber *imageDataLength;
@end

NS_ASSUME_NONNULL_END
