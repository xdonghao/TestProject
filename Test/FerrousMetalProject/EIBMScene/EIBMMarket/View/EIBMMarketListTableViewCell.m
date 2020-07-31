//
//  MarketListTableViewCell.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 01/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMMarketListTableViewCell.h"

@interface EIBMMarketListTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *codeLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UILabel *changeRateLabel;

@end

@implementation EIBMMarketListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.changeRateLabel.textColor = [UIColor whiteColor];
    self.priceLabel.adjustsFontSizeToFitWidth = YES;
    self.numberLabel.adjustsFontSizeToFitWidth = YES;
    self.changeRateLabel.adjustsFontSizeToFitWidth = YES;
    self.numberLabel.font = [UIFont boldSystemFontOfSize:13];
    self.changeRateLabel.layer.cornerRadius = 2;
    self.changeRateLabel.layer.masksToBounds = YES;
    
    self.contentView.backgroundColor = kWhiteColor;
    UIView *bgView = [[UIView alloc] init];
    bgView.layer.cornerRadius = 4;
    bgView.layer.masksToBounds = YES;
    bgView.backgroundColor = LLBackGroundWhiteColor;
    [self.contentView insertSubview:bgView atIndex:0];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(10);
        make.right.equalTo(self.contentView.mas_right).offset(-10);
        make.top.equalTo(self.contentView.mas_top).offset(10);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-10);
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataWithSourceData:(NSArray *)model {
    if (model.count == 5) {
        NSString *codeString = model[0];
        NSString *nameString = model[1];
        NSNumber *price = model[2];
//        NSNumber *nuber = model[3];
        NSNumber *state = model[4];
        if (codeString.length > 0) {
            NSArray *nameArray = [codeString componentsSeparatedByString:@"."];
            self.codeLabel.text = nameArray[0];
        } else {
            self.codeLabel.text = @"";
        }
        self.nameLabel.text = nameString;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setPositiveFormat:@"###0.00"];
        formatter.roundingMode = NSNumberFormatterRoundDown;
        formatter.maximumFractionDigits = 2;
        self.priceLabel.text = [formatter stringFromNumber:price];
//        self.numberLabel.text = [formatter stringFromNumber:nuber];
        
//        self.priceLabel.text = @"";
//        self.numberLabel.text = [formatter stringFromNumber:price];
        self.changeRateLabel.text = [NSString stringWithFormat:@"%@%%",[formatter stringFromNumber:state]];
        if ([state doubleValue] > 0) {
            self.changeRateLabel.backgroundColor = kGreenColor;
            self.priceLabel.textColor = kGreenColor;
        } else {
            self.changeRateLabel.backgroundColor = kRedColor;
            self.priceLabel.textColor = kRedColor;
        }
    }
}

+ (CGFloat)getCellHeightWithString:(NSString *)str {
    return 80;
}

@end
