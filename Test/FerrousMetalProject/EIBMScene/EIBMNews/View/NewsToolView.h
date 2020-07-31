//
//  NewsToolView.h
//  EIBMBestMetal
//
//  Created by MAC on 19/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NewsToolView : UIView

@property (nonatomic, strong)UIButton *saveButton;
@property (nonatomic,copy) void(^saveBlock)();
@property (nonatomic,copy) void(^chatBlock)();
@end

NS_ASSUME_NONNULL_END
