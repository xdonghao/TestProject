//
//  AdScrollCollectionViewCell.m
//  BusinessOfArt
//
//  Created by 董浩 on 2017/9/4.
//  Copyright © 2017年 donghao. All rights reserved.
//

#import "EIBMAdScrollCollectionViewCell.h"
#import "SDCycleScrollView.h"
#import "EIBMNewsDetailViewController.h"
#import "EIBMCustomButton.h"

//更多对外开放期货品种在途引入外资并非核心目标
//http://efn.htmt168.com/2019/08-13/9093.html


//多头攻势猛烈金价升上1520关口再创逾六年来新高
//http://efn.htmt168.com/2019/08-13/9090.html

//经济放缓忧虑限制上行空间油价周一小幅走高
//http://efn.htmt168.com/2019/08-13/9084.html

@interface EIBMAdScrollCollectionViewCell ()<SDCycleScrollViewDelegate>
@property (strong, nonatomic)SDCycleScrollView *adScrollView;
@property (strong, nonatomic)NSArray *listArray;
@end

@implementation EIBMAdScrollCollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI{
    self.adScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"nopic"]];
    self.adScrollView.localizationImageNamesGroup = @[@"nopic"];
    self.adScrollView.autoScrollTimeInterval = 5.;
    // 自动滚动时间间隔
    self.adScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    
    self.adScrollView.pageControlStyle = SDCycleScrollViewPageContolStyleClassic;
    self.adScrollView.currentPageDotColor = [UIColor whiteColor];
//    self.adScrollView.layer.cornerRadius = 4;
//    self.adScrollView.layer.masksToBounds = YES;
    [self.contentView addSubview:self.adScrollView];
    
    
//    UIView *bgView = [[UIView alloc] init];
//    bgView.backgroundColor = LLBackGroundWhiteColor;
//    bgView.layer.cornerRadius = 2;
//    bgView.layer.masksToBounds = YES;
//    [self.contentView addSubview:bgView];
//    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView.mas_left).offset(0);
//        make.right.equalTo(self.contentView.mas_right).offset(0);
//        make.height.mas_equalTo(70);
//        make.bottom.equalTo(self.contentView.mas_bottom).offset(0);
//    }];
//    NSArray *title = @[@"期货学堂",@"工具",@"专家课堂",@"自选"];
//    for (NSInteger i = 0; i<4; i++) {
//        CGFloat x = i*(SCREEN_WIDTH-20)/4;
//        UIButton *button = [[EIBMCustomButton alloc] initWithFrame:CGRectMake(x, 0, (SCREEN_WIDTH)/4, 70)];
//        NSString *name = [NSString stringWithFormat:@"home_item_%ld",i];
//        [button setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
//        [button setTitle:title[i] forState:UIControlStateNormal];
//        button.tag = 100 + i;
//        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
//        [bgView addSubview:button];
//    }
    
    [self.adScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).offset(0);
        make.top.equalTo(self.contentView.mas_top).offset(0);
        make.right.equalTo(self.contentView.mas_right).offset(-0);
        make.bottom.equalTo(self.contentView.mas_bottom).offset(-0);
    }];
}

- (void)buttonClick:(UIButton *)button {
//    if (button.tag == 100) {
//        [self.vc.navigationController pushViewController:[EIBMBaikeViewController new] animated:YES];
//    }else if (button.tag == 101) {
//        [self.vc.navigationController pushViewController:[EIBMRateToolVC new] animated:YES];
//    }else if (button.tag == 102) {
//        EIBMClassroomViewController *room = [EIBMClassroomViewController new];
//        [self.vc.navigationController pushViewController:room animated:YES];
//        
//    }else if (button.tag == 103) {
//        
//        [self.vc.navigationController pushViewController:[EIBMMarketMyViewController new] animated:YES];
//    }
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    if (self.vc) {
//        EIBMNewsDetailViewController *web = [[EIBMNewsDetailViewController alloc] init];
//        EIBMNewsModel *temp = [[EIBMNewsModel alloc] init];
//        temp.createTime = @"2019-01-14 15:36:53";
//        temp.cover = @"https://opal-hk.oss-cn-hongkong.aliyuncs.com/lite/1547451379270062059.jpg";
//        temp.content = @""
//        web.hotModel = temp;
//        [self.navigationController pushViewController:web animated:YES];
        
        
//        EIBMNewsOtherModel *model = [[EIBMNewsOtherModel alloc] init];
//        if (index == 0) {
//            model.title = @"两融余额增加30亿元 硬科技股再创反弹新高";
//            model.newsId = @"32189";
//            model.recordDate = @"1566383924000";
//            model.imageUrl = @"https://zixun.hsmdb.com/images/photogallery/201610/20161026163613893.jpg";
//        }
//        if (index == 1) {
//            model.title = @"科技股爆发涨停潮";
//            model.newsId = @"32182";
//            model.recordDate = @"1565599867000";
//            model.imageUrl = @"https://zixun.hsmdb.com/images/photogallery/201610/20161013162339970.jpg";
//        }
//        EIBMNewsDetailViewController *web = [[EIBMNewsDetailViewController alloc] init];
//        web.title = @"资讯详情";
//        web.model = model;
//        [self.vc.navigationController pushViewController:web animated:YES];
    }
    
}
/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
    
}

- (void)dataDidChange
{
    self.adScrollView.localizationImageNamesGroup = [NSArray arrayWithObjects:
                                                     [UIImage imageNamed:@"nopic"], nil];
}

+ (CGFloat)getCellHeightWithString:(NSString *)str {
    return 250;
}

- (void)setDataWithSourceData:(NSArray *)model{
    self.adScrollView.localizationImageNamesGroup = @[@"eibm_banner_1",@"eibm_banner_2"];
}

@end
