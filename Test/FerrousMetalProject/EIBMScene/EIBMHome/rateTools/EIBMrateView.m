//
//  rateView.m
//  BlackIronProject
//
//  Created by mac on 2019/8/22.
//  Copyright © 2019 mac. All rights reserved.
//

#import "EIBMrateView.h"
#import "EIBMSHImarketLandCell.h"
#import "EIBMXMWGToolsModel.h"
#import "EIBMRateToolDetailVC.h"
#import "EIBMGoodsListReusableView.h"
@interface EIBMrateView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, strong)NSMutableArray *dataSource;
@property (nonatomic ,strong)NSMutableArray *imgArr;
@property (nonatomic ,strong)NSMutableArray *dataArr;
@property (nonatomic ,strong) EIBMXMWGToolsModel *toolsModel;

@end

@implementation EIBMrateView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = [NSMutableArray array];
        [self bc_createUI];
    }
    return self;
}
-(EIBMXMWGToolsModel *)toolsModel
{
    if (!_toolsModel) {
        _toolsModel = [[EIBMXMWGToolsModel alloc] init];
    }
    return _toolsModel;
}
-(NSMutableArray *)imgArr
{
    if (!_imgArr) {
        _imgArr = [NSMutableArray array];
    }
    return _imgArr;
}
-(NSMutableArray *)dataArr
{
    if (!_dataArr) {
        _dataArr = [NSMutableArray array];
    }
    return _dataArr;
}
- (void)bc_createUI
{
    [self addSubview:self.collectionView];
    [self bc_loadData];
}

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
        layout.itemSize = CGSizeMake(SCREEN_WIDTH, 50);
        layout.sectionInset = UIEdgeInsetsMake(0,0, 0, 0);
        layout.headerReferenceSize = CGSizeMake(SCREEN_WIDTH, 50);

//        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.bounds collectionViewLayout:layout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = LLBackGroundWhiteColor;
        [_collectionView registerNib:[UINib nibWithNibName:@"SHImarketLandCell" bundle:nil] forCellWithReuseIdentifier:@"SHImarketLandCell"];
         [_collectionView registerNib:[UINib nibWithNibName:@"GoodsListReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GoodsListReusableView"];
    }
    return _collectionView;
}

- (void)bc_loadData
{
    self.dataSource = [NSMutableArray arrayWithArray:self.toolsModel.titleArr];
    self.imgArr = [NSMutableArray arrayWithArray:self.toolsModel.imgArr];
    self.dataArr = [NSMutableArray arrayWithArray:self.toolsModel.styleArray];
}

#pragma mark -- collectionview代理
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    EIBMRateToolDetailVC *detail = [[EIBMRateToolDetailVC alloc] init];
    detail.styleArr = self.dataArr[indexPath.row];
    detail.titlestr = self.dataSource[indexPath.row];
    [self.vc.navigationController pushViewController:detail animated:YES];

//    [self responderWithName:@"tool" userInfo:@{@"index":[NSString stringWithFormat:@"%ld",indexPath.row]}];
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    EIBMSHImarketLandCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"SHImarketLandCell" forIndexPath:indexPath];
    cell.imgView.image = [UIImage imageNamed:self.imgArr[indexPath.row]];
    cell.titleLabel.text = self.dataSource[indexPath.row];
    cell.backgroundColor = UIColor.cyanColor;
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    EIBMGoodsListReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"GoodsListReusableView" forIndexPath:indexPath];

    return header;
}

@end
