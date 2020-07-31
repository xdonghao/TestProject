//
//  MarketKLineTableViewCell.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 01/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMMarketKLineTableViewCell.h"
#import "KLineDataProcess.h"

@interface EIBMMarketKLineTableViewCell ()


@end

@implementation EIBMMarketKLineTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configUI {
    [self.self.contentView addSubview:self.simpleKLineView];
}

- (SimpleKLineVolView *)simpleKLineView {
    if (!_simpleKLineView) {
        _simpleKLineView = [[SimpleKLineVolView alloc] initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 430)];
        [_simpleKLineView switchKLineMainViewToType:KLineMainViewTypeKLine];
    }
    return _simpleKLineView;
}

- (void)setKLineArray:(NSArray *)dataArray{
    [self.simpleKLineView.dataCenter cleanData];
    [self.simpleKLineView.dataCenter addMoreDataWithArray:dataArray isMergeModel:^BOOL(KLineModel * _Nonnull firstModel, KLineModel * _Nonnull secondModel) {
        // 如果返回YES表示需要合并，当前合并条件是两个元素的时间戳一致
        return [KLineDataProcess checkoutIsInSameTimeSectionWithFirstTime:firstModel.stamp secondTime:secondModel.stamp];
    }];
}
@end
