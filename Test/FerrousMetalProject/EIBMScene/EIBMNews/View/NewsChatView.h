//
//  NewsChatView.h
//  EIBMBestMetal
//
//  Created by MAC on 19/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsChatView : UIView

@property (nonatomic,copy) void(^chatBlock)(NSString *content);

@end

NS_ASSUME_NONNULL_END
