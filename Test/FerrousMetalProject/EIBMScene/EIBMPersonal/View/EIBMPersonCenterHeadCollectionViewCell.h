//
//  PersonCenterHeadCollectionViewCell.h
//  BusinessOfArt
//
//  Created by 董浩 on 2017/9/4.
//  Copyright © 2017年 donghao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EIBMBaseCollectionViewCell.h"
@interface EIBMPersonCenterHeadCollectionViewCell : EIBMBaseCollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nickNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;

@end
