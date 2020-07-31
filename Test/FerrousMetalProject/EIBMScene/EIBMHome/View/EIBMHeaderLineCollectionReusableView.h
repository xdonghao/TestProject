//
//  HeaderLineCollectionReusableView.h
//  BusinessOfArt
//
//  Created by 董浩 on 2017/9/4.
//  Copyright © 2017年 donghao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EIBMHeaderLineCollectionReusableView : UICollectionReusableView
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *moreLabel;
@property (nonatomic, strong) UIButton *expandButton;
@property (nonatomic, strong)UILabel *bottomLine;
@property (nonatomic, strong)UIImageView *leftLabel;
@property (nonatomic,copy) void(^moreBlock)();
@end
