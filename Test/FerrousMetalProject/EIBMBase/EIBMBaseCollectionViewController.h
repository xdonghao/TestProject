//
//  BaseCollectionViewController.h
//  BusinessOfArt
//
//  Created by 董浩 on 2017/9/6.
//  Copyright © 2017年 donghao. All rights reserved.
//

#import "EIBMBaseViewController.h"

@interface EIBMBaseCollectionViewController : EIBMBaseViewController <UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) UICollectionView     *myCollectionView;

- (void)headerEndRefresh;

- (void)foooterEndRefresh;
@end
