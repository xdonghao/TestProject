//
//  NewsTableViewCell.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 31/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMNewsTableViewCell.h"
#import "EIBMNewsModel.h"
#import "EIBMNewsOtherModel.h"
@interface EIBMNewsTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;

@end
@implementation EIBMNewsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.textColor = TitleColor;
    self.timeLabel.textColor = [UIColor lightGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (CGFloat)getCellHeightWithString:(NSString *)str {
    return 130;
}

- (void)setDataWithSourceData:(id)model {
    
    if ([model isKindOfClass:[EIBMNewsOtherModel class]]) {
        EIBMNewsOtherModel *other = (EIBMNewsOtherModel *)model;
        self.titleLabel.text = other.title;
//        self.timeLabel.text = [NSDate dateStrFromCstampTime:[other.recordDate integerValue]/1000 withDateFormat:@"yyyy-MM-dd hh:mm"];
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:other.imageUrl] placeholderImage:[UIImage imageNamed:IMAGENOPIC]];
    }
    if ([model isKindOfClass:[EIBMNewsModel class]]) {
        EIBMNewsModel *other = (EIBMNewsModel *)model;
        self.titleLabel.text = other.title;
//        self.timeLabel.text = other.createTime;
        [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:other.cover] placeholderImage:[UIImage imageNamed:IMAGENOPIC]];
    }
}

@end
