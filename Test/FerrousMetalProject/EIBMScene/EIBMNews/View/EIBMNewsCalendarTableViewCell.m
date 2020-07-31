//
//  NewsCalendarTableViewCell.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 14/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMNewsCalendarTableViewCell.h"
#import "EIBMNewsCalendarModel.h"
@interface EIBMNewsCalendarTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@end

@implementation EIBMNewsCalendarTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.numberOfLines = 2;
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.backgroundColor = MainColor;
    self.typeLabel.backgroundColor = [UIColor colorWithHexString:@"f7f7f7"];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setDataWithSourceData:(EIBMNewsCalendarModel *)model {
    self.titleLabel.text = [NSString stringWithFormat:@"%@",model.content];
    self.typeLabel.text = model.announce_value;
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:model.area_img] placeholderImage:[UIImage imageNamed:IMAGENOPIC]];
    self.contentLabel.text = [NSString stringWithFormat:@"实际：--- 预期：%@ 前值：%@",model.forecast_value,model.former_value];
    
//    NSString *datastr = [NSDate datestrFromDate:[NSDate date] withDateFormat:@"yyyy-MM-dd"];
//    NSString *timeStr = [NSString stringWithFormat:@"%@ %@",datastr,model.time_str];
//    NSDate *time = [NSDate dateFromString:timeStr format:@"yyyy-MM-dd HH:mm"];
//    self.timeLabel.text = [NSDate datestrFromDate:time withDateFormat:@"MM/dd HH:mm"];
    self.timeLabel.text = model.time_str;
}

@end
