//
//  PersonCenterHeadCollectionViewCell.m
//  BusinessOfArt
//
//  Created by 董浩 on 2017/9/4.
//  Copyright © 2017年 donghao. All rights reserved.
//

#import "EIBMPersonCenterHeadCollectionViewCell.h"

@implementation EIBMPersonCenterHeadCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.headImageView.layer.cornerRadius = 35;
    self.headImageView.layer.masksToBounds = YES;
    self.nickNameLabel.textColor = [UIColor blackColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
//    
    UIImageView *bgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"vipbg"]];
    [self.contentView insertSubview:bgView atIndex:0];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-60);
    }];
}

- (void)setDataWithSourceData:(id)model{
    
    EIBMUser *user = [EIBMUserUtil sharedUserUtil].user;
    
    if (user) {
        if ([EIBMUserUtil sharedUserUtil].user.headerImageData ) {
            [self.headImageView setImage:[UIImage imageWithData:[EIBMUserUtil sharedUserUtil].user.headerImageData]];
        } else {
            [self.headImageView setImage:[UIImage imageNamed:@"eibm_person_touxiang"]];
        }
        self.nickNameLabel.text = [NSString stringWithFormat:@"%@",user.userName];
        self.remarkLabel.text = [NSString stringWithFormat:@"%@",user.remark.length>0?user.remark:@"这个人很懒，什么都没留下!"];

    }else{
        self.nickNameLabel.text = @"请登录/注册";
        [self.headImageView setImage:[UIImage imageNamed:@"eibm_person_touxiang"]];
        self.remarkLabel.text = @"";
    }
    
    
}

@end
