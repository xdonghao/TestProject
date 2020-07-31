//
//  EIBMPersonalInfoRemarkTableViewCell.h
//  EIBMForwardProject
//
//  Created by MAC on 18/09/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMPersonalInfoRemarkTableViewCell : EIBMBaseTableViewCell

@property (nonatomic, strong) UITextView *text;

@property (nonatomic, copy)void(^successBlock)(NSString *remark);

@end

NS_ASSUME_NONNULL_END
