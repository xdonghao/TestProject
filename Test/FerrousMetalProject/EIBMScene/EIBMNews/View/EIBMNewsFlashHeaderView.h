//
//  NewsFlashHeaderView.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 04/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EIBMNewsFlashModel.h"
typedef void(^headerViewExpandBlock)(BOOL isExpanded);
NS_ASSUME_NONNULL_BEGIN

@interface EIBMNewsFlashHeaderView : UITableViewHeaderFooterView

@property (nonatomic, copy) headerViewExpandBlock expandCallback;
@property (nonatomic, strong) EIBMNewsFlashModel *model;
@property (nonatomic, copy) NSString *title;

@end

NS_ASSUME_NONNULL_END
