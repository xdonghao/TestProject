//
//  MarketSearchViewController.m
//  ZhiXuanQiHuo
//
//  Created by MAC on 06/08/2019.
//  Copyright © 2019 MAC. All rights reserved.
//

#import "EIBMMarketSearchViewController.h"
#import "EIBMMarketSearchTableViewCell.h"
#import "EIBMMarketSearchModel.h"
#import "EIBMNDSearchTool.h"
#import "EIBMMarketDetailViewController.h"
@interface EIBMMarketSearchViewController ()

@property (nonatomic, strong) NSMutableArray *searchDataSource;

@end

@implementation EIBMMarketSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"搜索"];
    [self setLeftButtonStyle:AAButtonStyleBack];
    self.searchBar.placeholder = @"请输入期货代码或名称";
    [self.myTableView registerNib:[UINib nibWithNibName:@"MarketSearchTableViewCell" bundle:nil] forCellReuseIdentifier:@"MarketSearchTableViewCell"];
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

+ (int)addtime:(NSString*)date{
    NSArray *arr=[date componentsSeparatedByString:@":"];
    int time_add=[[arr firstObject] intValue] * 60 * 60
    + [[arr objectAtIndex:1] intValue] * 60
    + [[arr lastObject] intValue];
    return time_add;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    EIBMMarketSearchTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MarketSearchTableViewCell" forIndexPath:indexPath];
    [cell setDataWithSourceData:[self.dataArr objectAtIndex:indexPath.row]];
    cell.bottomLine.hidden = NO;
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    EIBMMarketSearchModel *model = [self.dataArr objectAtIndex:indexPath.row];
    EIBMMarketDetailViewController *detail = [[EIBMMarketDetailViewController alloc] init];
    detail.codeString = model.code;
    detail.nameString = model.name;
    [self.navigationController pushViewController:detail animated:YES];
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchBar endEditing:YES];
    [self.view endEditing:YES];
}

- (void)searchString:(NSString *)searchText{
    self.dataArr = (NSMutableArray *)[[EIBMNDSearchTool tool] searchWithFieldArray:@[@"name",@"showCode"]
                                                                   inputString:searchText
                                                                       inArray:self.searchDataSource];
    [self.myTableView reloadData];
    
}

- (void)clearSearchText{
    [self.dataArr removeAllObjects];
    [self.dataArr addObjectsFromArray:self.searchDataSource];
    [self.myTableView reloadData];
}

- (NSMutableArray *)searchDataSource {
    if (!_searchDataSource) {
        _searchDataSource = [NSMutableArray array];
    }
    return _searchDataSource;
}

@end
