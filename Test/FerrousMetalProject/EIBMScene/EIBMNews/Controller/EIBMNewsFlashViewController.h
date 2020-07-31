//
//  NewsFlashViewController.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 04/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMBaseTableViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface EIBMNewsFlashViewController : EIBMBaseTableViewController <UINavigationControllerDelegate>

@property (nonatomic, copy) NSString *listDataJsonPath;

@property (nonatomic, assign) BOOL show;

@end

NS_ASSUME_NONNULL_END
