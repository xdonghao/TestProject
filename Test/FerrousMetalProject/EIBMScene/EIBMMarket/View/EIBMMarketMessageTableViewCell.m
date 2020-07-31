//
//  MarketMessageTableViewCell.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 01/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMMarketMessageTableViewCell.h"

@interface EIBMMarketMessageTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *kaiLabel;
@property (weak, nonatomic) IBOutlet UILabel *gaoLabel;
@property (weak, nonatomic) IBOutlet UILabel *shouLabel;
@property (weak, nonatomic) IBOutlet UILabel *diLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeStateLabel;

@end

@implementation EIBMMarketMessageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.kaiLabel.textColor = MainColor;
    self.gaoLabel.textColor = MainColor;
    self.shouLabel.textColor = MainColor;
    self.diLabel.textColor = MainColor;
    
    self.changeStateLabel.textColor = MainColor;
    self.changeLabel.textColor = MainColor;
    
    self.priceLabel.textColor = TitleColor;
    self.priceLabel.font = [UIFont boldSystemFontOfSize:22];
    self.kaiLabel.font = [UIFont boldSystemFontOfSize:12];
    self.gaoLabel.font = [UIFont boldSystemFontOfSize:12];
    self.shouLabel.font = [UIFont boldSystemFontOfSize:12];
    self.diLabel.font = [UIFont boldSystemFontOfSize:12];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)getCellHeightWithString:(NSString *)str {
    return 135;
}

- (void)setDataWithSourceData:(NSArray *)model {
    if (model.count == 9) {
        NSNumber *price = model[2];
        NSNumber *nuber = model[3];
        NSNumber *state = model[4];
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setPositiveFormat:@"###0.00"];
        formatter.roundingMode = NSNumberFormatterRoundDown;
        formatter.maximumFractionDigits = 2;
        self.priceLabel.text = [formatter stringFromNumber:price];
        
        
        if ([state doubleValue] > 0) {
            self.changeStateLabel.text = [NSString stringWithFormat:@"+%@%%",[formatter stringFromNumber:state]];
        } else {
            self.changeStateLabel.text = [NSString stringWithFormat:@"%@%%",[formatter stringFromNumber:state]];
        }
        if ([nuber doubleValue] > 0) {
            self.changeLabel.text = [NSString stringWithFormat:@"+%@",[formatter stringFromNumber:nuber]];
        } else {
            self.changeLabel.text = [formatter stringFromNumber:nuber];
        }
        
        
        NSNumber *kaiNumber = model[5];
        NSNumber *gaoNumber = model[6];
        NSNumber *shouNumber = model[7];
        NSNumber *diNumber = model[8];
        self.kaiLabel.text = [NSString stringWithFormat:@"%@",[formatter stringFromNumber:kaiNumber]];
        self.gaoLabel.text = [NSString stringWithFormat:@"%@",[formatter stringFromNumber:gaoNumber]];
        self.shouLabel.text = [NSString stringWithFormat:@"%@",[formatter stringFromNumber:shouNumber]];
        self.diLabel.text = [NSString stringWithFormat:@"%@",[formatter stringFromNumber:diNumber]];
    }
}

@end
