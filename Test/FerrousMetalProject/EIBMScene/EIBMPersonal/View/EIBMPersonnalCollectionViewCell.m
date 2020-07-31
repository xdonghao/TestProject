//
//  PersonnalCollectionViewCell.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 30/07/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMPersonnalCollectionViewCell.h"

@interface EIBMPersonnalCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *arrowImageView;
@property (weak, nonatomic) IBOutlet UIView *bgView;

@end

@implementation EIBMPersonnalCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.titleLabel.textColor = TitleColor;
    self.arrowImageView.hidden = YES;
//    self.bgView.layer.cornerRadius = 4;
//    self.bgView.layer.masksToBounds= YES;
    self.bgView.backgroundColor = kWhiteColor;
}

- (void)setDataWithTitle:(NSString *)title imageName:(NSString *)imageName {
    self.titleLabel.text = title;
    self.headImageView.image = [UIImage imageNamed:imageName];
}

@end
