//
//  HomeTalkListCollectionViewCell.h
//  EIBMGoodsProject
//
//  Created by MAC on 19/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseCollectionViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMHomeTalkListCollectionViewCell : EIBMBaseCollectionViewCell
@property (nonatomic, copy) void(^success)(NSInteger index);
@property (nonatomic, strong) UIButton *joinButton;
@end

NS_ASSUME_NONNULL_END
