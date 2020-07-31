//
//  PersonalInfoDetailHeadTableViewCell.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 05/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMPersonalInfoDetailHeadTableViewCell.h"

@implementation EIBMPersonalInfoDetailHeadTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"PersonalInfoDetailHeadTableViewCell";
    EIBMPersonalInfoDetailHeadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[EIBMPersonalInfoDetailHeadTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (instancetype) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 75)];
        self.backImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.backImageView];
        
        self.iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 50, 12.5, 50, 50)];
        self.iconImageView.layer.masksToBounds = YES;
        self.iconImageView.layer.cornerRadius = 25;
        self.iconImageView.layer.borderWidth = 0.5;
//        self.iconImageView.layer.borderColor = LINECOLOR.CGColor;
        self.iconImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:self.iconImageView];
        
//        self.indicateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-22, 0, 7, 12)];
//        self.indicateImageView.center = CGPointMake(SCREEN_WIDTH-22, 75/2);
//        self.indicateImageView.image = [UIImage imageNamed:@"arrow"];
//        [self.contentView addSubview:self.indicateImageView];
        
        self.chageIconLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-37, 75)];
        self.chageIconLabel.textColor = TitleColor;
        self.chageIconLabel.font = [UIFont systemFontOfSize:14.0];
        self.chageIconLabel.textAlignment = NSTextAlignmentLeft;
        self.chageIconLabel.text = @"头像";
        [self.contentView addSubview:self.chageIconLabel];
    }
    
    return self;
}

@end
