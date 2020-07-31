//
//  MarketAddViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 08/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMMarketAddViewController.h"
#import "EIBMMarketSearchModel.h"
#import "EIBMNDSearchTool.h"
#import "EIBMMarketAddCollectionViewCell.h"
@interface EIBMMarketAddViewController ()

@property (nonatomic, strong) NSMutableArray *searchDataSource;
@property (nonatomic, strong) NSMutableArray *collectArray;

@end

@implementation EIBMMarketAddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"添加自选"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    
    EIBMUser *user = [EIBMUserUtil sharedUserUtil].user;
    self.collectArray = [NSMutableArray arrayWithArray:[user.collectStrings componentsSeparatedByString:@","]];
    
    self.searchBar.placeholder = @"请输入期货代码或名称";
    [self.myCollectionView registerNib:[UINib nibWithNibName:@"MarketAddCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"MarketAddCollectionViewCell"];
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"FutureCode" withExtension:@"plist"];
    //plist 文件为字典类型
    NSArray *arr=[NSArray arrayWithContentsOfURL:URL];
    
    for (NSDictionary *dic in arr) {
        NSArray *dicarr = dic[@"value"];
        for (NSDictionary *modelDic in dicarr) {
            EIBMMarketSearchModel *model = [EIBMMarketSearchModel mj_objectWithKeyValues:modelDic];
            if (model.code.length > 0) {
                NSArray *nameArray = [model.code componentsSeparatedByString:@"."];
                model.showCode = nameArray[0];
            } else {
                model.showCode = @"";
            }
            [self.searchDataSource addObject:model];
        }
    }
    [self clearSearchText];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(SCREEN_WIDTH, 65);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EIBMMarketAddCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MarketAddCollectionViewCell" forIndexPath:indexPath];
    EIBMMarketSearchModel *model = [self.dataArr objectAtIndex:indexPath.row];
    cell.titleLabel.text = model.name;
    cell.detailLabel.text = model.showCode;
    if ([self.collectArray containsObject:model.code]) {
        cell.selButton.selected = YES;
    } else {
        cell.selButton.selected = NO;
    }
    cell.bottomLine.hidden = NO;
    WEAKSELF
    [cell setSelSuccess:^(BOOL sel) {
        if (sel) { //删除
            [weakSelf delWithCode:model.code];
        } else { //添加
            [weakSelf addWithCode:model.code];
        }
    }];
    
    return cell;
}

- (void)addWithCode:(NSString *)code {
    [self.collectArray addObject:code];
    [self.myCollectionView reloadData];
    
    
    NSMutableString *muStr = [NSMutableString stringWithFormat:@""];
    for (NSInteger i = 0; i< self.collectArray.count; i++) {
        NSString *codeString = self.collectArray[i];
        if (![codeString isEqualToString:@","] && codeString.length >0) {
            [muStr appendString:codeString];
            if (i != self.collectArray.count - 1) {
                [muStr appendString:@","];
            }
        }
    }
    EIBMUser *user = [EIBMUserUtil sharedUserUtil].user;
    user.collectStrings = muStr;
    [[EIBMUserUtil sharedUserUtil] saveCache:user];
    [user update];
    [NSObject showHudTipStr:@"已添加到自选"];
}

- (void)delWithCode:(NSString *)code {
    [self.collectArray removeObject:code];
    [self.myCollectionView reloadData];
    
    NSMutableString *muStr = [NSMutableString stringWithFormat:@""];
    for (NSInteger i = 0; i< self.collectArray.count; i++) {
        NSString *codeString = self.collectArray[i];
        if (![codeString isEqualToString:@","] && codeString.length >0) {
            [muStr appendString:codeString];
            if (i != self.collectArray.count - 1) {
                [muStr appendString:@","];
            }
        }
    }
    EIBMUser *user = [EIBMUserUtil sharedUserUtil].user;
    user.collectStrings = muStr;
    [[EIBMUserUtil sharedUserUtil] saveCache:user];
    [user update];
    [NSObject showHudTipStr:@"已从自选列表删除"];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchBar endEditing:YES];
    [self.view endEditing:YES];
}

- (void)searchString:(NSString *)searchText{
    self.dataArr = (NSMutableArray *)[[EIBMNDSearchTool tool] searchWithFieldArray:@[@"name",@"showCode"]
                                                                   inputString:searchText
                                                                       inArray:self.searchDataSource];
    [self.myCollectionView reloadData];
    
}

- (void)clearSearchText{
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:self.searchDataSource];
    [self.myCollectionView reloadData];
}

- (NSMutableArray *)searchDataSource {
    if (!_searchDataSource) {
        _searchDataSource = [NSMutableArray array];
    }
    return _searchDataSource;
}

@end
