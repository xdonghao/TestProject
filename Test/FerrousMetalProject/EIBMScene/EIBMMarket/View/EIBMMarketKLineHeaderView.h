//
//  MarketKLineHeaderView.h
//  ZhiXuanQiHuo
//
//  Created by MAC on 02/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MarketKLineDelegate <NSObject>
@optional
- (void)kLineViewDidSelesctedIndex:(KLineStyle)style currentIndex:(NSInteger)currentIndex;
@end

@interface EIBMMarketKLineHeaderView : UITableViewHeaderFooterView

@property (nonatomic, weak) id<MarketKLineDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
