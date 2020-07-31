//
//  HomeMarketCollectionViewCell.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 02/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMMarketListListCollectionViewCell.h"

@interface EIBMMarketListListCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *numberLabel;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *changeRateLabel;

@end

@implementation EIBMMarketListListCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.priceLabel.adjustsFontSizeToFitWidth = YES;
    
//    self.bgView.layer.shadowColor = [UIColor colorWithHexString:@"f4f4f4"].CGColor;
//    self.bgView.layer.shadowOffset = CGSizeMake(2,2);
//    self.bgView.layer.shadowOpacity = 1;
//    self.bgView.layer.shadowRadius = 2;
//    self.bgView.backgroundColor = [UIColor colorWithHexString:@"f4f4f4"];
//    self.bgView.layer.borderWidth = 1;
//    self.bgView.layer.borderColor = [UIColor colorWithHexString:@"f4f4f4"].CGColor;
//    self.bgView.layer.cornerRadius = 2;
//    self.bgView.layer.masksToBounds = YES;
//    self.bgView.clipsToBounds = NO;
    
    
//    self.bgView.backgroundColor = DYUIColor([UIColor colorWithHexString:@"FFFFFF"], [UIColor colorWithHexString:@"000000"]);
//    self.contentView.backgroundColor = DYUIColor([UIColor colorWithHexString:@"FFFFFF"], [UIColor colorWithHexString:@"000000"]);
    self.bgView.backgroundColor = kWhiteColor;
    self.contentView.backgroundColor = kWhiteColor;
    self.nameLabel.textColor = TitleColor;
    self.nameLabel.adjustsFontSizeToFitWidth = YES;
    _line = [[UILabel alloc] init];
    [self.bgView addSubview:_line];
    _line.backgroundColor = LINECOLOR;
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView);
        make.width.mas_equalTo(0.5);
        make.top.equalTo(self.bgView.mas_top).offset(0);
        make.bottom.equalTo(self.bgView.mas_bottom).offset(-0);
    }];
    
}

+ (CGFloat)getCellHeightWithString:(NSString *)str {
    return 120;
}

- (void)setDataWithSourceData:(NSArray *)model {
    if (model.count == 5) {
        NSString *nameString = model[1];
        
        nameString = [nameString stringByReplacingOccurrencesOfString:@"期货" withString:@""];
        
        NSNumber *price = model[2];
        NSNumber *nuber = model[3];
        NSNumber *state = model[4];
        self.nameLabel.text = nameString;
        NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        [formatter setPositiveFormat:@"###0.00"];
        formatter.roundingMode = NSNumberFormatterRoundDown;
        formatter.maximumFractionDigits = 2;
        self.priceLabel.text = [formatter stringFromNumber:price];
        
        if ([nuber doubleValue]>0) {
            self.numberLabel.text = [NSString stringWithFormat:@"+%@",[formatter stringFromNumber:nuber]];
            self.numberLabel.textColor = kGreenColor;
            self.priceLabel.textColor = kGreenColor;
        } else {
            self.numberLabel.text = [formatter stringFromNumber:nuber];
            self.numberLabel.textColor = kRedColor;
            self.priceLabel.textColor = kRedColor;
        }
        
        if ([state doubleValue] > 0) {
            self.changeRateLabel.text = [NSString stringWithFormat:@"+%@%%",[formatter stringFromNumber:state]];
            self.changeRateLabel.textColor = kGreenColor;
//            [self.iconImageView setImage:[UIImage imageNamed:@"home_up"]];
        } else {
            self.changeRateLabel.text = [NSString stringWithFormat:@"%@%%",[formatter stringFromNumber:state]];
            self.changeRateLabel.textColor = kRedColor;
//            [self.iconImageView setImage:[UIImage imageNamed:@"home_down"]];
        }
    } else {
        self.nameLabel.text = @"--";
        self.priceLabel.text = @"--";
        self.numberLabel.text = @"--";
        self.changeRateLabel.text = @"--";
        
        self.numberLabel.textColor = [UIColor blackColor];
        self.changeRateLabel.textColor = [UIColor blackColor];
    }
}

@end
